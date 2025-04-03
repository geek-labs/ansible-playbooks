init:
	pyenv install -s 3.11.8
	virtualenv --python="${HOME}/.pyenv/versions/3.11.8/bin/python" "venv"
	./venv/bin/pip3 install -r requirements.txt
	ansible-galaxy role install -r requirements.yml --force -p .ansible/roles
	ansible-galaxy collection install -r requirements.yml --force -p .ansible/collections

lint:
	source venv/bin/activate && ansible-lint -c .config/ansible-lint.yml
