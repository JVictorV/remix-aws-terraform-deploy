variable "base_url" {
  type    = string
  default = "testaws.jvictorv.top"
}

variable "bucket_name" {
  type    = string
  default = "code_bucket"
}

variable "frontend_bundle_name" {
  type    = string
  default = "frontend.zip"
}

variable "server_bundle_name" {
  type    = string
  default = "server.zip"
}
