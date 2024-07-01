# OpenTofu

The approach to deploy this infrastructure is based on workspaces.

## Instructions

* Navigate to the directory where you want to create the infrastructure, in this case, it is **aws**.

* Execute ```tofu init```.

* Choose the workspace where you want to deploy the infrastructure. In this case, it is **iac-playground**. Use the command ```tofu workspace new iac-playground```.

* If desired, you can modify the variables in **vars/iac-playground**.

* [Optional]: Modify the backend file to create a remote state.

## Contributions

If you want to add more components to the infrastructure, adjust the counts to enable the component. This way, you can deploy the infrastructure as desired using the enabled variables.