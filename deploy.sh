#!/bin/bash

# requirements:
# - awscli (pre-configured)
# - docker
# - docker-compose

AWS_ACCOUNT_ID=810663594687
AWS_REGION=us-east-2
REGISTRY_URL=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker pull $REGISTRY_URL/devpoker-gateway:latest
docker pull $REGISTRY_URL/devpoker-estimate:latest
docker pull $REGISTRY_URL/devpoker-web:latest
docker pull $REGISTRY_URL/devpoker-keycloak:latest

docker-compose -f docker-compose.yml --env-file=.env up -d
