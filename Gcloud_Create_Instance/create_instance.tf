resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm-test" {
  name         = "test"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["testing"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #  interface = "NVME"
  #}

  network_interface {
    #network = "default"
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral public IP
    }
  }
  depends_on = [
    google_compute_firewall.allow-ssh,
    google_compute_firewall.allow-web
  ]

  # Defining what service account should be used for creating the VM
  #service_account {
  #  email  = var.email
  #  scopes = ["compute-ro"]
  #}

  metadata = {
    ssh-keys = "${var.user}:${file(var.pubkey)}"
  }

  metadata_startup_script = <<SCRIPT
    sudo yum -y install epel-release
    sudo yum -y install nginx
    sudo systemctl start nginx
  SCRIPT
}