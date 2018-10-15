# Apptio SRE Tech Challenge

Repo containing code and assets created in order to complete the Apptio SRE interview challenge.

## Requirements

1. AWS CLI installed and configured with **default** profile, **including access key and secret**.
2. Terraform. *Note: The deployment script will assume the `terraform` binary is in your path*.
3. Docker CE installed.

## Setup and Run

Clone the repo:

`git clone git@github.com:jaymickey/apptio-challenge.git`

Execute the script:

- `deptool.sh deploy` - Deploy or update the application.
- `deptool.sh kill` - Kill the application and all related infrastructure.