## Variables

```yaml
users_catalog:
- username: normal
  shell: /bin/bash
  groups: sudo,adm
  ssh_keys:
    - "ssh-ed25519 fake1 test1@local.local"
    - "ssh-ed25519 fake2 test2@local.local"
- username: withpassword
  password: $y$j9T$c4UAk5r4Mr9mNKtZawrqN/$7Lkn2tce1rWniuDup/fJ044fsz3y0erW0PFF17tISS0 #  hashed password "test"
- username: gnats
```

Then in your playbook use

```yaml
bastion_user_selection:
  - normal
  - withpassword
```

Every not-selected user will be removed from the user, if the user exist
