#!/usr/bin/env bash


if [ $(id -u) -ne 0 ]; then
	echo "Please run with sudo!"
	exit 1
fi


if [[ ! $TAG ]] ; then
  export TAG="default" ;
fi

while true; do
  ping -q -c 1 -W 1 master > /dev/null 2>&1
  if [ $? -eq 0 ];then
	local_host=$(ifconfig -a|grep inet|grep -v 0.1| grep -v inet6|awk '{print $2}'|tr -d "addr:")

	service docker start

	if [ ! "$(docker ps -q -f name=registrator_${TAG}_$local_host)" ]; then

      if [ "$(docker ps -aq -f status=exited -f name=registrator_${TAG}_$local_host)" ]; then
          # cleanup
           docker stop registrator_${TAG}_$local_host & docker rm registrator_${TAG}_$local_host
           docker stop nodeexporter_${TAG}_$local_host &  docker rm nodeexporter_${TAG}_$local_host
           docker stop cadvisor_${TAG}_$local_host &  docker rm cadvisor_${TAG}_$local_host
      fi

      docker run -d --name=registrator_${TAG}_$local_host --restart=always \
        -v /var/run/docker.sock:/tmp/docker.sock \
        --network host \
        gliderlabs/registrator -ip="$local_host" consul://master:8500

      docker run -d --name=nodeexporter_${TAG}_$local_host -h  nodeexporter_${TAG}_$local_host --restart=always \
        --network host -p 9100:9100 \
        -v /proc:/host/proc:ro \
        -v /sys:/host/sys:ro \
        -v /:/rootfs:ro \
        -e SERVICE_NAME=nodeexporter_${TAG}_$local_host \
        -e SERVICE_TAGS=nodeexporter \
        prom/node-exporter:v1.0.1 \
        --path.procfs='/host/proc' --path.rootfs='/rootfs' \
        --path.sysfs='/host/sys' --collector.filesystem.ignored-mount-points='^/(sys|proc|dev|host|etc)($$|/)'

      break
  fi
  else
      echo "network error"
      sleep 5
  fi
done

exit 0
