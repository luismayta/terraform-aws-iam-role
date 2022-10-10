module "tags" {
  source    = "hadenlabs/tags/null"
  version   = ">=0.2"
  namespace = local.outputs.namespace
  stage     = local.outputs.stage
  name      = local.outputs.name
  tags      = local.outputs.tags
}

locals {
  input = {
    tags                     = var.tags
    name                     = var.name
    namespace                = var.namespace
    stage                    = var.stage
    use_fullname             = var.use_fullname
    enabled                  = var.enabled
    policy_documents         = var.policy_documents
    max_session_duration     = var.max_session_duration
    permissions_boundary     = var.permissions_boundary
    role_description         = var.role_description
    policy_description       = var.policy_description
    principals               = var.principals
    assume_role_actions      = var.assume_role_actions
    instance_profile_enabled = var.instance_profile_enabled
  }

  generated = {
    tags                     = local.input.tags
    name                     = local.input.name
    namespace                = local.input.namespace
    stage                    = local.input.stage
    use_fullname             = local.input.use_fullname
    enabled                  = local.input.enabled
    policy_documents         = local.input.policy_documents
    max_session_duration     = local.input.max_session_duration
    permissions_boundary     = local.input.permissions_boundary
    role_description         = local.input.role_description
    policy_description       = local.input.policy_description
    principals               = local.input.principals
    assume_role_actions      = local.input.assume_role_actions
    instance_profile_enabled = local.input.instance_profile_enabled
  }

  outputs = {
    tags                     = local.generated.tags
    name                     = local.generated.name
    namespace                = local.generated.namespace
    stage                    = local.generated.stage
    enabled                  = local.generated.enabled
    use_fullname             = local.generated.use_fullname
    policy_documents         = local.generated.policy_documents
    max_session_duration     = local.generated.max_session_duration
    permissions_boundary     = local.generated.permissions_boundary
    role_description         = local.generated.role_description
    policy_description       = local.generated.policy_description
    principals               = local.generated.principals
    assume_role_actions      = local.generated.assume_role_actions
    instance_profile_enabled = local.generated.instance_profile_enabled
  }

  policy_document_count = length(local.outputs.policy_documents)
}

data "aws_iam_policy_document" "assume_role_aggregated" {
  count                     = local.outputs.enabled ? 1 : 0
  override_policy_documents = data.aws_iam_policy_document.assume_role.*.json
}

resource "aws_iam_role" "this" {
  depends_on = [
    module.tags,
  ]

  count                = local.outputs.enabled ? 1 : 0
  name                 = local.outputs.use_fullname ? module.tags.id_full : local.outputs.name
  assume_role_policy   = join("", data.aws_iam_policy_document.assume_role_aggregated.*.json)
  description          = local.outputs.role_description
  max_session_duration = local.outputs.max_session_duration
  permissions_boundary = local.outputs.permissions_boundary
  tags                 = local.outputs.tags
}

data "aws_iam_policy_document" "this" {
  count                     = local.outputs.enabled && local.policy_document_count > 0 ? 1 : 0
  override_policy_documents = local.outputs.policy_documents
}

resource "aws_iam_policy" "this" {
  count       = local.outputs.enabled && local.policy_document_count > 0 ? 1 : 0
  name        = local.outputs.use_fullname ? module.tags.id_full : local.outputs.name
  description = local.outputs.policy_description
  policy      = join("", data.aws_iam_policy_document.this.*.json)
  tags        = local.outputs.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = local.outputs.enabled && local.policy_document_count > 0 ? 1 : 0
  role       = join("", aws_iam_role.this.*.name)
  policy_arn = join("", aws_iam_policy.this.*.arn)
}

resource "aws_iam_instance_profile" "this" {
  count = local.outputs.enabled && local.outputs.instance_profile_enabled ? 1 : 0
  name  = local.outputs.use_fullname ? module.tags.id_full : local.outputs.name
  role  = join("", aws_iam_role.this.*.name)
}
