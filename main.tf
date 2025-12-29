locals {
  cognito_identity_providers = var.cognito_via_managed_login ? ["COGNITO"] : []
  google_identity_providers  = var.google_auth != null ? ["Google"] : []
}

resource "aws_cognito_user_pool" "user_pool" {
  name = "${var.environment}-${var.service_name}-user-pool"

  deletion_protection = var.enable_deletion_protection ? "ACTIVE" : "INACTIVE"
  user_pool_tier      = var.user_pool_tier

  // Only allow email as the username.
  username_attributes = [
    "email",
  ]
  auto_verified_attributes = [
    "email"
  ]
  username_configuration {
    case_sensitive = false
  }

  schema {
    attribute_data_type = "String"
    name                = "given_name"
    mutable             = true
    required            = true
    string_attribute_constraints {
      min_length = 2
      max_length = 50
    }
  }

  schema {
    attribute_data_type = "String"
    name                = "family_name"
    mutable             = true
    required            = true
    string_attribute_constraints {
      min_length = 2
      max_length = 50
    }
  }

  dynamic "schema" {
    for_each = var.custom_attributes
    content {
      attribute_data_type = schema.value.data_type
      name                = schema.value.name
      mutable             = schema.value.mutable
      required            = schema.value.required
    }
  }
}

resource "aws_cognito_user_pool_client" "user_pool" {
  name = "${var.environment}-${var.service_name}"

  user_pool_id = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]

  callback_urls                        = var.callback_urls
  supported_identity_providers         = concat(local.cognito_identity_providers, local.google_identity_providers)
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = var.google_auth != null ? split(" ", var.google_auth.authorized_scopes) : ["openid", "email"]
}

resource "aws_cognito_user_pool_domain" "user_pool" {
  domain       = "${var.environment}-${var.service_name}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_identity_provider" "google" {
  count = var.google_auth != null ? 1 : 0

  user_pool_id  = aws_cognito_user_pool.user_pool.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes              = var.google_auth.authorized_scopes
    attributes_url_add_attributes = true
    attributes_url                = "https://people.googleapis.com/v1/people/me?personFields="
    authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
    oidc_issuer                   = "https://accounts.google.com"
    client_id                     = var.google_auth.client_id
    client_secret                 = var.google_auth.client_secret
    token_request_method          = "POST"
    token_url                     = "https://www.googleapis.com/oauth2/v4/token"
  }

  attribute_mapping = {
    email        = "email"
    given_name   = "given_name"
    family_name  = "family_name"
    phone_number = "phoneNumbers"
    birthdate    = "birthdays"
    username     = "sub"
  }
}