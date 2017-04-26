#!/usr/bin/env bash

iadmin mkresc galera2 unixfilesystem irods-galera-2:/Vault
sed -i 's/"irods_default_resource": "demoResc",/"irods_default_resource": "galera2",/g' /var/lib/irods/.irods/irods_environment.json

exit 0;