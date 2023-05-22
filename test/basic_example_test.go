package test

import (
	"fmt"
	"os"
	"testing"

	TTAWS "github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/stretchr/testify/assert"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/kms"
)

func TestTerraformBasicExample(t *testing.T) {
	keyName := "terraform-test-kms-" + GetShortId()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/basic-example",
		Vars: map[string]interface{}{
			"name": keyName,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	keyArn := terraform.Output(t, terraformOptions, "key_arn")
	assert.NotEmpty(t, keyArn)

	keyId := terraform.Output(t, terraformOptions, "key_id")
	assert.NotEmpty(t, keyId)

	aliasArn := terraform.Output(t, terraformOptions, "alias_arn")
	assert.NotEmpty(t, aliasArn)

	aliasName := terraform.Output(t, terraformOptions, "alias_name")
	assert.NotEmpty(t, aliasName)

	sess, err := NewSession(os.Getenv("AWS_REGION"))
	assert.NoError(t, err)

	client := kms.New(sess)

	input := &kms.DescribeKeyInput{KeyId: &keyId}
	output, err := client.DescribeKey(input)
	assert.NoError(t, err)

	assert.NotEmpty(t, output.KeyMetadata)

	aliasInput := &kms.ListAliasesInput{KeyId: aws.String(keyId)}
	aliasOutput, err := client.ListAliases(aliasInput)
	assert.NoError(t, err)

	assert.Equal(t, 1, len(aliasOutput.Aliases))
	assert.Equal(t, fmt.Sprintf("alias/%s", keyName), aws.StringValue(aliasOutput.Aliases[0].AliasName))
}

func NewSession(region string) (*session.Session, error) {
	sess, err := TTAWS.NewAuthenticatedSession(region)
	if err != nil {
		return nil, err
	}

	return sess, nil
}

func GetShortId() string {
	githubSha := os.Getenv("GITHUB_SHA")
	if len(githubSha) >= 7 {
		return githubSha[0:6]
	}

	return "local"
}
