# Terraform Associate & Cloud Security Labs

Hands-on infrastructure automation and security labs following HashiCorp Terraform standards and Zero Trust design patterns.

## Completed Labs

### 01. EC2 Provisioning (`01-ec2-provisioning`)
* Configured basic AWS provider authentication.
* Defined and provisioned AWS EC2 compute instances using HCL.
* Validated execution workflow: `terraform init` -> `terraform plan` -> `terraform apply`.
* Enforced clean teardown with `terraform destroy`.

### 02. GitHub Provider (`02-github-provider`)
* Configured the `integrations/github` provider from the Terraform Registry.
* Enforced Zero Trust credential hygiene by injecting fine-grained access tokens via process environment variables (`$env:GITHUB_TOKEN`) instead of hardcoding secrets into configuration files.
* Programmatically managed GitHub resources via API using declarative infrastructure code.
* Committed `.terraform.lock.hcl` to ensure dependency pinning and cryptographic checksum validation across environments.