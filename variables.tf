variable "principal_identifiers" {
  description = "The lists of identifiers of the principals to attach to the policy."
  type        = list(string)
}

variable "prefix" {
  description = "The prefix of the roles and policies to create."
  type        = string
  default     = "Observability"
}
