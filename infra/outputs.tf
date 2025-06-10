# Displays the external IP address of the VM
output "vm_external_ip" {
  description = "Public IP address of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

# Displays the name of the VM
output "vm_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.vm_instance.name
}

# Displays the used zone
output "vm_zone" {
  description = "Deployment zone"
  value       = google_compute_instance.vm_instance.zone
}
