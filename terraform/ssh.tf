resource "digitalocean_ssh_key" "default" {
  name       = "Terraform SSH public key"
  public_key = file("./files/id_rsa_it.pub")
}