#!/usr/bin/sh
# A simple script for starting and stopping yacd (https://github.com/haishanh/yacd)

# colors
INFOC="\x1b[1;36m"
WARNC="\x1b[1;31m"
NC="\x1b[m"

# message
info(){
    printf "${INFOC}${1}${NC}\n"
}
warn(){
    printf "${WARNC}${1}${NC}\n"
}

# image
start_image(){
    # start docker
    info "Starting docker service..."
    sudo systemctl start docker

    # start yacd
    info "Starting clash dashboard docker image..."
    sudo docker run -p 1234:80 -d --name yacd --rm ghcr.io/haishanh/yacd:master

    info "Clash dashboard now available at http://127.0.0.1:1234/"
}
stop_image(){
    # stop yacd
    info "Stoping clash dashboard docker image..."
    sudo docker stop $(sudo docker ps | grep "yacd" | awk '{print $1}' )
    
    # stop docker
    # sudo systemctl stop docker

    info "Clash dashboard stopped"
}

# main
if [ "$1" = "on" ]    
then
    start_image
elif [ "$1" = "off" ]
then
    stop_image
else
    warn "Bad argument"
fi

