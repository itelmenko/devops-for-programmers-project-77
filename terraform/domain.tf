resource "digitalocean_domain" "main" {
  name = "kypc3.ru"
}

resource "digitalocean_certificate" "cert" {
  name       = "terra-le-1"
  type       = "lets_encrypt"
  domains    = ["kypc3.ru"]
  depends_on = [digitalocean_domain.main]
}