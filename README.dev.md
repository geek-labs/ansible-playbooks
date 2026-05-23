## Setup

### Virtualenv

First install `uv`

#### quick
Run this, it will install the environment and the dependencies

```bash
make init
```

##### IntelliJ
In IntelliJ

- go to "Project Structure" -> "Platform settings -> SDKs" and use the "+" button to add the python executable
- Use 'Existing environment' and use the path `${project_root}/venv/bin/python`
- Now in "Project Structure" -> "Project settings" -> "SDK" set the project sdk to the one you just added before.

You need to restart the project after the setup

#### Run tests (docker)

```bash
make init

uv run molecule test -s proxmox_install
# if you want to keep / inspect the docker image use. This also gives your faster retries
uv run molecule test -s proxmox_install --destroy never
```

You can also run specific stages like verify

```bash
uv run molecule converge -s proxmox_install
uv run molecule verify -s proxmox_install
```

#### Run tests (vagrant)

```bash
export PYTHON_LIB_PATH="$(uv run python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])')"
export ANSIBLE_FILTER_PLUGINS="${PYTHON_LIB_PATH}/molecule/provisioner/ansible/plugins/filter:${HOME}/.ansible/plugins/filter:/usr/share/ansible/plugins/filter"
export ANSIBLE_LIBRARY="${PYTHON_LIB_PATH}/molecule/provisioner/ansible/plugins/modules:${PYTHON_LIB_PATH}/molecule_plugins/vagrant/modules:${HOME}/.ansible/plugins/modules:/usr/share/ansible/plugins/modules"
export ANSIBLE_ROLES_PATH="$(pwd)/roles:$(pwd)/.ansible/roles:${HOME}/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles"
export ANSIBLE_COLLECTIONS_PATH="$(pwd)/collections:$(pwd)/.ansible/collections:${HOME}/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles"

# ensure you use the system ruby or run so vagrant is actually working
# rbenv shell system
uv run molecule converge -s drupalwiki_vm
```

#### Lint

```bash
make init
make lint
```

