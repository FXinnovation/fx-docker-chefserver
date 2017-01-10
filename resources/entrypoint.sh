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
  echo "### Creating User"
  chef-server-ctl user-create \
    $CHEF_USER \
    $CHEF_FIRST_NAME \
    $CHEF_LAST_NAME \
    $CHEF_EMAIL \
    "$CHEF_PASSWORD" \
    --filename /var/opt/opscode/$CHEF_USER.pem
  echo "### Creating Organsation"
  chef-server-ctl org-create \
    "$CHEF_ORGANISATION" "$CHEF_ORGANISATION" \
    --association_user $CHEF_USER \
    --filename /var/opt/opscode/$CHEF_ORGANISATION.pem
  ###
  # Displaying information
  ###
  echo "############################################################"
  echo "###                     Information                      ###"
  echo "############################################################"
  echo "# Chef User : $CHEF_USER"
  echo "# User Password : $CHEF_PASSWORD"
  echo "# User Validator :"
  echo "$(cat /var/opt/opscode/$CHEF_USER.pem)"
  echo "# Chef Organization : $CHEF_ORGANISATION"
  echo "# Organization Validator:"
  echo "$(cat /var/opt/opscode/$CHEF_ORGANISATION.pem)"
  echo "############################################################"
  echo "###                         End                          ###"
  echo "############################################################"
fi
###
# Launch chef-server
###
echo "Tailing Logs"
tail -F /tmp/chef.log
