SHELL:=/bin/bash

PROJECT_NAME=beanies
BUILD_TAG=$(shell git rev-parse --short=8 HEAD)

.SILENT:

all:

# Setup local development environment by installing all dependencies/libraries.
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

# Start local development environment by running docker-compose.
docker-compose:
	cd deployment; \
	CURRENT_UID=$(id -u):$(id -g) docker-compose up

# Manually start frontend and backend services for local development.
fe-start-dev: 
	cd src/frontend; \
	yarn serve
be-start-dev: 
	cd src/backend; \
	python3 main.py

# Build Docker image for frontend and backend services for production deployment.
docker-build: be-build-docker fe-build-docker
be-build-docker:
	cd src/backend; \
	docker build -t ${PROJECT_NAME}/backend:${BUILD_TAG} .
fe-build-docker:
	cd src/frontend; \
	docker build -t ${PROJECT_NAME}/frontend:${BUILD_TAG} .
