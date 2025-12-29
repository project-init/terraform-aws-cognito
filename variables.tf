variable "environment" {
  nullable    = false
  type        = string
  description = "The environment to deploy cognito in."
}

variable "service_name" {
  nullable    = false
  type        = string
  description = "The name of the service connecting to cognito."
}

########################################################################################################################
### User Pool
########################################################################################################################

variable "enable_deletion_protection" {
  type        = bool
  description = "Whether to enable or disable deletion protection."
}

variable "user_pool_tier" {
  type        = string
  default     = "LITE"
  description = "The tier for the user pool. Must be LITE, ESSENTIALS, or PLUS."

  validation {
    condition     = contains(["LITE", "ESSENTIALS", "PLUS"], var.user_pool_tier)
    error_message = "Must be one of LITE, ESSENTIALS, or PLUS."
  }
}

variable "custom_attributes" {
  type = set(object({
    data_type = string
    mutable   = bool
    name      = string
    required  = bool
  }))
}

########################################################################################################################
### App Client
########################################################################################################################

variable "callback_urls" {
  type        = set(string)
  description = "Set of URLs allowed for callback. Needs to also be set in your google oauth app."
}

########################################################################################################################
### Identity Providers
########################################################################################################################

variable "google_auth" {
  type = object({
    client_id         = string
    client_secret     = string
    authorized_scopes = optional(string, "openid profile email")
  })
  sensitive = true
}

########################################################################################################################
### Managed Login
########################################################################################################################

variable "cognito_via_managed_login" {
  default     = false
  type        = bool
  description = "Whether to add Email/Password to the managed login screen."
}