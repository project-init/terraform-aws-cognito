output "client_id" {
  value       = aws_cognito_user_pool_client.user_pool.id
  description = "The ID of the client for the user pool."
}

output "user_pool_id" {
  value       = aws_cognito_user_pool.user_pool.id
  description = "The ID of the user pool."
}
