output "frontend_zip" {
  value = data.archive_file.frontend_zip.output_path
}

output "server_zip" {
  value = data.archive_file.server_zip.output_path
}

output "main_zone" {
  value = data.aws_route53_zone.main_zone.name
}
