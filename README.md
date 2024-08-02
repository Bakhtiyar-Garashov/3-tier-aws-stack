# 3-tier-aws-stack

1. High-level arhitechture diagram
2. Components list (vital elements kept for brevity)
3. Infrastructure as Code implementation
   - Why Terraform
   - Module development cons
   - Using open source available modules
   - What local modules I built
   - Module versioning preferred approach
4. Example application description
    - Frontend
    - Backend
5. Application deployment - K8S manifests
    - Backend
    - Frontend as ingress
    - AWS ALB ingress via annotated resource
6. Database and scaling solution
    - Current simple approach
    - Future works for high availability
7. Application scaling options
    - EKS Cluster autoscaling options
    - Simpler approach - Autoscale Nodegroups (ASG)
    - Karpenter
    - Pod autoscaling possibilities
        - Horizontal Pod Autoscaler (HPA)
        - Vertical Pod Autoscaler (VPA)
    - CDN distribution possibility
7. Security measurements
    - IAM, Access control
        - Least privileage
        - Multi-account environment
    - AWS WAF
    - ALB security
    - AWS security groups
    - K8S security
        - Securing cluster
            - Updates, patches
        - Securing worker nodes
        - RBAC
        - Container images security
            - Scanning vulnerabilities
            - Creating SBOM
            - Optimized and minimal images
            - Up-to-date packages within images
            - Check artifact integrity
            - Protect registry for images
        - Network security and Network policies
            - mTLS
        - Secrets
        - Runtime security
            - SELinux
            - Seccomp
    - Database security

8. Proposed CI/CD approaches
9. Observability / monitoring for cluster and application