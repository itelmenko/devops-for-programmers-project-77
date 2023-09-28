### Hexlet tests and linter status:
[![Actions Status](https://github.com/itelmenko/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/itelmenko/devops-for-programmers-project-77/actions)

До начала необходимо домену прописать NS серверы

```
ns1.digitalocean.com
ns2.digitalocean.com
ns3.digitalocean.com
```

TF создает A-запись домена при создании LE SSL сертификата.

В качестве Backend используется Terraform Cloud (настройки в backend.tf).

Команды настройки (инициации проекта):

```
terraform login
terraform init
```

Получение данных об образах

```
data "digitalocean_images" "ubuntu" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
}

output "digitalocean_images_data" {
  value = data.digitalocean_images.ubuntu.images[*]
}
```

Последний блок можно сделать с выводом только нужного поля

```
output "digitalocean_images_data" {
  value = data.digitalocean_images.ubuntu.images[*].slug
}
```

In case of manual Redmine installation, default user is set as

User name: admin

Password: admin

Ссылка на приложение https://kypc3.ru/

https://docs.datadoghq.com/account_management/api-app-keys/

https://app.datadoghq.eu/monitors/create/network

https://app.datadoghq.eu/monitors/13229850

