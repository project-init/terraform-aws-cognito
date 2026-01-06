output "client_id" {
  value       = aws_cognito_user_pool_client.user_pool.id
  description = "The ID of the client for the user pool."
}

output "user_pool_id" {
  value       = aws_cognito_user_pool.user_pool.id
  description = "The ID of the user pool."
}

output "endpoint" {
  value       = aws_cognito_user_pool.user_pool.endpoint
  description = "The Endpoint of the user pool."
}

output "env_variables" {
  value = [
    {
      name  = "COGNITO_CLIENT_ID"
      value = aws_cognito_user_pool_client.user_pool.id
    },
    {
      name  = "COGNITO_USER_POOL_ID"
      value = aws_cognito_user_pool.user_pool.id
    },
  ]
}