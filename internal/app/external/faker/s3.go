package faker

import (
	"strings"

	"github.com/lithammer/shortuuid/v3"
)

type FakeS3 interface {
	Name() string // Name server
}

type fakeS3 struct{}

func Bucket() FakeS3 {
	return fakeS3{}
}

func (n fakeS3) Name() string {
	return strings.ToLower(shortuuid.New())
}
