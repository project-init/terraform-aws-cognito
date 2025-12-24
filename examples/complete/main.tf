module "cognito" {
  source = "project-init/cognito/aws"
  # Project Init recommends pinning every module to a specific version
  # version = "vX.X.X"

  environment                = "staging"
  service_name               = "business-platform"
  enable_deletion_protection = true

  google_auth = {
    client_id     = "client_id"
    client_secret = "client_secret"
  }
}
