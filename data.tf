data "aws_iam_policy_document" "assume_role" {
  count = length(keys(local.outputs.principals))

  statement {
    effect  = "Allow"
    actions = local.outputs.assume_role_actions

    principals {
      type        = element(keys(local.outputs.principals), count.index)
      identifiers = local.outputs.principals[element(keys(local.outputs.principals), count.index)]
    }
  }
}
