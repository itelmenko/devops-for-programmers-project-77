resource "digitalocean_domain" "main" {
  name = var.app_domain
}

resource "digitalocean_certificate" "cert" {
  name       = "terra-le-1"
  type       = "lets_encrypt"
  domains    = [var.app_domain]
  depends_on = [digitalocean_domain.main]
}