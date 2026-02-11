variable "ibmcloud_api_key" {}
variable "region" {
  default = "eu-de"
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}