# ansible-6
ANSIBLE

Terraform Workspaces(env)
dev
pre-prod
prod
--
it prompts in which env need to deploy the infra...
Already state file is loacted in the s3,so in order for other projects we are re-configuring the state file within the same backend s3 bucket...

-- terraform init -reconfigure
--  terraform fmt;terraform validate;terraform apply 		  -var-file ../class-19/dev.tfvars

next 
terraform fmt;terraform validate;terraform apply 		  -var-file ../class-19/pre-prod.tfvars
here it will replace the existing dev env infra with pre-prod infra as state file will change the existing

but our requirement is to create infra separately...for all env..
creating workspaces for different environements

terraform workspace list -- list out the default workspace
terraform workspace new dev   -- new env-dev will be created
terraform workspace new pre-prod
terraform workspace new prod

::note::
workspace will isolate their states with state file diffrently...

::
 terraform workspace select dev--  Switched to workspace "dev".
-- terraform apply -var-file ./class-19/dev --auto-approve
--

Note::
workspace will be used mostly for pre-prod and prod env because same no of servers requirement will be...
pre-prod -5
prod  - 5
