## Setup

### Virtualenv

First install `pyenv` and `virtualenv` via AUR or another source of your choice.

#### quick
Run this, it will install the environment and the dependencies

```bash
make init
source venv/bin/activate
```

##### IntelliJ
In IntelliJ 

- go to "Project Structure" -> "Platform settings -> SDKs" and use the "+" button to add the python executable
- Use 'Existing environment' and use the path `${project_root}/venv/bin/python`
- Now in "Project Structure" -> "Project settings" -> "SDK" set the project sdk to the one you just added before.

You need to restart the project after the setup



#### Run tests

```bash
make init
source venv/bin/activate

molecule test -s proxmox
# if you want to keep / inspect the docker image use. This also gives your faster retries
molecule test -s proxmox --destroy never
```

#### Lint

```bash
make init
make lint
```
