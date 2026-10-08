# Terraform Associate & Cloud Security Labs

Hands-on infrastructure automation and security labs following HashiCorp Terraform standards and Zero Trust design patterns.

---

## 📂 Lab Index & Navigation

| Module | Focus Area |
| :--- | :--- |
| [**01. EC2 Provisioning**](./01-ec2-provisioning) | AWS compute lifecycle & baseline HCL deployment |
| [**02. GitHub Provider**](./02-github-provider) | API resource management & Zero Trust credential injection |
| [**03. IAM User**](./03-iam-user) | Least-privilege identity & access policies |
| [**04. Provider Versioning**](./04-provider-versioning) | Pessimistic constraint pinning (`~>`) & dependency lockfiles |
| [**05. Security Groups & Rule Decoupling**](./05-firewall-provision) | Standalone rule resources & dynamic data lookups |
| [**06. Elastic IP Creation**](./06-elastic-ip-creation) | VPC-scoped static IPs & configuration drift remediation |

---

## 🛠️ Architecture & Concepts Demonstrated

### [01. EC2 Provisioning](./01-ec2-provisioning)
* Configured basic AWS provider authentication.
* Defined and provisioned AWS EC2 compute instances using HCL.
* Validated execution workflow: `terraform init` -> `terraform plan` -> `terraform apply`.
* Enforced clean teardown with `terraform destroy`.

### [02. GitHub Provider](./02-github-provider)
* Configured the `integrations/github` provider from the Terraform Registry.
* Enforced Zero Trust credential hygiene by injecting fine-grained access tokens via process environment variables (`$env:GITHUB_TOKEN`) instead of hardcoding secrets into configuration files.
* Programmatically managed GitHub resources via API using declarative infrastructure code.
* Committed `.terraform.lock.hcl` to ensure dependency pinning and cryptographic checksum validation across environments.

### [03. IAM User](./03-iam-user)
* Programmatically declared and provisioned AWS Identity and Access Management (IAM) user identities via HCL.
* Enforced least-privilege principles and baseline identity governance using declarative infrastructure definitions.
* Validated target resource states and managed teardown via state tracking and clean resource destruction.

### [04. Provider Versioning](./04-provider-versioning)
* Defined explicit version constraints using the pessimistic constraint operator (`~> 5.0`) to prevent breaking API drift across major provider releases.
* Executed dependency upgrades via `terraform init -upgrade` to resolve and bind the latest compliant release (`v5.100.0`).
* Enforced Git tracking of `.terraform.lock.hcl` to validate cryptographic provider hashes and guarantee deterministic execution across CI/CD environments.

### [05. Security Groups & Rule Decoupling](./05-firewall-provision)
Demonstrates provisioning AWS Security Groups and attaching discrete ingress/egress rules using modern standalone rule resources (`aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule`).

* **Rule Decoupling:** Uses standalone rule resources instead of inline security group rule blocks, preventing circular dependencies and state drift when managing complex rule sets across multiple teams.
* **Dynamic Data Source Lookup:** Utilizes `data.aws_security_group.default` to query existing VPC infrastructure at runtime, eliminating brittle hardcoded resource IDs and keeping configurations fully portable across AWS accounts.
* **Resource Referencing (HCL2):** Dynamically binds egress rules directly to the managed security group resource (`aws_security_group.allow_tls.id`) to ensure correct resource graph creation ordering.
* **Verification & State Management:** Verified provider execution in `us-east-1` and validated dynamic security group resolution and lifecycle replacement via `terraform plan` and `terraform apply`.

### [06. Elastic IP Lifecycle & Drift Remediation](./06-elastic-ip-creation)
* Declared and provisioned an AWS Elastic IP (`aws_eip`) allocated for VPC domain scope.
* Managed teardown reconciliation via `terraform destroy` and diagnosed zero-object destruction caused by out-of-band console releases (configuration drift).
* Automated interface documentation generation using `terraform-docs` to track provider bindings and managed resource types.