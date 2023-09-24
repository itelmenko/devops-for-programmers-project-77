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

