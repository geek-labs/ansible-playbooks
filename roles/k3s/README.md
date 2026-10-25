## Variables

```yaml
k3s_version: v1.32.1+k3s1

# optional: guest side of a GPU passed through to this VM (see proxmox_install role)
#k3s_gpu_enable: true
## kernel module the GPU needs, the role fails if the running kernel does not ship it
#k3s_gpu_driver_module: i915
## optional: tools to verify the GPU works
#k3s_gpu_tools_install: true
#k3s_gpu_tools_packages: ['intel-gpu-tools', 'vainfo']
```

### GPU verification

- `ls /dev/dri` shows `renderD128`
- `sudo dmesg | grep -i -e guc -e huc` shows the firmware loaded (HuC is required for Intel low-power encoding)
- `vainfo --display drm --device /dev/dri/renderD128` lists the supported codecs
- `sudo intel_gpu_top` shows load while transcoding

