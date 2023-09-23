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