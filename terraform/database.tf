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