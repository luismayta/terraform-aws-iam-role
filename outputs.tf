output "enabled" {
  value       = local.outputs.enabled
  description = "Enabled property of module"
}

output "name" {
  value       = local.outputs.enabled ? join("", aws_iam_role.this.*.name) : ""
  description = "The name of the IAM role created"
}

output "id" {
  value       = local.outputs.enabled ? join("", aws_iam_role.this.*.unique_id) : ""
  description = "The stable and unique string identifying the role"
}

output "arn" {
  value       = local.outputs.enabled ? join("", aws_iam_role.this.*.arn) : ""
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "policy" {
  value       = local.outputs.enabled ? join("", data.aws_iam_policy_document.this.*.json) : ""
  description = "Role policy document in json format. Outputs always, independent of `enabled` variable"
}

output "instance_profile" {
  description = "Name of the ec2 profile (if enabled)"
  value       = local.outputs.enabled ? join("", aws_iam_instance_profile.this.*.name) : ""
}

output "use_fullname" {
  value       = local.outputs.use_fullname
  description = "return if enabled use fullname"
}
