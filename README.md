# Chef-Server
## Description
This repository contains all the files to create a docker container with chef-server 12 installed and working. If there is no data, the user specified in the environment variables will be created and the credentials will be given in the logs. If the volume contains data, it will just start chef-server
## Usage
### Simple Usage
```
docker run -d \ 
  -v [PATH/TO/CHEF]:/var/opt/opscode \
  -e CHEF_ORGANISATION=[ORGANISATION] \
  -e CHEF_USER=[USER] \
  -e CHEF_FIRST_NAME=[FIRST_NAME] \
  -e CHEF_LAST_NAME=[LAST_NAME] \
  -e CHEF_EMAIL=[EMAIL] \
  -e CHEF_PASSWORD=[PASSWORD] \
  -p [PORT]:80 \
  -p [PORT]:443 \
  [REGISTRY]/chef-server:[TAG]
```
