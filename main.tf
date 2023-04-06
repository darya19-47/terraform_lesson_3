terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
token = var.do_token
}

resource "digitalocean_ssh_key" "my_ssh_key" {
  name = var.my_ssh_key_name
  public_key = file(var.my_ssh_key_path)
  }

  data "digitalocean_ssh_key" "rebrain_ssh_key" {
    name = var.rebrain_ssh_key
  }

  data "digitalocean_sizes" "main" {
  filter {
    key    = "cpu_size"
    values = [var.parametrs.cpu_size]
  }

  filter {
    key    = "ram_size"
    values = [var.parametrs.ram_size]
  }
filter {
    key    = "disk_size"
    values = [var.parametrs.disk_size]
  }

  sort {
    key       = "price_monthly"
    direction = "asc"
  }
}

data "digitalocean_regions" "available" {
  filter {
    key    = "available"
    values = ["true"]
  }
}

resource "digitalocean_tag" "devops_tag" {
  name = var.devops_tag
}

resource "digitalocean_tag" "email_tag" {
  name = var.email_tag
}

resource "digitalocean_droplet" "second server" {
  image = var.parametrs.image_type
  name = var.parametrs.image_name
  region = element(data.digitalocean_regions.available.regions, 0).slug
  size = element(data.digitalocean_sizes.main.sizes, 0).slug
  ssh_keys = [data.digitalocean_ssh_key.rebrain_ssh_key.id, digitalocean_ssh_key.my_ssh_key.id]
  tags = [digitalocean_tag.devops_tag.id, digitalocean_tag.email_tag.id]
}