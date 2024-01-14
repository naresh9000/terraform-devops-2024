											#Terraform Workspaces(env)#
dev
pre-prod
prod
--
user prompts in which env we need to deploy the infra...
Already state file is located in the s3,so in order for other projects we are re-configuring the state file within the same backend s3 bucket...

-- terraform init -reconfigure
--  terraform fmt;terraform validate;terraform apply -var-file ../class-19/dev.tfvars

::doing this 
terraform fmt;terraform validate;terraform apply -var-file ../class-19/pre-prod.tfvars
--here it will replace the existing dev env infra with pre-prod infra/prod-infra as state file will change the existing infra(replacement),
so in having such a concern going with the Terraform Workspaces

So requirement is to create infra separately...for all env..
creating workspaces for different environements

**terraform workspace list 	-- list out the default workspace
**terraform workspace new dev   -- new env-dev will be created
**terraform workspace new pre-prod
**terraform workspace new prod

::note::
workspace will isolate their states with state file different...

::switching of workspaces for acting on resources on diff environements

**terraform workspace select dev		--Switched to workspace "dev".
-- terraform apply -var-file ./class-19/dev --auto-approve
--

Note::
workspace will be used mostly for pre-prod and prod env because identical no of servers requirement will be requirement for the org...
pre-prod -5
prod  - 5

-------------------
#importing of state-file
------------------------
created terraform.tfvars
		sg.tf
		outputs.tf
as a admin-user creted the base infra and made use of infra for deploying the machines using the state-file rather giving the full infra code to other users who handle the infra-aws(aws cloud engineers)

::Note
Assuming we are holding all state files in a single storage account(s3), the container folder structure for the remote backend could end up looking something like the example below:

					terraformstate
					--development
					  --webapp.tfstate
					  --sqldb.tfstate
					  
					--UAT
					  --webapp.tfstate
					  --sqldb.tfstate
					 
					--production
					  --webapp.tfstate
					  --sqldb.tfstate
  
**Next---
create import.tf,provider.tf,backend.tf, by user-1(ec2-role assumed,)
terraform init -reconfigure   -- beacuse backend file is added to add the state to another file 
terraform apply -- will read and knows the state file..

admin-user-2
deploy the ec2 machine on the already deployed infra(vpc) on aws by admin user-1 based on the outputs of the existing state file in s3.

used state file data ::workspace.tfstate
new tfstate file   :: ec2.tfstate

----------------------------------------------------------
appending the infra on the existing infra of the state file.
-----------------------------------------------------------
A guide to file layout, isolation, and locking for Terraform projects

::https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa

#Adding locking using dynamodb...

create dynamodb.tf
add following in backend.tf
	--encrypt        = true
    --dynamodb_table = "terraform-dynamodb-locking"
	
terraform init -re-configure
terraform apply

terraform destroy  -- If we have a state lock terraform destroy will not be able to deploy with out access to the state lock

“If supported by your backend, Terraform will lock your state for all operations that could write state. 
This prevents others from acquiring the lock and potentially corrupting your state.So be cautious
**use this**
terraform apply -lock=false

we have the .tfstate file on Dynamodb with a Lock string. This will lock the .tfstate file to restrict multiple users’ access at a time.
