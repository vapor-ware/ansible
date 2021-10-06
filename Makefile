DOCKER?=docker
REPO=vaporio/ansible
TAG=4.6.0

.PHONY: all
all: ansible-image

.PHONY: ansible-image
ansible-image:
	$(DOCKER) build -t $(REPO):$(TAG) -f Dockerfile .
