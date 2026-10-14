FROM python:3.12-slim

# uv берётся из официального образа; версия — та, которой создан ваш uv.lock
COPY --from=ghcr.io/astral-sh/uv:0.13.1 /uv /bin/uv

WORKDIR /app

# Зависимости
COPY pyproject.toml uv.lock ./
RUN uv sync --locked --no-dev --no-install-project

# Код
COPY . .

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]