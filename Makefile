.DEFAULT_GOAL := help

.PHONY: help
help:  ## Отображение данного сообщения help
	@ awk 'BEGIN {FS = ":.*##"; printf "\nИспользование:\n  make \033[36m<команда>\033[0m\n\nКоманды:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: login
login: ## Запуск terraform login
	@ cd terraform && terraform login

.PHONY: init
init: ## Запуск terraform init
	@ cd terraform && terraform init

.PHONY: apply
apply: ## Применение настроек (создание описанной инфраструктуры в облаке)
	@ bash ./run_terraform.sh apply

.PHONY: inventory
inventory: ## Создание файла inventory.ini
	@ bash ./run_terraform.sh inventory

.PHONY: creds
creds: ## Создание файла секретов для БД и добавление в Ansible Vault
	@ bash ./run_terraform.sh credentials

.PHONY: destroy
destroy: ## Удаление ране созданной инфраструктуры
	@ bash ./run_terraform.sh destroy && rm ./ansible/group_vars/all/database-vault.yml ./ansible/inventory.ini

.PHONY: encrypt
encrypt: ## Шифрование секретов основных секретов Ansible Vault
	@ ansible-vault encrypt ansible/group_vars/all/main-vault.yml

.PHONY: vault
vault: ## Редактирование основных секретов Ansible Vault
	@ env EDITOR=nano ansible-vault edit ansible/group_vars/all/main-vault.yml

.PHONY: deploy
deploy: ## Развертывание приложения с подготовкой нужного ПО
	@ cd ansible && ansible-galaxy install -r requirements.yml && ansible-playbook playbook.yml --ask-vault-pass -i inventory.ini