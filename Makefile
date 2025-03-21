init:
	pyenv install -s 3.11.8
	virtualenv --python="${HOME}/.pyenv/versions/3.11.8/bin/python" "venv"
	./venv/bin/pip3 install -r requirements.txt
	./venv/bin/pip3 install ansible molecule 'molecule-plugins[docker]' yamllint ansible-lint

