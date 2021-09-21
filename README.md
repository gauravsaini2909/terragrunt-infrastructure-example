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