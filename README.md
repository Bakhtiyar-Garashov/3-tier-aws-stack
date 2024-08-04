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
            
Modules folder contains each local module and each local module is built as a wrapper on top of open-source [Terraform modules](https://registry.terraform.io/namespaces/terraform-aws-modules) provided by community. I believe leveraging open source modules is best approach for provision as they have been proven and tested by many projects and the effor to write them from absolute scratch is unnecessary. 

Let's now explain preferred module structure. In each module I am using local versioning by folder names, following semantic version. However best approach would be a separate git repos for each module and using git tags and releases as version. Each module consists of files below:

- main.tf - where the main resource definition implemented as a wrapper around open source module. I am referencing to each module release via git tag and using SSH to download when running `terraform init`.
- outputs.tf - to output (for example, to stdout) and expose values in case of cross-module references.
- providers.tf - to link references for dependencies. Always better to pinpoint specific versions.
- variables.tf - module level input variable definitions.
- CHANGELOG.md - I believe keeping a precise and "clean" changelog is better, especially if module is being used across teams. Preferred appraoch is to follow semantic versioning. More info about [changelog](https://keepachangelog.com/en/1.1.0/) and [semver](https://semver.org/)
- LICENSE.md - providing license. I assume everyone knows why to use it :)
- README.md - module level documentation is vital to showcase your users how to use module. I am using a tool called [terraform-docs](https://terraform-docs.io/) to generate documentation from module. It is handy :)

## Example Application Description <a name="example-application-description"></a>
## Application Deployment - K8S Manifests <a name="application-deployment---k8s-manifests"></a>
## Database and Scaling Solution <a name="database-and-scaling-solution"></a>
## Application Scaling Options <a name="application-scaling-options"></a>
## Security Measurements <a name="security-measurements"></a>
## Proposed CI/CD Approach <a name="#proposed-cicd-approaches"></a>
## Observability / Monitoring for Cluster and Application <a name="observability--monitoring-for-cluster-and-application"></a>