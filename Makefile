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

be-build-docker:
	cd src/backend; \
	docker build -t beanies-backend .

fe-setup-env:
	cd src/frontend; \
	yarn; \
	cd ../..

fe-start-dev: 
	cd src/frontend; \
	yarn serve

fe-build-docker:
	cd src/frontend; \
	docker build -t beanies-frontend .

docker-compose:
	cd deployment; \
	docker-compose up
