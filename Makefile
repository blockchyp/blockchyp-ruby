# Version config
TAG := $(shell git tag --points-at HEAD | sort --version-sort | tail -n 1)
LASTTAG := $(or $(shell git tag -l | sort -r -V | head -n 1),0.1.0)
SNAPINFO := $(shell date +%Y%m%d%H%M%S)git$(shell git log -1 --pretty=%h)
RELEASE := $(or $(BUILD_NUMBER), 1)
VERSION := $(or $(TAG:v%=%),$(LASTTAG:v%=%))-$(or $(BUILD_NUMBER), 1)$(if $(TAG),,.$(SNAPINFO))

# Executables
DOCKER = docker
BUNDLE = bundle
SED = sed

# Integration test config
export BC_TEST_DELAY := 5
IMAGE := circleci/ruby
SCMROOT := $(shell git rev-parse --show-toplevel)
PWD := $(shell pwd)
CACHE := $(HOME)/.local/share/blockchyp/itest-cache
CONFIGFILE := $(HOME)/.config/blockchyp/sdk-itest-config.json
CACHEPATHS := $(dir $(CONFIGFILE)) $(HOME)/.bundle
ifeq ($(shell uname -s), Linux)
HOSTIP = $(shell ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
else
HOSTIP = host.docker.internal
endif

# Default target
.PHONY: all
all: clean build test

# Clean build artifacts
.PHONY: clean
clean:
	$(RM) ./*.gem

# Build compiles the package
.PHONY: build
build:
	$(BUNDLE) exec rake build

# Runs unit tests
.PHONY: test
test:

# Runs integration tests
.PHONY: integration
integration:
	$(if $(LOCALBUILD), \
		$(BUNDLE) exec rake test $(if $(TEST),TEST=$(TEST),,), \
		$(foreach path,$(CACHEPATHS),mkdir -p $(CACHE)/$(path) ; ) \
		sed 's/localhost/$(HOSTIP)/' $(CONFIGFILE) >$(CACHE)/$(CONFIGFILE) ; \
		$(DOCKER) run \
		-u $(shell id -u):$(shell id -g) \
		-v $(SCMROOT):$(SCMROOT):Z \
		-v /etc/passwd:/etc/passwd:ro \
		$(foreach path,$(CACHEPATHS),-v $(CACHE)/$(path):$(path):Z) \
		-e BC_TEST_DELAY=$(BC_TEST_DELAY) \
		-e HOME=$(HOME) \
		-w $(PWD) \
		--rm -it $(IMAGE) \
		bash -c "$(BUNDLE) install --path $(HOME)/.bundle/vendor && $(BUNDLE) exec rake test $(if $(TEST),TEST=$(TEST),)")

# Performs any tasks necessary before a release build
.PHONY: stage
stage:
	$(SED) -i "s/VERSION = '.*'/VERSION = '$(shell sed 's/-/.pre./' <<<$(VERSION))'/" lib/blockchyp/version.rb

# Publish
.PHONY: publish
publish:
	$(BUNDLE) exec rake publish
