# Table of Contents

1. [High-level Architecture Diagram](#high-level-architecture-diagram)
2. [Components List](#components-list)
3. [Infrastructure as Code Implementation](#infrastructure-as-code-implementation) 
4. [Example Application Description](#example-application-description)
5. [Application Deployment - K8S Manifests](#application-deployment---k8s-manifests)
6. [Database and Scaling Solution](#database-and-scaling-solution)
7. [Application Scaling Options](#application-scaling-options)
8. [Security Measurements](#security-measurements)
9. [Proposed CI/CD Approaches](#proposed-cicd-approaches)
10. [Observability / Monitoring for Cluster and Application](#observability--monitoring-for-cluster-and-application)


## High-level Architecture Diagram <a name="high-level-architecture-diagram"></a>
Here is high level architechture diagram with key components. Picture made by [excalidraw](https://app.excalidraw.com/)

<img title="Diagram" alt="Diagram" src="./images/diagram.png">


## Components List <a name="components-list"></a>

- **VPC** - to provide network isolation. Single VPC used for the sake of simplicity
- **Public subnet** - enabling direct public access to the internet
- **Private subnet** - to protect vital resources from public internet access.
- **NAT gateway** - allows instances in a private subnet to connect to the internet or other AWS services, while preventing the internet from initiating connections to those instances. This enables you to maintain security by keeping instances in private subnets without direct exposure to the internet, while still allowing them to access necessary external resources.
- **EKS** - managed Kubernetes cluster within AWS. 
- **Autoscaling Group** - a logical grouping for EC2 instances as worker nodes for EKS cluster. Automatically increases or decreases the number of instances in response to demand, based on scaling policies that you define
- **ECR** - managed container registry to store container images. Besides regular repository features (like dockerhub) it provides image scanning for common vulnerabilities and/or CVEs.
- **ALB** - to provide load balancing feature and distribute traffic on Layer 7 level. It is placed in public subnet to receive incoming traffic and route it to the EKS cluster.
- **Route 53** - AWS managed DNS service with extended features like DNSSec, Healthchecks etc.
- **Security groups** - to manage inbound and outbound traffic. It plays firewall role and provides security.
- **WAF** - managed service by AWS to provide web applications security against common exploits. Can be used to create policies for filtering HTTP(S) traffic.
- **RDS** - single instance database in a separate private subnet to provide storage layer for application. 


## Infrastructure as Code Implementation <a name="infrastructure-as-code-implementation"></a>

For the cloud objects provisioning I have used Terraform and opted in for modular approach. Terraform modules allow implementation to be composed as reusable components. There are many ways to structure terraform projects. Our preferred approach is

- `iac/`
  - `envs/`
    - `dev/`
    - `prod/`
    - `staging/`
  - `modules/`
    - `autoscaling-group/`
      - `v1.0.0/`
    - `eks/`
      - `v1.0.0/`
    - `rds/`
      - `v1.0.0/`
    - `security-group/`
      - `v1.0.0/`
    - `vpc/`
      - `v1.0.0/`
            
Modules folder contains each local module and each local module is built as a wrapper on top of open-source [Terraform modules](https://registry.terraform.io/namespaces/terraform-aws-modules) provided by community. I believe leveraging open source modules is best approach for provision as they have been proven and tested by many projects and the effort to write them from absolute scratch is unnecessary. 

Let's now explain preferred module structure. In each module I am using local versioning by folder names, following semantic version. However best approach would be a separate git repos for each module and using git tags and releases as version. Each module consists of files below:

- main.tf - where the main resource definition implemented as a wrapper around open source module. I am referencing to each module release via git tag and using SSH to download when running `terraform init`.
- outputs.tf - to output (for example, to stdout) and expose values in case of cross-module references.
- providers.tf - to link references for dependencies. Always better to pinpoint specific versions.
- variables.tf - module level input variable definitions.
- CHANGELOG.md - I believe keeping a precise and "clean" changelog is better, especially if module is being used across teams. Preferred appraoch is to follow semantic versioning. More info about [changelog](https://keepachangelog.com/en/1.1.0/) and [semver](https://semver.org/)
- LICENSE.md - providing license. I assume everyone knows why to use it :)
- README.md - module level documentation is vital to showcase your users how to use module. I am using a tool called [terraform-docs](https://terraform-docs.io/) to generate documentation from module. It is handy :)

## Example Application Description <a name="example-application-description"></a>

For this task I have used an existing app which I built few years ago for learning purposes. The app is quite simple Golang api, Postgres as storage and Vue.js frontend. Both backend and frontend have been packaged as container and pushed to AWS ECR repository. Vue app container includes nginx web server to run and expose on port 80. This container will be exposed as Ingress which also include annotations to create AWS ALB via Kubernetes manifest and AWS ALB ingress controller.

## Application Deployment - K8S Manifests <a name="application-deployment---k8s-manifests"></a>

## Database and Scaling Solution <a name="database-and-scaling-solution"></a>

To keep things simple, and the cost minimal (we all know, database is expensive in cloud and everywhere :)) I have choosen a single database instance which is AWS RDS Postgres. This istance is sitting in the same VPC, single AZ (eu-central-1a) and in a private subnet. Also, security group has been added to allow inbound traffic only certain conditions, limiting protocol to be TCP, limiting IP with CIDR range and port to be 5432. However, in real world production grade systems single database instance is providing no resillency and high availability. Recommended approach is to use at least one replica (or standby). This architechture provides Redundancy, High availability, Durability and Failover/Switchover. If we check the AWS RDS page it provides 3 options when creating RDS:

- Multi-AZ DB Cluster - Creates a DB cluster with three DB instances. Each DB instance is in a different Availability Zone. A Multi-AZ DB cluster has one primary DB instance and two readable standby DB instances. Using a Multi-AZ DB cluster provides high availability, increased capacity for read workloads, and lower latency.
- Multi-AZ DB instance - Creates a primary DB instance with one standby DB instance in a different Availability Zone. Using a Multi-AZ DB instance provides high availability, but the standby DB instance doesn't support connections for read workloads.
- Single DB instance - Creates a single DB instance in single AZ with no standby instances.

The replication from main instance to the standby is async.

[Source](https://aws.amazon.com/rds/features/multi-az/)

Distributing databases across AZs provides high availability and resillency. Distributed data systems is a complex topic on itself. I highly recommend to check the book [Designing Data-Intensive Applications](https://dataintensive.net/) by Martin Klepmann for learning more on the topic. One of the greates resources imho.


## Application Scaling Options <a name="application-scaling-options"></a>

As the task description asks "The ideal application should be highly available, able to handle traffic spikes, and run on a Kubernetes platform" I'll try to explain my thoughts on making this application scalable and higly available. As we use Kubernetes as target platform with 2 worker nodes there is already high-availability provided to some extent. We have used load balancer to distribute traffic between nodes and we can scale number of pods within nodes using replicas. However for high availability and scalable systems there is more advanced approaches to be implemented. 

Modern EKS cluster autoscaling approaches include mainly one of 2 options below:

1. Cluster-Autoscaler

In order to operate with Cluster-Autoscaler we have to create EC2 Autoscaler node groups with number of EC2 instances. An Auto Scaling group is a collection of Amazon EC2 instances that are treated as a logical unit. You configure settings for a group and its instances as well as define the group’s minimum, maximum, and desired capacity. We have developed [local module](https://github.com/Bakhtiyar-Garashov/3-tier-aws-stack/tree/master/iac/modules/autoscaling-group/v1.0.0) for Auto Scaling group. It is easy task to configure launch templates for instances to be created from. After having Autoscaling Nodegroups we can deploy AWS Cluster autoscaler to our cluster so that Kubernetes manages those nodes on-demand.

2. Karpenter

Karpenter is an open-source project that provides node lifecycle management for Kubernetes clusters. It automates provisioning and deprovisioning of nodes based on the scheduling needs of pods, allowing efficient scaling and cost optimization. Main difference between Karpenter and Cluster Autoscaler is that via Karpenter, we don’t need to create dozens of node groups to achieve the goal.

For more information there is EKS best practices [guide](https://aws.github.io/aws-eks-best-practices/karpenter/)

These options above are scaling options in worker nodes level. However, Kubernetes allows to do scaling in Pod level via HPA and VPA.

- HPA (Horizontal Pod Autoscaler) - scales the number of pods based on CPU utilization metrics.
- VPA (Vertival Pod Autoscaler) - resizing each Pod's CPU and Memory resource amount.

As a miscellaneous possibility, I'd add that for static resources it is possible to distribute them via CDN (Cloudfront or Cloudflare) distribution globall so that it helps with bandwith to main application stack.

## Security Measurements <a name="security-measurements"></a>

Providing security is vital. There are many aspects that provide attack surface for the complete stack. I will try to briefly describe them

1. IAM and access management - it is cruical to protect the whole infrastructe from being vulnerable. Some principles to be followed to achieve secure system is to protect credentials, follow least privileage principle and use multiaccount setup for high level of isolation. It is not a rare case that one can forget to push his/her account credentials to remote version control system. 
2. Protecting incoming traffic from internet via AWS WAF and Shield. They provides measure against common web exploits and ddos attack. 
3. AWS Firewall security groups - to protect network level (layer 4) traffic filtering. For example, allowing only certain ports to be accessible such as 80, 443, 22 is vital.

4. Kubernetes cluster security 
  - Securing pods and nodes from vulnerabilities that may come from container images. Using image scanning is a good measure to take. ECR scanning or using open source tools such as Trivy can help
  - RBAC - Role based access control for access management within Kubernetes cluster elements. Such as who can read pod, or cluster etc.
  - Generating SBOM for container images to pin what packages and versions included into image
  - Keeping images minimal is helpful to narrow attack surface
  - Using image digest, checking integrity and protecting image repositories
  - Network level security such as TLS certificates and mTLS
  - Runtime security features can be helpful such as SELinux, SECComp
  - Keeping cluster version up-to-date to receive latest security updates and patches

5. Application security
This part is more of a responsibility on the shoulder of application developers. For example, the external dependencies and 3rd party packages are usually main source of vulnerable actions. Also, data encryption and secrets management are important. Here it is overlaping with Kubernetes approach of using and managing secrets within cluster and configs via ConfigMap. Keys (such as AWS KMS) should be rotated often, secrets management and vaults can be used like HashiCorp Vault or AWS SSM.

6. Auditing and logs, access logs, "who did what" level and network level VPC flow logs of AWS.

7. Database security is an important part. Failing to protect user data, and securing access to it can cause a big disaster. 
 
- Database credentials and roles should be well protected, IAM roles can be used for database roles within RDS
- Turn on encryption for DB instance
- SSL and TLS certificates for instance
- Network isolation via VPC and private subnets
- Security groups
- Backups
- Disaster and chaos testing
- Using database engine-specific measures for more security (example, postgres wal records backups).


## Proposed CI/CD Approach <a name="#proposed-cicd-approaches"></a>

## Observability / Monitoring for Cluster and Application <a name="observability--monitoring-for-cluster-and-application"></a>