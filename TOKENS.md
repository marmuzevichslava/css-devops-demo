# GitHub Secrets & Tokens — CSS DevOps Pipeline

Этот файл объясняет какие токены и секреты нужны для работы pipeline,
откуда их брать и куда класть.

---

## Что такое секрет в GitHub Actions

Секрет — это переменная, которую ты создаёшь вручную в настройках GitHub.
GitHub её шифрует и никому не показывает (даже тебе после сохранения).
В workflow она используется через синтаксис `${{ secrets.ИМЯ_СЕКРЕТА }}`.

---

## Секреты этого проекта

### 1. `CSS_REPO_TOKEN` — нужен сейчас

**Что делает:** позволяет pipeline читать PR-коммиты из основного CSS репозитория
при cross-repo триггере `repository_dispatch`.

**Где используется:** `pr-validation.yml` строка 36
```yaml
secrets.CSS_REPO_TOKEN
```

**Когда нужен:** каждый раз, когда CSS репо открывает PR и отправляет
`repository_dispatch` в этот pipeline репо.

**Как создать:**

1. Зайди на GitHub под своим аккаунтом
2. Верхний правый угол → твой аватар → **Settings**
3. Левое меню внизу → **Developer settings**
4. **Personal access tokens** → **Tokens (classic)**
5. **Generate new token (classic)**
6. Заполни:
   - Note: `css-devops-pipeline-read`
   - Expiration: 90 days (или No expiration — на твоё усмотрение)
   - Scope: поставь галочку на **`repo`** (даёт read доступ к репо)
7. Нажми **Generate token**
8. **Скопируй токен сразу** — он показывается только один раз

**Куда положить:**

1. Открой этот репо (`css-devops-demo`) на GitHub
2. **Settings** → **Secrets and variables** → **Actions**
3. **New repository secret**
4. Name: `CSS_REPO_TOKEN`
5. Secret: вставь скопированный токен
6. **Add secret**

---

### 2. `GITHUB_TOKEN` — создаётся автоматически

**Что делает:** стандартный токен GitHub Actions. Даёт доступ к текущему репо —
checkout, upload artifacts, git push.

**Создавать не нужно** — GitHub предоставляет его автоматически в каждом запуске
workflow. Используется как `${{ secrets.GITHUB_TOKEN }}`.

**Где используется в проекте:**
- `pr-validation.yml` — как fallback токен для локальных PR
- `deploy.yml` — для `git push` при обновлении environment manifest

---

### 3. `AIX_SSH_KEY` — понадобится позже (когда Alan подтвердит пути)

**Что делает:** SSH приватный ключ для подключения к AIX серверу `10.187.68.22`
и компиляции COBOL модулей под пользователем `fcp`.

**Сейчас:** код в `deploy.yml` (строки 310–313) закомментирован как placeholder.
Создавать этот секрет пока не нужно.

**Как создать когда придёт время:**

Шаг 1 — сгенерировать ключ на своей машине:
```bash
ssh-keygen -t ed25519 -C "github-actions-css-pipeline" -f ~/.ssh/css_aix_deploy
```
Введи пустой passphrase (просто Enter два раза).

Шаг 2 — добавить публичный ключ на AIX сервер:
```bash
# Скопировать содержимое публичного ключа
cat ~/.ssh/css_aix_deploy.pub
# Передать системному администратору или Alan — он добавит на сервер
```

Шаг 3 — добавить приватный ключ как секрет:
```bash
cat ~/.ssh/css_aix_deploy   # скопировать всё содержимое
```
GitHub → репо → Settings → Secrets → New secret → Name: `AIX_SSH_KEY`

Шаг 4 — добавить known_hosts:
```bash
ssh-keyscan 10.187.68.22
```
Скопировать вывод → GitHub → секрет с именем `AIX_KNOWN_HOSTS`

---

### 4. `AIX_KNOWN_HOSTS` — понадобится вместе с `AIX_SSH_KEY`

**Что делает:** отпечатки AIX сервера. Нужны чтобы SSH не выдавал
предупреждение "Host authenticity can't be established" при первом подключении.

**Как создать:** см. Шаг 4 выше.

---

## Сводная таблица

| Секрет | Статус | Где создать |
|--------|--------|-------------|
| `CSS_REPO_TOKEN` | **Нужен сейчас** | GitHub профиль → Developer settings → PAT |
| `GITHUB_TOKEN` | Автоматически | Ничего делать не нужно |
| `AIX_SSH_KEY` | Позже (после Alan) | `ssh-keygen` на своей машине |
| `AIX_KNOWN_HOSTS` | Позже (вместе с SSH) | `ssh-keyscan 10.187.68.22` |

---

## Куда добавлять секреты в GitHub

Все секреты этого проекта кладутся в **Repository Secrets**:

```
css-devops-demo репо
  └── Settings
       └── Secrets and variables
            └── Actions
                 └── Repository secrets  ← сюда
```

Не путать с:
- **Environment secrets** — для окружений типа PROD/SVT (сейчас не используются)
- **Organization secrets** — для всей организации (сейчас не используются)

---

## Важно

- Токен показывается **только один раз** при создании — сразу копируй
- Если потерял токен — удали старый, создай новый, обнови секрет в репо
- Не храни токены в коде, .env файлах или документах — только в GitHub Secrets
- `CSS_REPO_TOKEN` лучше ставить с expiration и обновлять раз в 90 дней
