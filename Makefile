include v.env
export $(shell sed 's/=.*//' v.env)
build:	build-version

.PHONY: build start push

build-version:	
	docker build -t ${{secrets.DOCKER_USERNAME}}/${REPO_NAME}:${VERSION} .
	
tag-latest:
	docker tag ${{secrets.DOCKER_USERNAME}}/${REPO_NAME}:${VERSION} ${{secrets.DOCKER_USERNAME}}/${REPO_NAME}:latest
 
start:
	docker run -it --rm ${IMAGE}:${VERSION}/bin/bash
login:
	echo ${{secrets.DOCKER_PASSWORD}} | docker login -u ${{secrets.DOCKER_USERNAME}} --password-stdin

push:	login tag-latest
	docker push ${{secrets.DOCKER_USERNAME}}/${REPO_NAME}:latest

minikube:
	minikube start

helm: 
	helm install helmchart ./charts/helmchart

service:
	kubectl get service
	

