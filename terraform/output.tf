output "ansible_inventory" {
  value     = <<-DOC
    [webservers]
    ${digitalocean_droplet.web1.name} ansible_host=${digitalocean_droplet.web1.ipv4_address}
    ${digitalocean_droplet.web2.name} ansible_host=${digitalocean_droplet.web2.ipv4_address}
    DOC
}

output "application_env" {
  value = <<-DOC
    REDMINE_DB_MYSQL=${digitalocean_database_cluster.main.host}
    REDMINE_DB_PORT=${digitalocean_database_cluster.main.port}
    REDMINE_DB_DATABASE=${digitalocean_database_cluster.main.database}
    REDMINE_DB_USERNAME=${digitalocean_database_cluster.main.user}
    REDMINE_DB_PASSWORD=${digitalocean_database_cluster.main.password}
    REDMINE_SECRET_KEY_BASE={{redmine_secret}}
    DOC
  sensitive = true
}