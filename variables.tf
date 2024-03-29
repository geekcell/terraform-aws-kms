# Context
variable "tags" {
  description = "Tags to add to the AWS Customer Managed Key."
  default     = {}
  type        = map(any)
}

# AWS KMS
variable "alias" {
  description = "The display name of the alias."
  type        = string
}

variable "customer_master_key_spec" {
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports."
  default     = "SYMMETRIC_DEFAULT"
  type        = string
}

variable "deletion_window_in_days" {
  description = "The waiting period, specified in number of days."
  default     = 30
  type        = number
}

variable "description" {
  description = "The description of the key as viewed in AWS console."
  default     = "Customer Managed Key"
  type        = string
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled."
  default     = true
  type        = bool
}

variable "key_usage" {
  description = "Specifies the intended use of the key."
  default     = "ENCRYPT_DECRYPT"
  type        = string
}

variable "multi_region" {
  description = "Indicates whether the KMS key is a multi-Region."
  default     = false
  type        = bool
}

variable "policy" {
  description = "A valid policy JSON document."
  default     = null
  type        = string
}
