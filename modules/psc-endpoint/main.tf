

# Resource: Reserved Internal IP Address for PSC Endpoint
resource "google_compute_address" "psc_ip_address" {
  project      = var.project_id
  region       = var.region
  name         = var.ip_address_name
  subnetwork   = var.subnetwork_self_link
  address_type = "INTERNAL"
  address      = var.static_ip_address  # Optional: Removed for simplicity, Google Cloud will assign one
}

# Resource: Private Service Connect Forwarding Rule (The Endpoint)
resource "google_compute_forwarding_rule" "psc_endpoint" {
  project               = var.project_id
  region                = var.region
  name                  = var.endpoint_name
  target                = var.service_attachment_target
  network               = var.network_self_link
  subnetwork            = var.subnetwork_self_link
  ip_protocol           = ""
  load_balancing_scheme = ""
  ip_address            = google_compute_address.psc_ip_address.self_link
}