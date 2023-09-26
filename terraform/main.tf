terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_images" "ubuntu" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  filter {
    key    = "name"
    values = ["Docker"]
    match_by = "substring"
  }
}

resource "digitalocean_domain" "main" {
  name       = "kypc3.ru"
}

resource "digitalocean_project" "project" {
  name        = "hexlet-terraform-03"
  description = "Project for learning Terraform on Hexlet"
  purpose     = "Web Application"
  environment = "Development"
  resources   = [
    digitalocean_droplet.web1.urn,
    digitalocean_droplet.web2.urn,
    digitalocean_loadbalancer.public.urn,
    //digitalocean_database_cluster.main.urn,
    digitalocean_domain.main.urn
  ]
}

resource "digitalocean_droplet" "web1" {
  image  = data.digitalocean_images.ubuntu.images.0.slug
  name   = "terra-web-1"
  region = "ams3"
  size   = "s-1vcpu-1gb"
}

resource "digitalocean_droplet" "web2" {
  image  = data.digitalocean_images.ubuntu.images.0.slug
  name   = "terra-web-2"
  region = "ams3"
  size   = "s-1vcpu-1gb"
}

resource "digitalocean_certificate" "cert" {
  name    = "terra-le-1"
  type    = "lets_encrypt"
  domains = ["kypc3.ru"]
  depends_on = [digitalocean_domain.main]
}

resource "digitalocean_loadbalancer" "public" {
  name   = "terra-loadbalancer-1"
  region = "ams3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [
    digitalocean_droplet.web1.id,
    digitalocean_droplet.web2.id,
  ]
}

resource "digitalocean_database_firewall" "db-firewall" {
  cluster_id = digitalocean_database_cluster.main.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.web1.id
  }

  rule {
    type  = "droplet"
    value = digitalocean_droplet.web2.id
  }
}

resource "digitalocean_database_db" "database" {
  cluster_id = digitalocean_database_cluster.main.id
  name       = "terra-db"
}

resource "digitalocean_database_user" "db-user" {
  cluster_id = digitalocean_database_cluster.main.id
  name       = "terra-user"
}

resource "digitalocean_database_cluster" "main" {
  name       = "terra-mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = "ams3"
  node_count = 1
}

output "mysql_service_credentials" {
  value = "${digitalocean_database_user.db-user.name} ${digitalocean_database_user.db-user.password}"
  sensitive = true
}
