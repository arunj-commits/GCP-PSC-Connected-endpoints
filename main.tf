provider "google" {
  project = "xx" # Replace with your GCP Project ID
  region  = "us-east4"        # Specify your desired default region
  credentials = file("xxxx")
  zone    = "us-east4-c"      # Specify your desired default zone (optional)
 }


data "google_project" "current" {}

module "psc_endpoints" {
  source = "./modules/psc-endpoint"

  for_each = var.psc_endpoints

  project_id = data.google_project.current.project_id
  region     = each.value.region

  # Endpoint-specific variables pulled from the current loop item (each.value)
  endpoint_name             = each.value.endpoint_name
  ip_address_name           = each.value.ip_address_name
  service_attachment_target = each.value.service_attachment_target
  static_ip_address         = each.value.static_ip_address
  enable_global_access      = each.value.enable_global_access # Pass the variable to the module


  # Construct the self-links using the project ID and the resource names from the loop

  network_self_link = "projects/${data.google_project.current.project_id}/global/networks/${each.value.vpc_network_name}"
  subnetwork_self_link = "projects/${data.google_project.current.project_id}/regions/${each.value.region}/subnetworks/${each.value.subnetwork_name}"
}



## Enable --  Cloud Resource Manager API

#import {
#  to = module.psc_endpoints["app-db-endpoint5"].google_compute_address.psc_ip_address
#  id = "projects/psc-endpoint-473916/regions/us-east4/addresses/app-db-psc-ip-5"
#}
#
## Add similar blocks for any other endpoints you need to import
#import {
#  to = module.psc_endpoints["app-db-endpoint5"].google_compute_forwarding_rule.psc_endpoint
#  id = "projects/psc-endpoint-473916/regions/us-east4/forwardingRules/app-db-endpoint5"
#}