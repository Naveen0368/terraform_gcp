provider "google" {
  project = "<project_id>"
  region  = "<region>"
}

data "google_compute_instance" "example" {
  name   = "<existing_instance_name>"
  zone   = "<instance_zone>"
}

resource "google_compute_instance" "example" {
  name         = data.google_compute_instance.example.name
  machine_type = "<new_machine_type>"
  zone         = data.google_compute_instance.example.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_instance.example.boot_disk.0.initialize_params.0.image
      size  = "<new_boot_disk_size>"
      type  = data.google_compute_instance.example.boot_disk.0.initialize_params.0.type
    }
  }

  attached_disk {
    source = data.google_compute_instance.example.attached_disk.*.source
    mode   = data.google_compute_instance.example.attached_disk.*.mode
  }

  network_interface {
    network    = data.google_compute_instance.example.network_interface.0.network
    subnetwork = data.google_compute_instance.example.network_interface.0.subnetwork

    access_config {
      nat_ip = data.google_compute_instance.example.network_interface.0.access_config.0.nat_ip
    }
  }

  service_account {
    email  = data.google_compute_instance.example.service_account.0.email
    scopes = data.google_compute_instance.example.service_account.0.scopes
  }

  metadata = data.google_compute_instance.example.metadata

  tags = data.google_compute_instance.example.tags
}
