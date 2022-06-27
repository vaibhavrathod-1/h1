include *.env
export $(shell sed 's/=.*//' v.env)
build:	build-version

.PHONY: build start push

build-version:	
	docker build -t ${{ DOCKER_USERNAME }}/${REPO_NAME}:${VERSION} .
	 
login:
	docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}

push:	login tag-latest
	docker push ${{ secrets.DOCKER_USERNAME }}/${REPO_NAME}:latest

minikube:
	minikube start

helm: 
	helm install helmchart ./charts/helmchart

service:
	kubectl get service
	

