#Stores the *.tfstate files in an object storage bucket for safekeeping and team work using a preauthenticated request. 
#First upload the tfstate file to the bucket using a preauthenticated request on the bucket: $curl -v -X <tfstate file> <bucket preauthenticated request>
#Then create a new preauthenticated request on the tfstate object that was created in the bucket and use it below
terraform {
   backend "http" {
     update_method = "PUT"
     address = "https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/lu4kyBQ0EG1z8nAhNKCIzEpn_dHGTwKUtP0WtPWuqnM/n/oracleoci/b/Terraform/o/terraform.tfstate" 
      }
}