# Create a DO project
resource "digitalocean_project" "default" {
  name        = var.projectname
  description = var.projectdescription
  purpose     = var.projectpurpose
  environment = var.projectenvironment
}

# Assign the droplet resource to the project
resource "digitalocean_project_resources" "default" {
  project = digitalocean_project.default.id
  resources = digitalocean_droplet.default.*.urn
}

# Create the droplet
resource "digitalocean_droplet" "default" {
  image  = var.dropletimage
  name   = "${var.dropletimage}-${var.projectname}"
  region = var.region
  size   = var.dropletsize
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

# Upload the public ssh key for the droplet
resource "digitalocean_ssh_key" "default" {
  name       = "default"
  public_key = file(var.ssh_key_pub)
}

data "digitalocean_volume" "default" {
  name   = var.volume-home
  region = var.region
}

resource "digitalocean_volume_attachment" "default" {
  droplet_id = digitalocean_droplet.default.id
  volume_id  = data.digitalocean_volume.default.id
}

resource "digitalocean_firewall" "default" {
  name = "firewall-${var.projectname}"
  droplet_ids = digitalocean_droplet.default.*.id
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "3389"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}