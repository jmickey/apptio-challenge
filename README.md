# Apptio SRE Tech Challenge

Repo containing code and assets created in order to complete the Apptio SRE interview challenge.

## Requirements

1. AWS CLI installed and configured with **default** profile, **including access key and secret** - See [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) for details.
2. Terraform. *Note: The deployment script will assume the `terraform` binary is in your `$PATH`*.
3. Docker CE installedand running.

## Setup and Run

Clone the repo:

```bash
git clone git@github.com:jaymickey/apptio-challenge.git
```

Execute the script:

- `deptool.sh deploy` - Deploy or update the application. Terraform is idempotent, so it will only update resources as required. Docker also caches layers, so will only push a new image if there are changes. A new deployment of the container in ECS is forced as part of the script. **Note**: The service can take 1-2 minutes to start on the first deploy!
- `deptool.sh kill` - Kill the application and all related infrastructure. **WARNING:** This **WILL** destroy all the infrastructure managed by terraform with *extreme prejudice*. There is no confirmation and cancelling it will likely leave your infrastructure in an incomplete state.

## Resources

- **Terraform** - Terraform is used as the infrastucture as code solution for creating and destroying the cloud-based resources. Terraform offers a declarative syntax, and is idempotent.
- **AWS** - AWS was the chosen cloud provider. I chose this due to having great familiarity with the platform, and better support for Terraform than the alternatives. AWS also has a wide feature set and allows for global scalability.
- **Fargate** - AWS ECS & Fargate offer a simple, easily scalable solution to running applications in the cloud. The same image can be run on the developers machine and in production. Fargate also requires less overall configuration and management of infrastructure (e.g. EC2 VMs) for a slightly higher cost.

## Design & Implementation

In this solution the application is downloaded via the S3 bucket into the container and extracted. The `REDISHOST` environment variable is set to point the application to the Redis instance/cluster. Developers can use the provided `docker-compose` to test the stack locally.

Using the available `deptool.sh` deployment script, the container is deployed to AWS Elastic Container Service, as an AWS Fargate service. The deployment tool will trigger the `terraform apply` (with no confirmation); login to the Elastic Container Registry repository; build, tag, and push the image to the ECR repo; and force a deployment via the `aws ecs` CLI.

The provided `terraform` configuration will deploy the FULL environment, including: VPC, public & private subnets, internet & NAT gateways, route tables, security groups, **Redis running on ElastiCache**, ECR repo, ECS task definition & service, and application load balancer.

### Config

Developers will only need to have their AWS CLI default profile configured, `terraform` available in their `$PATH`, and the Docker CE installed.

## Improvements

- The provided `terraform` will deploy the full AWS environment. Therefore each developer would most likely require their own AWS sandbox account. This is fine for testing as part of a development workflow, but production deployments will preferably be done via a CI/CD pipeline.
- The `deptool.sh` provides little to no testing or guardrails. If something goes wrong it does not rollback gracefully, and could leave the AWs environment in an incomplete state. Again, these issues would best be dealt with via a CI/CD pipeline with Behaviour Driven Infrastructure (BDI) testing and automated rollbacks.

## Alternatives

- Cloudformation was considered over `terraform`, however cloudformation syntax is much less concise, and the feedback loop is not as rapid.
- EC2 was considered over Fargate, however this would increase the feedback time on deployments, and would introduce an inconsistency between the dev env (docker) and the deployment env (VM).
- Azure was considered over AWS, however the support for `terraform` is quite poor in comparison to AWS.