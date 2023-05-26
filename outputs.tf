output "alias_arn" {
  value       = aws_kms_alias.main.arn
  description = "Alias ARN"
}

output "alias_name" {
  value       = aws_kms_alias.main.name
  description = "Alias name"
}

output "key_arn" {
  value       = aws_kms_key.main.arn
  description = "Key ARN"
}

output "key_id" {
  value       = aws_kms_key.main.key_id
  description = "Key Id"
}
