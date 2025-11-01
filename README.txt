## Creating the ansible user and API key on proxmox node
# create a user 'ansible'
# Can be 
pveum user add ansible@pve --password 'YourStrongPassword'

# Assign PVEAdmin role on the datacenter
pveum aclmod / --user ansible@pve --role PVEVMAdmin
