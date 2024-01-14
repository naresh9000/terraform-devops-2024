1) How to handle secrets in  terraform ?
   
        Ans)using of HashiCorp Vault, AWS Secrets Manager, Azure Key Vault.
            Retrieve secrets dynamically during the Terraform execution.
            Also use the dynamo Db for secret rotation .
            DynamoDB is used to keep track of rotation metadata.

3) what is resource graph in terraform ?

        Ans) resource graph refers to the representation of the infrastructure resources and their dependencies.
            Terraform uses the resource graph to determine the optimal order for creating, updating, or deleting resources.
            Resources without dependencies can be processed in parallel.Terraform uses the resource graph to parallelize the 
            execution of resource operations.
            we will use the "depends_on" meta-args .

3) We have existing terraform infra created in azure/aws,now one particular resource needs to be re-creted,whenever we do the next Apply ?

        Ans) first we taint the resource deployed and then apply again to be re-create the resource 
            **terraform taint <local-resource-name from terraform state list>  or 
              terraform apply -replace <local-resource-name from terraform state list>


4)Who creates the "terraform.tfstate.backup" file under which scenario it is created ?

        Ans) when w edo the terraform destroy,if so we are using the s3 as backend to store the state files,
          after destruction that file is created So we can use that file if any negative situations.

5)
