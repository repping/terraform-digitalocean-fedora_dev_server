# digitalocean access token
variable "do_token" {
  description = "The Digital Ocean token."
  type        = string
}
variable "projectname" {
  type        = string
  default     = "cloudtop-richard"
  description = "The name of the project (string). Default: cloudtop"
}
variable "projectdescription" {
  type        = string
  default     = "That time Richard stole Roberts CloudTop code..."
  description = "The description of the project (string). Default: Roberts CloudTop."
}
variable "projectpurpose" {
  type        = string
  default     = "Hosting a Fedora Workstation desktop environment."
  description = "The prupose of the project (string). Default: Hosting a desktop environment."
}
variable "projectenvironment" {
  type        = string
  default     = "Production"
  description = "The environment of the project (string). Default: Production"
}
variable "dropletimage" {
  type = string
  description = "Droplet image to use"
  default = "fedora-36-x64"
}
variable "dropletsize" {
  type = string
  description = "Resource sizing of the droplet."
  default = "s-2vcpu-4gb"
}
variable "region" {
  type = string
  description = "Region to deploy the droplet"
  default = "ams3"
}
variable "volume-home" {
  type = string
  description = "Disk for the droplet"
  default = "richard-cloudtop-home"
}
variable "ssh_key_pub" {
  type = string
  description = "File to use as the public sshkey for the droplet"
  default = "./files/id_rsa"
}
# variable "" {
#   type = string
#   description = ""
#   default = ""
# }