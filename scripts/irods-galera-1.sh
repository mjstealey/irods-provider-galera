#!/usr/bin/env bash

iadmin mkresc galera1 unixfilesystem irods-galera-1:/Vault
iadmin rmresc demoResc
sed -i 's/"irods_default_resource": "demoResc",/"irods_default_resource": "galera1",/g' /var/lib/irods/.irods/irods_environment.json

exit 0;