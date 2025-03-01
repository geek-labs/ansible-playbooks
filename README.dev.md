## Setup

### Virtualenv

First install `pyenv` and `virtualenv` via AUR or another source of your choice.

#### Quickstart
Run this, it will install the environment and the dependencies

```bash
make init
source venv/bin/activate
```

#### Tests

To run a test do

```bash
molecule test -s ubuntu_common
# or
molecule test -s nut_client
```

##### IntelliJ
In IntelliJ go to "Project Structure" -> "Platform settings -> SDKs" and use the "+" button to add the python executable as new SDK inside
the `${HOME}/.pyenv/versions/3.8.10/bin` folder.

Also in "Project Structure" -> "Project settings" -> "SDK" set the project sdk to the one you just added before.
