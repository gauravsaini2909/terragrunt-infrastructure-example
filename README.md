# terragrunt-infrastructure-example

Terragrunt is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state.

To use it, you:

[Install Terraform.](https://learn.hashicorp.com/tutorials/terraform/install-cli)

[Install Terragrunt.](https://terragrunt.gruntwork.io/docs/getting-started/install/)

Put your Terragrunt configuration in a terragrunt.hcl file. You’ll see several example configurations shortly.

Now, instead of running terraform directly, you run the same commands with terragrunt:

```
terragrunt plan
terragrunt apply
terragrunt output
terragrunt destroy
```

Terragrunt will forward almost all commands, arguments, and options directly to Terraform, but based on the settings in your terragrunt.hcl file.

To use Terragrunt, add a single terragrunt.hcl file to the root of your repo, in the terragrunt-infrastructure-example folder, and one terragrunt.hcl file in each module folder:

```
terragrunt-infrastructure-example
├── terragrunt.hcl
├── instance-1
│   ├── main.tf
│   └── terragrunt.hcl
└── instance-2
    ├── main.tf
    └── terragrunt.hcl
```

Now you can define your backend configuration just once in the root terragrunt.hcl file:
```
# terragrunt-infrastructure-example/terragrunt.hcl
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "my-terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
```

The terragunt.hcl files also use the same configuration as Terrafom (HCL) and the configuration is more or less the same as the backend configuration we had in each module, except that the key value is now using the path_relative_to_include() built-in function, which will automatically set key to the relative path between the root terragrunt.hcl and the child module (so your Terraform state folder structure will match your Terraform code folder structure, which makes it easy to go from one to the other).

The generate attribute is used to inform Terragrunt to generate the Terraform code for configuring the backend. When you run any Terragrunt command, Terragrunt will generate a backend.tf file with the contents set to the terraform block that configures the s3 backend, just like what we had before in each main.tf file.

The final step is to update each of the child terragrunt.hcl files to tell them to include the configuration from the root terragrunt.hcl:
```
# terragrunt-infrastructure-example/instance-2/terragrunt.hcl
include "root" {
  path = find_in_parent_folders()
}
```
The find_in_parent_folders() helper will automatically search up the directory tree to find the root terragrunt.hcl and inherit the remote_state configuration from it.

Now, we can deploy modules from the root level instead of going inside of each moudule and deploying it.

Terragrunt commands if we want to deploy all from root level.\
```
terragrunt run-all plan
terragrunt run-all apply
terragrunt run-all destroy
```