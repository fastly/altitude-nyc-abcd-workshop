#Define required variables
variable "fastly_api_token" {}
variable "fastly_name" {}
variable "fastly_domain" {}
variable "fastly_backend_bucket" {}

# Configure Fastly provider
provider "fastly" {
  api_key = "${var.fastly_api_token}"
}

# Define Fastly Service
resource "fastly_service_v1" "service" {
  name = "${var.fastly_name}"

  force_destroy = true

  domain {
    name    = "${var.fastly_domain}"
    comment = "Demo domain"
  }

  backend {
    address               = "storage.googleapis.com"
    ssl_hostname          = "${var.fastly_backend_bucket}.storage.googleapis.com"
    name                  = "${var.fastly_backend_bucket}"
    port                  = 443
    first_byte_timeout    = 3000
    max_conn              = 200
    between_bytes_timeout = 1000
  }

  header {
    name        = "backend-host-override"
    action      = "set"
    type        = "request"
    destination = "http.Host"
    source      = "\"${var.fastly_backend_bucket}.storage.googleapis.com\""
  }
}
