variable "zone_id" {
  description = "The zone ID of the hosted zone"
  type        = string
}

variable "mail_from_name" {
  description = "The name we should use for the mail from parameter"
  type        = string
}

variable "ttl" {
  description = "The name we should use for the mail from parameter"
  type        = string
}

variable "create_root_txt" {
  description = "Should this module create the root TXT record for the zone?"
  type        = bool
  default     = false
}

variable "create_root_mx" {
  description = "Should this module create the root MX record for the zone?"
  type        = bool
  default     = false
}

variable "create_root_autodiscover" {
  description = "Should this module create the root autodiscover record for the zone?"
  type        = bool
  default     = false
}
