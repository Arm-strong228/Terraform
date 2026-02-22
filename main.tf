resource "esxi_guest" "ubuntu_vm" {
  guest_name = var.vm_name
  disk_store = var.datastore

  # Déploiement depuis OVA
  ovf_source = var.ova_path

  numvcpus   = var.vm_cpus
  memsize    = var.vm_memory

  power      = "on"

  network_interfaces {
    virtual_network = var.network
    nic_type        = "vmxnet3"
  }

  guest_startup_timeout  = 60
  guest_shutdown_timeout = 30

  # cloud-init pour configurer Ubuntu au premier boot
  guestinfo = {
    "metadata"          = base64encode(templatefile("${path.module}/cloud-init/metadata.yaml", {
      vm_name = var.vm_name
    }))
    "metadata.encoding" = "base64"
    "userdata"          = base64encode(file("${path.module}/cloud-init/userdata.yaml"))
    "userdata.encoding" = "base64"
  }
}