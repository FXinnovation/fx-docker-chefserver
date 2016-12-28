#!/bin/bash
set -e
###
# IMPORTANT: This is very UGLY, need some help to refactor here properly. UGLY but WORKS!
###
###
# Making sure data volume has good permissions
###
#chown -r chef:chef /var/opt/opscode
###
# If there is no data, create some
###
if [ "$(ls -A /var/opt/opscode)" == "" ]; then
  CHEF_BOOTSTRAP=true
else
  CHEF_BOOTSTRAP=false
fi
###
# Launch chef-server 
###
/opt/opscode/embedded/bin/ruby init.rb > /tmp/chef.log &
CHEF_PID=$!
if [ $CHEF_BOOTSTRAP ]; then
  ###
  # Checking if waitin 
  ###
  echo "### No existing configuration - Configurating now"
  echo "### Waiting for chef to be ready"
  grep -m 1 "INIT: Reconfiguration finished" <(tail -f /tmp/chef.log)
  ###
  # Create default user and organisation
  ###
  echo "### Creating Organsation"

  echo "### Creating User"
  
  ###
  # Displaying information
  ###
  echo "############################################################"
  echo "###                     Information                     ### "
  echo "############################################################"

  echo "############################################################"
  echo "###                         End                         ### "
  echo "############################################################"
fi
###
# Launch chef-server
###
echo "Tailing Logs"
tail -F /tmp/chef.log
