<!-- markdown-link-check-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20, < 2.0 |
| aws | >= 2.51, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.51, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| tags | hadenlabs/tags/null | >=0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_aggregated](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_role\_actions | The IAM action to be granted by the AssumeRole policy | `list(string)` | <pre>[<br>  "sts:AssumeRole",<br>  "sts:TagSession"<br>]</pre> | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| instance\_profile\_enabled | Create EC2 Instance Profile for the role | `bool` | `false` | no |
| max\_session\_duration | The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours | `number` | `3600` | no |
| name | Bucket name. If provided, the bucket will be created with this name instead of generating the name from the context | `string` | n/a | yes |
| namespace | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| permissions\_boundary | ARN of the policy that is used to set the permissions boundary for the role | `string` | `""` | no |
| policy\_description | The description of the IAM policy that is visible in the IAM policy manager | `string` | `""` | no |
| policy\_documents | List of JSON IAM policy documents | `list(string)` | `[]` | no |
| principals | Map of service name as key and a list of ARNs to allow assuming the role as value (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`))) | `map(list(string))` | n/a | yes |
| role\_description | The description of the IAM role that is visible in the IAM role manager | `string` | n/a | yes |
| stage | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| use\_fullname | If set to 'true' then the full ID for the IAM role name (e.g. `[var.namespace]-[var.stage]-[var.name]`) will be used. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role |
| enabled | Enabled property of module |
| id | The stable and unique string identifying the role |
| instance\_profile | Name of the ec2 profile (if enabled) |
| name | The name of the IAM role created |
| policy | Role policy document in json format. Outputs always, independent of `enabled` variable |
| use\_fullname | return if enabled use fullname |
<!-- END_TF_DOCS -->
<!-- markdown-link-check-enable -->