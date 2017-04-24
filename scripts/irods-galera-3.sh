#!/usr/bin/env bash

iadmin mkresc galera3 unixfilesystem irods-galera-3:/var/lib/irods/iRODS/Vault
sed -i 's/"irods_default_resource": "demoResc",/"irods_default_resource": "galera3",/g' /var/lib/irods/.irods/irods_environment.json

exit 0;