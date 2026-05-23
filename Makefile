init:
	uv sync --all-extras
	uv run ansible-galaxy role install -r requirements.yml --force
	uv run ansible-galaxy collection install -r requirements.yml --force

lint:
	uv run ansible-lint -c .config/ansible-lint.yml
