variable "base_url" {
  type    = string
  default = "testaws.jvictorv.top"
}

variable "log_retention_days" {
  type    = number
  default = 7
}

variable "environment" {
  type = string
  validation {
    error_message = "environment must be either production, development, staging or start with PR-"
    condition     = contains([
      "production", "development", "staging"
    ], var.environment) || startswith(var.environment, "PR-")
  }
}
