# DevOps_Demo
Test Out Terraform

This script helps in creating AWS VPC with Public and Private Subet using Terraform

Step 1: Add AWS Access Key and AWS Secret Key in variables.tf (line 6 and 9)

Step 2: Initailize Terraform

`terraform init`

Step 3: Dry Run

`terraform plan`

Step 4: Execute Plan

`terraform apply`
(enter yes when prompted)

Plan can be reverted using following command

`terraform destroy`
