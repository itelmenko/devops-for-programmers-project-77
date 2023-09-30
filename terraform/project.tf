resource "digitalocean_project" "project" {
  name        = "hexlet-terraform-03"
  description = "Project for learning Terraform on Hexlet"
  purpose     = "Web Application"
  environment = "Development"
  resources = [
    digitalocean_droplet.web1.urn,
    digitalocean_droplet.web2.urn,
    digitalocean_loadbalancer.public.urn,
    digitalocean_database_cluster.main.urn,
    digitalocean_domain.main.urn
  ]
}