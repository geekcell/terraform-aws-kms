/**
 * # Terraform AWS KMS Module
 *
 * Terraform module which creates a KMS key and an alias that belongs to it.
 * The focus on this module lies within it's simplicity by providing default values
 * that should make sense for most use cases.
 */
resource "aws_kms_key" "main" {
  description              = format("Customer Managed Key for %s", var.description)
  customer_master_key_spec = var.customer_master_key_spec
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  key_usage                = var.key_usage
  multi_region             = var.multi_region
  policy                   = var.policy

  tags = var.tags
}

resource "aws_kms_alias" "main" {
  name          = var.alias
  target_key_id = aws_kms_key.main.id
}
