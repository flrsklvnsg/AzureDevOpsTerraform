# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "southeastasia"
}

resource "azurerm_container_group" "tfcg_test" {
    name = "weatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "Public"
    dns_name_label = "flrsklvnsgwebapi"
    os_type = "Linux"

    container {
        name   = "hello-world"
        image  = "flrsklvnsg/weatherapi"
        cpu    = "1"
        memory = "1"

        ports {
        port     = 80
        protocol = "TCP"
        }
  }
}


#init
#plan
#apply
#destroy