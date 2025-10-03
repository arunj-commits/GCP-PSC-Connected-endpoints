# Variables for the Private Service Connect Endpoint module

variable "project_id" {
  description = "The ID of the project where the PSC endpoint is created."
  type        = string
}


variable "region" {
  description = "The region where the PSC endpoint and IP address are provisioned."
  type        = string
}

variable "endpoint_name" {
  description = "The name for the Private Service Connect endpoint (forwarding rule)."
  type        = string
  default     = "my-psc-endpoint"
}

variable "ip_address_name" {
  description = "The name for the reserved internal IP address."
  type        = string
  default     = "psc-endpoint-ip"
}

variable "subnetwork_self_link" {
  description = "Self link of the subnetwork for the PSC endpoint (e.g., projects/PROJECT/regions/REGION/subnetworks/SUBNET)."
  type        = string
}

variable "network_self_link" {
  description = "Self link of the VPC network where the PSC endpoint is created (e.g., projects/PROJECT/global/networks/NETWORK)."
  type        = string
}

variable "service_attachment_target" {
  description = "The service attachment URL to connect to (e.g., projects/PROJ/regions/REG/serviceAttachments/ATTACHMENT)."
  type        = string
}

variable "static_ip_address" {
  description = "IP address of the endpoint"
  type        = string
}

variable "enable_global_access" {
  description = "Set to true to enable global access for the Private Service Connect endpoint."
  type        = bool
  default     = false
}