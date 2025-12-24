# Project Init AWS Cognito

## Quick Start

1. `mise format`
2. `mise docs`

## Usage

Check our [Examples](examples) for full usage information.

## Useful Docs

* [Code of Conduct](./CODE_OF_CONDUCT.md)
* [Contribution Guide](./CONTRIBUTING.md)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.81.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.81.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_provider.google](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_user_pool.user_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.user_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.user_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_callback_urls"></a> [callback\_urls](#input\_callback\_urls) | Set of URLs allowed for callback. Needs to also be set in your google oauth app. | `set(string)` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Whether to enable or disable deletion protection. | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy cognito in. | `string` | n/a | yes |
| <a name="input_google_auth"></a> [google\_auth](#input\_google\_auth) | n/a | <pre>object({<br/>    client_id         = string<br/>    client_secret     = string<br/>    authorized_scopes = optional(string, "openid profile email")<br/>  })</pre> | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service connecting to cognito. | `string` | n/a | yes |
| <a name="input_user_pool_tier"></a> [user\_pool\_tier](#input\_user\_pool\_tier) | The tier for the user pool. Must be LITE, ESSENTIALS, or PLUS. | `string` | `"LITE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The ID of the client for the user pool. |
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | The ID of the user pool. |
<!-- END_TF_DOCS -->