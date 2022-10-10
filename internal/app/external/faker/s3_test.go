package faker

import (
	"testing"

	"strings"

	"github.com/stretchr/testify/assert"
)

func TestS3FakeBucketName(t *testing.T) {
	name := Bucket().Name()
	assert.NotEmpty(t, name, name)
}

func TestS3FakeBucketNameLower(t *testing.T) {
	name := Bucket().Name()
	assert.Equal(t, strings.ToLower(name), name)
}
