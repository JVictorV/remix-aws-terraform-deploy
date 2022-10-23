locals {
  server_file_path    = "../server/build/index.js"
  frontend_files_path = "../public"
}

data "archive_file" "server_zip" {
  type        = "zip"
  source_file = "${path.module}/${local.server_file_path}"
  output_path = "${path.module}/files/${var.server_bundle_name}"
}

data "archive_file" "frontend_zip" {
  type        = "zip"
  source_dir  = "${path.module}/${local.frontend_files_path}"
  output_path = "${path.module}/files/${var.frontend_bundle_name}"
}
