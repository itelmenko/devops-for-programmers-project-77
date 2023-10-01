resource "digitalocean_ssh_key" "default" {
  name       = "Terraform SSH public key"
  public_key = var.ssh_public_key
}