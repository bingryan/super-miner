# monitor(WIP)


Prometheus Web UI: http://xxxx:9090/

Grafana Web UI: http://xxxx:3000/

alertmanager Web UI: http://xxxx:9093/

concul Web UI: http://xxxx:10500/



## develop


### clear docker container

```
sudo docker stop $(sudo docker ps -q) & sudo docker rm $(sudo docker ps -aq)
```