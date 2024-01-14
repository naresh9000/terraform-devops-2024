data "terraform_remote_state" "base-infra-state" {
  backend = "s3"
  config = {
    bucket = "devops-state-store"
    key    = "workspace.tfstate"
    region = "ap-south-2"
  }
}
