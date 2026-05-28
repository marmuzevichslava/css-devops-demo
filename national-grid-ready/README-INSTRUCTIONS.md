# National Grid — Инструкция по деплою pipeline
## Удали эту папку после выполнения всех шагов

---

## Структура папки

```
national-grid-ready/
├── README-INSTRUCTIONS.md       ← эта инструкция (удалить после)
├── for-css-demo/                ← файлы для репо css-demo
│   └── .github/workflows/
│       └── notify-pipeline.yml  ← добавить в css-demo
└── for-css-devops-demo/         ← файлы для репо css-devops-demo
    ├── .github/workflows/
    │   ├── pr-validation.yml
    │   ├── build.yml
    │   └── deploy.yml
    ├── scripts/
    │   ├── itt_check.py
    │   ├── diff_analysis.py
    │   ├── classify_modules.py
    │   ├── resolve_build_sequence.py
    │   └── build_manifest.py
    └── build-sequence-rules.json
```

---

## ШАГ 1 — Проверить что runners зарегистрированы

Зайди в GitHub:
```
github.com/nationalgrid-customer/css-devops-demo
  → Settings → Actions → Runners
```
Должны быть два runner'а со статусом **Idle**:
- `azuse-cssdapp01` с labels: `self-hosted, windows, compile`
- `azuse-cssdapp02` с labels: `self-hosted, windows, deploy`

Если Offline — зайди на сервер через CyberArk и запусти:
```powershell
Get-Service -Name 'actions.runner.*' | Start-Service
```

---

## ШАГ 2 — Создать токен (GitHub PAT)

Нужен один токен от сервисного аккаунта или твоего личного (для теста).

1. GitHub → аватар → Settings → Developer settings → Tokens (classic)
2. Generate new token (classic)
3. Note: `css-pipeline-token`
4. Scope: поставить только **repo**
5. Generate → скопировать токен (показывается один раз)

---

## ШАГ 3 — Добавить секреты в оба репо

**В css-demo:**
```
github.com/nationalgrid-customer/css-demo
  → Settings → Secrets and variables → Actions → New repository secret

Name:  PIPELINE_REPO_TOKEN
Value: <токен из шага 2>
```

**В css-devops-demo:**
```
github.com/nationalgrid-customer/css-devops-demo
  → Settings → Secrets and variables → Actions → New repository secret

Name:  CSS_REPO_TOKEN
Value: <тот же токен из шага 2>
```

---

## ШАГ 4 — Добавить файлы в css-demo

Скопировать файл:
```
from: national-grid-ready/for-css-demo/.github/workflows/notify-pipeline.yml
to:   css-demo репо → .github/workflows/notify-pipeline.yml
```

Сделать это через GitHub UI:
1. Открыть `github.com/nationalgrid-customer/css-demo`
2. Создать файл `.github/workflows/notify-pipeline.yml`
3. Вставить содержимое из `for-css-demo/.github/workflows/notify-pipeline.yml`
4. Commit в main

---

## ШАГ 5 — Добавить файлы в css-devops-demo

Создать ветку `feature/add-pipeline` в css-devops-demo и добавить:

```
.github/workflows/pr-validation.yml   ← из for-css-devops-demo/
.github/workflows/build.yml
.github/workflows/deploy.yml
scripts/itt_check.py
scripts/diff_analysis.py
scripts/classify_modules.py
scripts/resolve_build_sequence.py
scripts/build_manifest.py
build-sequence-rules.json
```

Создать PR `feature/add-pipeline` → `main` с commit message: `feat: add pipeline ITT:[<твой ITT номер>]`

---

## ШАГ 6 — Первый тест

1. Открыть `github.com/nationalgrid-customer/css-demo`
2. Создать новую ветку `test/pipeline-check`
3. Изменить любой файл (например в `host/batch/`)
4. Commit message: `test pipeline ITT:[<ITT номер>]`
5. Открыть PR `test/pipeline-check` → `main`

Проверить результат:
```
github.com/nationalgrid-customer/css-devops-demo → Actions
```
Должен появиться `PR Validation` run.

---

## ШАГ 7 — Если не работает

**PR Validation не запускается:**
- Проверить что `PIPELINE_REPO_TOKEN` добавлен в css-demo
- Проверить что `notify-pipeline.yml` есть в css-demo `.github/workflows/`
- Проверить Actions tab в css-demo — был ли запущен notify job

**ITT check падает:**
- Убедиться что в commit message есть `ITT:[число]` (например `ITT:[12345]`)
- Это должно быть в последнем коммите (squash commit)

**Runner offline:**
- Зайти на azuse-cssdapp01 через CyberArk
- Запустить: `Get-Service -Name 'actions.runner.*' | Start-Service`

**SSH к AIX не работает (для COBOL validation):**
- Это блокер только для COBOL файлов
- C++ файлы (client/) будут работать без AIX
- Ждать SSH ключ от Suryasish

---

## ПОСЛЕ ВЫПОЛНЕНИЯ

Удалить папку `national-grid-ready/` — она больше не нужна.
Все файлы уже в репозиториях.
