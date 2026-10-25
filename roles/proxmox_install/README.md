## Variables

```yaml
proxmox_api_host_access_limit: 10.1.0.0/16
proxmox_hostname: myproxmox
# optional: use this if you want to auto-setup storages. Usually for useful non-lvm setups
#proxmox_storage: true

# optional, enable to configure terraform access
#proxmox_terraform_enable: true
#proxmox_terraform_api_key: "very secret"
#proxmox_terraform_ssh_keys: 
# - 'ssh-rsa secret1 eugen@eugen"
# - 'ssh-rsa secret2 jan@jan"
# setting this will pin your PVE kernel to this version - leaving it blank will remove the pin
#proxmox_kernel_pin: 6.17.13-9-pve

# optional: bind PCI devices (e.g. the iGPU) to vfio-pci, so they can be passed through to a VM
#proxmox_pci_passthrough_enable: true
#proxmox_pci_passthrough_ids: ['8086:46d1']  # vendor:device, see `lspci -nn`
## host drivers vfio-pci has to be loaded before (default: Intel iGPU), e.g. ['amdgpu'] or ['nvidia', 'nouveau']
#proxmox_pci_passthrough_softdep_drivers: ['i915', 'xe']
## optional: never load these drivers on the host (default: none), only if the softdep is not enough - see below
#proxmox_pci_passthrough_blacklist_drivers: ['i915', 'xe']

# optional: kernel + login console on a serial port (GRUB only, not for proxmox-boot-tool managed hosts)
#proxmox_serial_console_enable: true
#proxmox_serial_console_device: ttyS0
#proxmox_serial_console_baud: 115200
```

Changes to the passthrough or serial console config create `/var/run/reboot-required`, a reboot is needed to apply them.

## PCI passthrough

Prerequisites:

- VT-d (Intel) / AMD-Vi (AMD) enabled in the BIOS
- IOMMU active: `dmesg | grep -e DMAR -e IOMMU` and `/sys/kernel/iommu_groups/` is not empty.
  Recent PVE kernels enable the Intel IOMMU by default, older ones need `intel_iommu=on` on the kernel cmdline
- the device should be alone in its IOMMU group, all devices of a group are passed through together:
  `for d in /sys/kernel/iommu_groups/*/devices/*; do echo "$(basename $(dirname $(dirname $d))) $(lspci -nns ${d##*/})"; done`

Full passthrough makes the device exclusive to one VM, the host loses it. For a GPU this means no local console
after `vfio-pci` claimed it (BIOS and bootloader still show up) - consider the serial console as out-of-band access.
To get the host console back in an emergency, add `modprobe.blacklist=vfio_pci` to the kernel cmdline in GRUB.

Verify after the reboot: `lspci -nnk -d <vendor:device>` shows `Kernel driver in use: vfio-pci`.

### Blacklisting host drivers

Usually not needed: the `softdep` makes `vfio-pci` claim the device before the host driver loads. Only use
`proxmox_pci_passthrough_blacklist_drivers` if the verification above still shows the host driver, e.g. when it
is loaded outside of the normal module ordering (proprietary NVIDIA stack) or a card misbehaves once the host
initialized it.

Downsides:

- the blacklist applies to **all** devices using that driver - a second GPU of the same vendor (e.g. for the host
  console) is lost as well
- the emergency recovery via `modprobe.blacklist=vfio_pci` no longer gives you a console, the blacklisted driver
  has to be allowed again as well

If the driver is built into the kernel (not a module), neither softdep nor blacklist help, use `vfio-pci.ids=` on
the kernel cmdline instead.

Disabling the passthrough does not clean up, remove `/etc/modules-load.d/vfio.conf`, `/etc/modprobe.d/vfio*.conf`,
run `update-initramfs -u -k all` and reboot.

