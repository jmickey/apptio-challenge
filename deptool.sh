#!/bin/bash

ARG=$1

if [ "$ARG" = "deploy" ]
then
    cd terraform && terraform init && terraform apply -auto-approve
    repo_url=$(terraform output ecr_repo_url)
    cluster_name=$(terraform output ecs_cluster_name)
    service_name=$(terraform output ecs_service_name)
    login_cmd=$(aws ecr get-login --no-include-email)
    eval $login_cmd
    cd .. && docker build --rm -f 'Dockerfile' -t $repo_url .
    docker push $repo_url
    aws ecs update-service --cluster $cluster_name --service $service_name --force-new-deployment
elif [ "$ARG" = "kill" ]
then
    cd terraform && terraform destroy -auto-approve
fi