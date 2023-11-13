PYTHON = python3.11
PYTHON_VENV_ROOT = venv
PYTHON_VENV_BIN = $(PYTHON_VENV_ROOT)/bin

$(PYTHON_VENV_ROOT):
	$(PYTHON) -m venv $(PYTHON_VENV_ROOT)
	$(MAKE) update-venv

update-venv: $(PYTHON_VENV_ROOT)
	$(PYTHON_VENV_BIN)/pip install -U pip setuptools wheel
	$(PYTHON_VENV_BIN)/pip install -r requirements.txt
	$(PYTHON_VENV_BIN)/pip install -e .[dev]

generate-requirements: $(PYTHON_VENV_ROOT)
	$(PYTHON_VENV_BIN)/pip-compile -U --resolver=backtracking -o requirements.txt pyproject.toml

.PHONY: update-venv generate-requirements

clean-venv:
	rm -rf $(PYTHON_VENV_ROOT)

.PHONY: clean-venv

check-lint: $(PYTHON_VENV_ROOT)
	$(PYTHON_VENV_BIN)/isort --skip-gitignore --check-only nate_site
	$(PYTHON_VENV_BIN)/ruff check nate_site

apply-lint: $(PYTHON_VENV_ROOT)
	$(PYTHON_VENV_BIN)/isort -v --skip-gitignore nate_site
	$(PYTHON_VENV_BIN)/black nate_site
	$(PYTHON_VENV_BIN)/ruff check nate_site

.PHONY: check-lint apply-lint

dev-start: $(PYTHON_VENV_ROOT)
	$(PYTHON_VENV_BIN)/flask --app nate_site --debug run

prod-start:
	docker-compose up -d --build

prod-stop:
	docker-compose down

.PHONY: prod-start prod-stop dev-start

