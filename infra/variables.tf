variable "base_url" {
  type    = string
  default = "testaws.jvictorv.top"
}

variable "bucket_name" {
  type    = string
  default = "code_bucket"
}

variable "server_bundle_name" {
  type    = string
  default = "server.zip"
}

variable "stage" {
  type    = string
  default = "prod"
}

variable "bff_url" {
  type    = string
  default = "prod-bff"
}
