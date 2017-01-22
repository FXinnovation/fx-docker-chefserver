# Chef-Server
## Description
This repository contains all the files to create a docker container with chef-server 12 installed and working. If there is no data, the user specified in the environment variables will be created and the credentials will be given in the logs. If the volume contains data, it will just start chef-server

### Important Note
This is container was made to run on k8s, and we don't like the fact that every service chef needs is in one container. In the future, this container will be split up in several containers to form a real k8s pod!

## Tags
There is no latest tag on this image, since this is a application that will run constantly, you'll have to specify a precise tag.

Please check out the available tags.

We also are not following the chef release version in out tags, this is because there is a lot of stuff in this container... So it doesn't really makes any sense of follow the chef release tags for now. To know what actually running, you have to check it out manually.

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
  -e PUBLIC_URL=[PUBLIC_URL] \
  -p [PORT]:80 \
  -p [PORT]:443 \
  fxinnovation/chefserver:[TAG]
```
IMPORTANT: [PATH/TO/CHEF] has to belong to root for it to work!

## Comments and Issues
If you have comments or detect an issue, please be adviced we don't check the docker hub comments. You can always contact us through the repository.
