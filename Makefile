SHELL:=/bin/bash

PROJECT_NAME=sale-manager
BUILD_TAG=$(shell git rev-parse --short=8 HEAD)
DOCKER_IMAGE=$(PROJECT_NAME):$(BUILD_TAG)

.SILENT:

all:

setup-env: be-setup-env fe-setup-env

be-setup-env:
	cd src/backend; \
	python3 -m venv backend-env; \
	source backend-env/bin/activate; \
	pip3 install -r requirements.txt; \
	cd ../..

fe-setup-env:
	cd src/frontend; \
	yarn; \
	cd ../..

fe-start-dev: 
	cd src/frontend; \
	yarn serve