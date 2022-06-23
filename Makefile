include v.env
export $(shell sed 's/=.*//' v.env)
build:	build-version

.PHONY: build start push

build-version:	
	docker build -t ${DOCKER_USERNAME}/${REPO_NAME}:${VERSION} .
	
tag-latest:
	docker tag ${DOCKER_USERNAME}/${REPO_NAME}:${VERSION} ${DOCKER_USERNAME}/${REPO_NAME}:latest
 
start:
	docker run -it --rm ${IMAGE}:${VERSION}/bin/bash
login:
	echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
#   docker login -u ${DOCKER_NAME} -p ${DOCKER_PASSWORD}
push:	login tag-latest
	docker push ${DOCKER_USERNAME}/${REPO_NAME}:latest