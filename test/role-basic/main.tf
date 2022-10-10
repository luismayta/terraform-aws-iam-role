module "tags" {
  source    = "hadenlabs/tags/null"
  version   = ">=0.2"
  namespace = var.namespace
  stage     = var.stage
  name      = var.name
  tags      = var.tags
}

module "s3_bucket" {
  source                 = "git::https://github.com/hadenlabs/terraform-aws-s3-bucket.git?ref=0.1.0"
  acl                    = "private"
  versioning_enabled     = false
  force_destroy          = true
  allowed_bucket_actions = ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"]
  tags                   = module.tags.tags
  name                   = module.tags.id_full
  stage                  = module.tags.stage
  namespace              = module.tags.namespace
  depends_on = [
    module.tags,
  ]
}

data "aws_iam_policy_document" "base" {
  statement {
    sid = "BaseAccess"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = ["arn:aws:s3:::bucketname"]
    effect    = "Allow"
  }
}


module "main" {
  source             = "../.."
  enabled            = var.enabled
  name               = var.name
  stage              = var.stage
  namespace          = var.namespace
  tags               = module.tags.tags
  policy_description = var.policy_description
  role_description   = var.role_description
  policy_documents = [
    data.aws_iam_policy_document.base.json,
  ]
  principals = {
    Service = ["s3.amazonaws.com"]
  }
  depends_on = [
    module.tags,
    module.s3_bucket,
  ]
}
