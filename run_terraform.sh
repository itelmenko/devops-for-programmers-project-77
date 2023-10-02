#!/bin/bash

echo "Trying to get variables from Ansible Vault"
echo ""

vault_content=`ansible-vault decrypt --output - ansible/group_vars/all/main-vault.yml | grep -o '^[^#]*'`
if [ -z "$vault_content" ]
then
    echo "Empty data or incorrect password!"
    exit 1
fi

echo "Exporting variables from vault ..."
`echo "$vault_content" | awk -F ":" '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print "export TF_VAR_" $1 "=" $2}'`

echo "Exporting variables from common.yml ..."
eval ` grep -o '^[^#]*' ansible/group_vars/all/common.yml | awk -F ":" '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print "export TF_VAR_" $1 "=" $2}'`

case $1 in

  apply)
    echo "Running Terraform apply ..."
    cd terraform && terraform apply
    ;;

  destroy)
    echo "Running Terraform destroy ..."
    cd terraform && terraform destroy
    ;;

  inventory)
    echo "Running Terraform output to make inventory.ini ..."
    cd terraform && terraform output -raw ansible_inventory > ../ansible/inventory.ini
    ;;

  credentials)
    echo "Running Terraform output to make database-vault.yml ..."
    echo "Please, use same password like for main secrets"
    cd terraform && terraform output -raw database_credentials > ../ansible/group_vars/all/database-vault.yml && ansible-vault encrypt ../ansible/group_vars/all/database-vault.yml
    ;;

  *)
    echo "Unknown command"
    ;;
esac