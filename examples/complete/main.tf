module "cognito" {
  source = "project-init/cognito/aws"
  # Project Init recommends pinning every module to a specific version
  # version = "vX.X.X"

  environment                = "environment"
  service_name               = "service_name"
  enable_deletion_protection = true

  custom_attributes = [
    {
      data_type = "Boolean"
      name      = "variable"
      mutable   = true
      required  = false
    }
  ]

  cognito_via_managed_login = false
  google_auth = {
    client_id     = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["googleOauth2ClientId"]
    client_secret = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["googleOauth2ClientSecret"]
  }

  callback_urls = compact([
    "callback_url",
    var.add_localhost_auth_callback_url ? "localhost_callback_url" : ""
  ])
}
