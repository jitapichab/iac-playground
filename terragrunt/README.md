# Terragrunt

## Instructions

* This project uses a remote state stored in S3, which you can find configured in **aws/providers.hcl**.

* Ensure you have the following environment variables set:
  - `BUCKET_NAME` (the name of the bucket to store the remote state)
  - `WHITELIST_IP` (your public CIDR to access the EKS cluster)

* To launch the project, execute the following command:
  ```sh
  terragrunt --terragrunt-tfpath /usr/local/bin/tofu run-all apply```

## Contributions

If you want to add more components to the infrastructure, feel free to create additional directories for the infrastructure components you wish to add