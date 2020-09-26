variable "create_user" {
  description = "Whether to create IAM user"
  type        = bool
  default     = true
} 

variable "name" {
  description = "Name of IAM user"
  type        = string
  default     = ""
}

variable "custom_user_policy_arns" {
  description = "List of IAM policies ARNs to attach to IAM user"
  type        = list(string)
  default     = []
}

variable "custom_user_policies" {
  description = "List of maps of inline IAM policies to attach to IAM user. Should have `name` and `policy` keys in each element."
  type        = list(map(string))
  default     = []
}
