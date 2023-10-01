#!/bin/bash
vault_content=`ansible-vault decrypt --output - ansible/group_vars/all/main-vault.yml`
eval `echo "$vault_content" | awk -F ":" '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print "export TF_VAR_" $1 "=" $2}'`
cd terraform
terraform apply