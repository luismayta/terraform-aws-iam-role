package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-aws-iam-role/internal/app/external/faker"
	"github.com/hadenlabs/terraform-aws-iam-role/internal/testutil"
)

func TestBasicSuccess(t *testing.T) {
	t.Parallel()

	tags := map[string]interface{}{
		"tag1": "tags1",
	}
	namespace := testutil.Company
	stage := testutil.Stage
	name := faker.Bucket().Name()
	enabled := true
	policyDescription := "Allow Basic"
	roleDescription := "IAM role with permissions to basic"

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "role-basic",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"namespace":          namespace,
			"stage":              stage,
			"name":               name,
			"enabled":            enabled,
			"tags":               tags,
			"policy_description": policyDescription,
			"role_description":   roleDescription,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputID := terraform.Output(t, terraformOptions, "id")
	assert.NotEmpty(t, outputID, outputID)
}
