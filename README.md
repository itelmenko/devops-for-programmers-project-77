### Hexlet tests and linter status:
[![Actions Status](https://github.com/itelmenko/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/itelmenko/devops-for-programmers-project-77/actions)



### Requirements

- Ansible
- Terraform
- make



### Create accounts, settings and keys

1. Create Digital Ocean's  API key (in your account)
2. Create a DataDog's API key and App key
3. Create domain name and setup NS record for DO.  See above for details
4. Create a Terraform Cloud account




#### NS records for your domain

```
ns1.digitalocean.com
ns2.digitalocean.com
ns3.digitalocean.com
```



### Create base files and settings

1. Clone this repository. Go to directory of  work copy
2. Create file `ansible/group_vars/all/main-vault.yml` and fill variables  in it. See above for details
3. Fill variables  in `ansible/group_vars/all/common.yml`. See above for details
4. Encrypt your secrets by `make encrypt` command
5. `terraform login` (`terraform init` ?)
6. Fill settings of Terraform's backend in `terraform/backend.tf`



#### Content of main-vault.yml

```
# Digital Ocean API token
do_api_token: dop_v1_sone_key
datadog_api_key: some_datadog_api_key
datadog_app_key: some_datadog_app_key
redmine_secret: some_app_key
```



#### Content of common.yml

```
datadog_domain: datadoghq.eu
app_domain: kypc3.ru
ansible_user: root
# Path to your SSH private key
ansible_ssh_private_key_file: ~/.ssh/id_rsa_it
# Content of SSH public key
ssh_public_key: 'ssh-rsa AAAAB....'
# Path to upload the application on server
destination_path: /root/app
env_file_path: "{{ destination_path }}/.env"
```



### Launch

1. Run Terraform apply by `make apply` command
2. Generate inventory file by `make inventory` command
3. Generate file with database credentials by `make creds` command
4. Run Ansible for deploying the application by `make deploy` command



### Try result on your domain

You can get result on you domain. 

Default user for Redmine is set as

```
User name: admin
Password: admin
```

Please, change default application password.



My URL of example application is https://kypc3.ru/
