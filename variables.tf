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