# psc-root/variables.tf

# Define the variable to hold multiple PSC endpoint configurations
variable "psc_endpoints" {
  description = "A map of PSC endpoint configurations."
  type = map(object({
    region                    = string
    endpoint_name             = string
    ip_address_name           = string
    static_ip_address         = string
    vpc_network_name          = string
    subnetwork_name           = string
    service_attachment_target = string
  }))
}