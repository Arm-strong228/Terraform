terraform {
  required_providers {
    esxi = {
      source  = "josenk/esxi"
      version = "~> 1.10"
    }
  }
}

provider "esxi" {
  esxi_hostname = var.esxi_host
  esxi_hostport = "22"
  esxi_hostssl  = "443"
  esxi_username = var.esxi_user
  esxi_password = var.esxi_password
}