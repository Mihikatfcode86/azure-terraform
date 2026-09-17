subscription_id = "1c866f1b-0a68-496d-846a-e15a22199fb1"

resource_group_name = "rg-rhel-dev"
location            = "East US"

vnet_name = "vnet-rhel-dev"

vnet_address_space = [
  "10.10.0.0/16"
]

subnet_name = "snet-rhel-dev"

subnet_address_prefix = [
  "10.10.1.0/24"
]

vm_name        = "vm-rhel-dev-01"
vm_size        = "Standard_B2s"
admin_username = "azureuser"

# Replace with your actual public IP/CIDR.
allowed_ssh_source = "YOUR_PUBLIC_IP/32"

tags = {
  Environment     = "Dev"
  OperatingSystem = "RHEL"
  ManagedBy       = "Terraform"
}
