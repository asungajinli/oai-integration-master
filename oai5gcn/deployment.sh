#!/bin/bash

#----------- Docker 설치 -------------

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# 특정 버전 설치 (주석 해제 후 실행)
# VERSION_STRING=5:20.10.2~3-0~ubuntu-bionic
# sudo apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin
# 일반 설치 (특정 버전 설치 시 주석)
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

docker version

# 권한 부여 후 *재시작*
sudo usermod -a -G docker $USER
# restart

# 기본 docker 이미지 pull
docker login
docker pull ubuntu:jammy
docker pull mysql:8.0
docker logout

sudo sysctl net.ipv4.conf.all.forwarding=1
sudo iptables -P FORWARD ACCEPT

sudo service docker restart

#---------------------- OAI 코어 deployment ------------------

# OAI docker 이미지(v2.0.1) pull
docker pull oaisoftwarealliance/oai-amf:v2.0.1
docker pull oaisoftwarealliance/oai-nrf:v2.0.1
docker pull oaisoftwarealliance/oai-spgwu-tiny:v2.0.1
docker pull oaisoftwarealliance/oai-smf:v2.0.1
docker pull oaisoftwarealliance/oai-udr:v2.0.1
docker pull oaisoftwarealliance/oai-udm:v2.0.1
docker pull oaisoftwarealliance/oai-ausf:v2.0.1
docker pull oaisoftwarealliance/oai-upf-vpp:v2.0.1
docker pull oaisoftwarealliance/oai-nssf:v2.0.1
docker pull oaisoftwarealliance/oai-pcf:v2.0.1
docker pull oaisoftwarealliance/oai-nef:latest
# Utility image to generate traffic
docker pull oaisoftwarealliance/trf-gen-cn5g:latest

# OAI 코어 프로젝트(v2.0.1) clone (다른 버전 설치 시 gitlab 들어가서 tag 확인)
git clone --branch v2.0.1 https://gitlab.eurecom.fr/oai/cn5g/oai-cn5g-fed.git
cd oai-cn5g-fed
git checkout -f v2.0.1

# 서브 모듈 동기화
sudo ./scripts/syncComponents.sh --verbose


