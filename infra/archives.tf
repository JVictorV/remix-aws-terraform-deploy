locals {
  server_file_path = "../server/build/index.js"
}

data "archive_file" "server_zip" {
  type        = "zip"
  source_file = "${path.module}/${local.server_file_path}"
  output_path = "${path.module}/files/${var.server_bundle_name}"
}
