output "ansible_inventory" {
  value = <<-DOC
    [webservers]
    ${digitalocean_droplet.web1.name} ansible_host=${digitalocean_droplet.web1.ipv4_address}
    ${digitalocean_droplet.web2.name} ansible_host=${digitalocean_droplet.web2.ipv4_address}
    DOC
}

output "database_credentials" {
  value     = <<-DOC
    db_cluster_id: ${digitalocean_database_cluster.main.id}
    db_host: ${digitalocean_database_cluster.main.host}
    db_port: ${digitalocean_database_cluster.main.port}
    db_name: ${digitalocean_database_cluster.main.database}
    db_user: ${digitalocean_database_cluster.main.user}
    db_password: ${digitalocean_database_cluster.main.password}
    DOC
  sensitive = true
}