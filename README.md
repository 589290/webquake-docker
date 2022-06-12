[![Docker Pulls](https://img.shields.io/docker/pulls/589290/webquake-docker.svg)](https://hub.docker.com/repository/docker/589290/webquake-docker)

# webquake-docker  
  
A docker image that simultaneously serves both the game client (via apache httpd) and the game server (via nodejs) of [WebQuake](https://github.com/Triang3l/WebQuake).  

To run an instance of my prebuilt image :
```
docker run -d \
  --name webquake \
  -p 0.0.0.0:9999:80 \
  -p 0.0.0.0:26000:26000 \
  589290/webquake-docker:latest
```

Substitute `0.0.0.0` with your LAN ip address `X.X.X.X` so that other players may join.  

The WebQuake game server will now be running at the ip:port of `0.0.0.0:26000`  

Some pertinent game server information can be obtained via :  
[http://0.0.0.0:26000](http://0.0.0.0:26000)  
[http://0.0.0.0:26000/server_info](http://0.0.0.0:26000/server_info)  
  
To reach the game client and start playing, go here: [http://0.0.0.0:9999](http://0.0.0.0:9999)  
  
To connect to the multiplayer game server... `ESCAPE` > MULTIPLAYER > type `0.0.0.0:26000` > `ENTER`  

Welcome to multiplayer Quake in your browser via docker!

⛵
  
```
# build and run the image locally

git clone git@github.com:589290/webquake-docker.git
cd webquake-docker
wget https://github.com/589290/webquake-docker/archive/refs/tags/wq.tar.gz
docker build -t wq .

docker run -d \
  -p 0.0.0.0:9999:80 \
  -p 0.0.0.0:26000:26000 \
  wq
```