#! /bin/bash

start_container () {
	CID=$(docker run -dit stubby)

	if [ $? == 0 ];
    then
       echo "Container started" 
    else
       echo "Container could not start, exiting..."
    fi

	CIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CID)

	sudo mv /etc/resolv.conf /etc/resolv.conf.bk
	sudo echo "nameserver $CIP" > /etc/resolv.conf	
}

stop_container () {
	sudo mv /etc/resolv.conf.bk /etc/resolv.conf

    CIDs=$(docker ps | grep stubby | awk '{print $1}')
	docker kill $CIDs
    
    CIDs=$(docker ps -a | grep stubby | awk '{print $1}')
    docker rm $CIDs

	if [ $? == 0 ];
    then
       echo "Container stopped" 
    else
       echo "Container stopped" 
    fi
}

while test $# -gt 0; do
	case "$1" in
		-h|--help)
				echo "stubby-docker - stubby container start/stop"
				echo " "
				echo "stubby-docker [options]"
				echo " "
				echo "options:"
				echo "-h, --help             show brief help"
				echo "--start, --start       start container"
				echo "--stop, --stop         stop container"
				exit 0
				;;
		--start*)
				start_container
				shift
				;;
		--stop*)
				stop_container
				shift
				;;
		*)
				break
				;;
	esac
done

