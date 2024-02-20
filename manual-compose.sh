#!/bin/bash

# rm & rmi
# figlet remove all
figlet remove blog-a , blog-b
sudo docker stop $(sudo docker ps -q)
# sudo docker rm $(sudo docker ps -a -q) # 전체 컨테이너 삭제
sudo docker rm blog-a blog-b
# sudo docker rmi $(sudo docker images -q) # 전체 이미지 삭제
sudo docker rmi blog-a blog-b

# build
figlet build blog-a , blog-b
sudo docker build -t blog-a -f docker/blog-a/Dockerfile docker/blog-a
sudo docker build -t blog-b -f docker/blog-b/Dockerfile docker/blog-b

# run
figlet run blog-a , blog-b
sudo docker run -d --name blog-a -p 8001:80 blog-a
sudo docker run -d --name blog-b -p 8002:80 blog-b


# network remove
figlet network remove blogab-lb
sudo docker network rm blogab-lb

# network
figlet network blogab-lb
sudo docker network create blogab-lb
sudo docker network connect blogab-lb blog-a
sudo docker network connect blogab-lb blog-b
sudo docker network inspect blogab-lb

# lb build
figlet build lb
sudo docker build -t lb -f docker/lb/Dockerfile docker/lb

# run
figlet run lb
sudo docker run -d --name lb -p 8003:80 lb
sudo docker start lb

# ps
figlet ps
sudo docker ps

# network
figlet network lb
sudo docker network connect blogab-lb lb
sudo docker network inspect blogab-lb


