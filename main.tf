provider "google" {
  project = "xxxxxx" # Replace with your GCP Project ID
  region  = "us-east4"        # Specify your desired default region
  credentials = file("xxxxx.json")
  zone    = "us-east4-c"      # Specify your desired default zone (optional)
 }

# This module block iterates over the map defined in var.psc_endpoints
# It creates one instance of the 'psc-endpoint' module for each entry.

data "google_project" "current" {}

module "psc_endpoints" {
  source = "./modules/psc-endpoint"

  for_each = var.psc_endpoints

  # Common variables pulled from gcp_config
  project_id = data.google_project.current.project_id
  region     = each.value.region

  # Endpoint-specific variables pulled from the current loop item (each.value)
  endpoint_name             = each.value.endpoint_name
  ip_address_name           = each.value.ip_address_name
  service_attachment_target = each.value.service_attachment_target
  static_ip_address         = each.value.static_ip_address

  # Construct the self-links using the project ID and the resource names from the loop
  network_self_link = "projects/${data.google_project.current.project_id}/global/networks/${each.value.vpc_network_name}"
  subnetwork_self_link = "projects/${data.google_project.current.project_id}/regions/${each.value.region}/subnetworks/${each.value.subnetwork_name}"
}