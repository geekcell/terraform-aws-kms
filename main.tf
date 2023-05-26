/**
 * # Terraform AWS KMS Module
 *
 * Terraform module which creates a KMS key and an alias that belongs to it.
 * The focus on this module lies within it's simplicity by providing default values
 * that should make sense for most use cases.
 */
resource "aws_kms_key" "main" {
  customer_master_key_spec = var.customer_master_key_spec
  deletion_window_in_days  = var.deletion_window_in_days
  description              = var.description
  enable_key_rotation      = var.enable_key_rotation
  key_usage                = var.key_usage
  multi_region             = var.multi_region
  policy                   = var.policy

  tags = var.tags
}

resource "aws_kms_alias" "main" {
  # The name must start with alias/ followed by a name, so we remove the prefix
  # and add it again to make it optional when passing the name.
  name          = "alias/${trimprefix(var.alias, "alias/")}"
  target_key_id = aws_kms_key.main.id
}
