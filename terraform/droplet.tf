data "digitalocean_images" "ubuntu" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  filter {
    key      = "name"
    values   = ["Docker"]
    match_by = "substring"
  }
}

resource "digitalocean_droplet" "web1" {
  image    = data.digitalocean_images.ubuntu.images.0.slug
  name     = "terra-web-1"
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

resource "digitalocean_droplet" "web2" {
  image    = data.digitalocean_images.ubuntu.images.0.slug
  name     = "terra-web-2"
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}