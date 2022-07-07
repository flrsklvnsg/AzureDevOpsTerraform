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

terraform {
  backend "azurerm" {
    resource_group_name = "tf_rg_blobstore"
    storage_account_name = "weatherapistorageaccount"
    container_name = "weatherapitfstate"
    key = "terraform.tfstate"
  }
}

variable "imagebuild" {
    type = string
    description = "latest build image build"  
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
        image  = "flrsklvnsg/weatherapi:${var.imagebuild}"
        cpu    = "1"
        memory = "1"

        ports {
        port     = 80
        protocol = "TCP"
        }
        ports {
        port     = 443
        protocol = "TCP"
        }
  }
}


#init
#plan
#apply
#destroy