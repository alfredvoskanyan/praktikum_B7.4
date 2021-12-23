terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.68.0"
    }
  }
}

provider "yandex" {
  token     = "AQAAAAAw2qxqAATuwT2g6_94k07-js59FbvUl80"
  cloud_id  = "b1g9vrrrh0cdab2hi27e"
  folder_id = "b1glquiu2lmp4sonmefa"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "master-node"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = "e9bt067ukdnalb492hd0"
    nat       = true
  }

  metadata = {
    user-data = "${file("/home/alfred/my-terraform/users.txt")}"
  }
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

resource "yandex_compute_instance" "vm-2" {
  name = "worker-node"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = "e9bt067ukdnalb492hd0"
    nat       = true
  }

  metadata = {
    user-data = "${file("/home/alfred/my-terraform/users.txt")}"
  }
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}