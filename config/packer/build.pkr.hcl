variable "folder_id" {
  type = string
}

source "yandex" "screenshotgun-website" {
  folder_id = var.folder_id
  source_image_family = "ubuntu-2004-lts"
  ssh_username = "ubuntu"
  use_ipv4_nat = "true"
  image_name = "screenshotgun-website"
  image_description = "Docker compose runner with Let's encrypt certificate"
}

build {
  name = "screenshotgun-website"

  sources = [
    "source.yandex.screenshotgun-website"
  ]

  provisioner "file" {
    source = "files"
    destination = "/tmp/bootstrap"
  }

  provisioner "file" {
    source = "letsencrypt"
    destination = "/tmp/letsencrypt"
  }

  provisioner "shell" {
    script = "bootstrap.sh"
  }
}
