# Python Project Rules

## Tech Stack

- **Version:** Python 3.12+ (Use modern type hints)
- **Env Manager:** [e.g., uv / Poetry / venv]
- **Web Framework:** [e.g., FastAPI / Django / Flask]

## Critical Commands

- **Install:** `uv sync`
- **Test:** `pytest -v`
- **Lint/Format:** `ruff check --fix` and `ruff format`
- **Type Check:** `mypy .`

## Pythonic Rules

- **Formatting:** Use Ruff for both linting and formatting; do not suggest Black or Flake8.
- **Types:** Always use `typing` for function signatures. Prefer `list[str]` over `List[str]`.
- **Async:** Prefer `asyncio` and async-compatible libraries where possible.
- **Errors:** Never use "bare" `except:`. Always catch specific exceptions.
- **Arguments:** Use keyword-only arguments for functions with >3 parameters.

## Boundaries

- NEVER modify `__init__.py` unless adding specific public exports.
- DO NOT add new dependencies to `pyproject.toml` without asking first.
