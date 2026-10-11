variable "service_catalog_private_applications" {
  description = <<EOT
Map of service_catalog_private_applications, attributes below
Required:
    - compartment_id
    - display_name
    - short_description
    - package_details (block):
        - package_type (required)
        - version (required)
        - zip_file_base64encoded (required)
Optional:
    - defined_tags
    - freeform_tags
    - logo_file_base64encoded
    - long_description
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    compartment_id          = string
    display_name            = string
    short_description       = string
    defined_tags            = optional(map(string))
    freeform_tags           = optional(map(string))
    logo_file_base64encoded = optional(string)
    long_description        = optional(string)
    package_details = object({
      package_type           = string
      version                = string
      zip_file_base64encoded = string
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.service_catalog_private_applications : (
        contains([for v in ["STACK"] : lower(v)], lower(v.package_details.package_type))
      )
    ])
    error_message = "must be one of: \"STACK\""
  }
}

