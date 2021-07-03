#!/bin/bash

sudo apt-get clean && sudo apt-get update

# ##################################################################################################################
# INSTALL DOCKER - DOC: https://docs.docker.com/engine/install/ubuntu/
# ##################################################################################################################
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y


# ##################################################################################################################
# INSTALL DOCKER-COMPOSE - https://docs.docker.com/compose/install/
# ##################################################################################################################
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# EXECUTE KEYCLOAK
usermod -aG docker vagrant

# INSTALL sshpass
sudo apt-get install sshpass -y

## CONFIGS DOCKER SWARM
MANAGER="192.168.10.10"
HOSTS=("192.168.10.11" "192.168.10.12")
KEY="vagrant"

# INIT DOCKER SWARM
docker swarm init --advertise-addr $MANAGER

# GET TOKEN
TOKEN=$(docker swarm join-token worker -q)

# GENERATE COMMAND TO JOIN WORKS
JOIN_WORKER="docker swarm join --token ${TOKEN} ${MANAGER}:2377"

for i in ${!HOSTS[*]} ; do
     sshpass -p ${KEY} ssh -t -o StrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -l ${KEY} ${HOSTS[i]} "${JOIN_WORKER}"
   
    if [ $? -eq 0 ] ; then
        echo "WORKER ${HOSTS[i]} ADICIONADO"
    fi
done

# REMOVE SSHPASS
sudo apt-get remove sshpass -y