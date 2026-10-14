\# CarRentSGM



Краткое описание проекта: CarRentSGM — это веб-приложение для управления арендой автомобилей. 

Проект разрабатывается командой «Кондиции» в рамках учебной программы.

Позволяет пользователям бронировать автомобили, управлять парком транспортных средств и отслеживать аренды.



\## Команда



\- Монахов Георгий — Team Lead

\- Головахин Андрей — Backend Developer

\- Савченко Станислав — DevOps



\## Стек технологий



\- Python 3.11

\- FastAPI

\- PostgreSQL

\- Docker

\- GitHub Actions



\## Статус



Проект находится в разработке.



## Запуск через Docker Compose

Нужно: Docker с Compose v2 или новее (`docker compose version` отвечает), свободный порт 8000.

1. Создать файл с переменными окружения из примера:

   ```bash
   cp .env.example .env            # Windows PowerShell: Copy-Item .env.example .env
   ```

   Открыть `.env` и заменить `changeme` на свой пароль базы (только латинские буквы и цифры).

2. Поднять стек:

   ```bash
   docker compose up --build
   ```

3. Проверить:

   ```powershell
   curl.exe -i http://localhost:8000/health
   ```

   Ожидаемый ответ: `HTTP/1.1 200 OK` и `{"status":"healthy","database":"ok"}`.

Порт 8000 занят — задайте в `.env` `APP_PORT=8001` и проверяйте `http://localhost:8001/health`.

Остановить: `Ctrl+C` или `docker compose down`. Удалить стек вместе с данными базы: `docker compose down -v`.

## Локальная разработка без Docker

```bash
uv sync
uv run uvicorn main:app --reload
```

Базы в этом режиме нет: `/` отвечает `200`, `/health` — `503` с `"DATABASE_URL is not set"`. Так и должно быть.



\## Лицензия



MIT



## API

Базовый URL локального запуска: `http://localhost:8000`.

Интерактивная документация OpenAPI: `http://localhost:8000/docs`.

| Метод | Путь | Описание | Ответ |
|-------|------|----------|-------|
| GET | `/` | Корневой эндпоинт | `{"message": "Hello World"}` |
| GET | `/health` | Проверка работоспособности приложения | `{"status": "healthy"}` |
| GET | `/version` | Версия приложения и имя команды-владельца | `{"version": "0.2.0", "team": "Кондиции"}` |

### GET /version

Возвращает текущую версию приложения (значение `app.version`,
заданное в конструкторе `FastAPI`) и название команды.

Пример запроса:

```bash
curl.exe http://localhost:8000/version
```

Пример ответа:

```json
{
  "version": "0.2.0",
  "team": "Conditions"
}
```

Версия в ответе совпадает со значением, которое отображается
в шапке `/docs` — дублирующей константы в коде нет.