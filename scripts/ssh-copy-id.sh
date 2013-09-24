#!/bin/sh

check_args()
{
    if [ "$#" -eq 0 ] ; then
        echo Usage $0 user@machine
        exit 0
    fi
}

main()
{
    [ ! -f ~/.ssh/id_rsa.pub ] && ssh-keygen -t rsa
    cat ~/.ssh/id_rsa.pub | ssh $1 \
        "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
}

check_args $*
main $1
