resource "oci_service_catalog_private_application" "service_catalog_private_applications" {
  for_each = var.service_catalog_private_applications

  compartment_id          = each.value.compartment_id
  display_name            = each.value.display_name
  short_description       = each.value.short_description
  defined_tags            = each.value.defined_tags
  freeform_tags           = each.value.freeform_tags
  logo_file_base64encoded = each.value.logo_file_base64encoded
  long_description        = each.value.long_description

  package_details {
    package_type           = each.value.package_details.package_type
    version                = each.value.package_details.version
    zip_file_base64encoded = each.value.package_details.zip_file_base64encoded
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

