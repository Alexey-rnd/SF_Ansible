terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.70.0"
    }
  }
}

provider "yandex" {
  token     = "AQAAAAABjMcMAATuwQ54X6BevkLngCWD_a3h_gY"
  cloud_id  = "b1gusmopt9d8k4kjfkhu"
  folder_id = "b1guep1u0krfh2kfa2uq"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "vm1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd89ka9p6idl8htbmhok"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("/home/terraform/Terraform/meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "vm2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd89ka9p6idl8htbmhok"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("/home/terraform/Terraform/meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-3" {
  name = "vm3"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8p7vi5c5bbs2s5i67s"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("/home/terraform/Terraform/meta.txt")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}

output "internal_ip_address_vm_3" {
  value = yandex_compute_instance.vm-3.network_interface.0.ip_address
}


output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_3" {
  value = yandex_compute_instance.vm-3.network_interface.0.nat_ip_address
}
