locals {
  frontend_files_path = "${path.module}/../public/"
}

module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = local.frontend_files_path
}
