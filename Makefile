.DEFAULT_GOAL := help

.PHONY: help
help:  ## Отображение данного сообщения help
	@ awk 'BEGIN {FS = ":.*##"; printf "\nИспользование:\n  make \033[36m<команда>\033[0m\n\nКоманды:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: apply
apply: ## Применение настроек (создание описанной инфраструктуры в облаке)
	@ cd terraform && terraform apply

.PHONY: destroy
destroy: ## Удаление ране созданной инфраструктуры
	@ cd terraform && terraform destroy

.PHONY: vault
vault: ## Редактирование секретов ansible
	@ env EDITOR=nano ansible-vault edit ansible/group_vars/webservers/vault.yml

all:
	@ cd ansible && ansible-galaxy install -r requirements.yml && ansible-playbook playbook.yml --ask-vault-pass -i inventory.ini
prepare:
	@ cd ansible && ansible-galaxy install -r requirements.yml && ansible-playbook playbook.yml --ask-vault-pass -i inventory.ini -t prepare
deploy:
	@ cd ansible && ansible-galaxy install -r requirements.yml && ansible-playbook playbook.yml --ask-vault-pass -i inventory.ini -t deploy
datadog:
	@ cd ansible && ansible-galaxy install -r requirements.yml && ansible-playbook playbook.yml --ask-vault-pass -i inventory.ini -t datadog