# National Grid — FCP Remediation
## DevOps Engineer: Slava Marmuzevich
### Полный контекст проекта (обновлено: июнь 2026)

---

## 0. КАК НАЧАТЬ НОВУЮ СЕССИЮ (прочитай это первым)

Перед тем как отвечать на любые вопросы или предлагать изменения — прочитай все эти файлы. Без них у тебя нет контекста.

### Шаг 1 — Стратегия и история (документы)

| Файл | Что там |
|---|---|
| `project/instructions.md` | **Этот файл.** Полный контекст проекта. Читай весь. |
| `project/CI-CD-Strategy.md` | Детальная техническая стратегия CI/CD. Источник правил для pipeline. |
| `project/slava.pdf` | PDF Славы — роли, обязанности, что он делает на проекте. |
| `project/NationalGrid_AllMeetings_v2.docx` | Все митинги с Alan (1–5). Решения, вопросы, договорённости. |
| `project/alan-presentation-2026-06-05.md` | Подготовка к митингу 5 июня — вопросы которые обсуждались с Alan. |
| `project/meetingPresentation.docx` | Презентация на митинг 5 июня. Слайды с вопросами к Alan. |

### Шаг 2 — Скрипты (главный pipeline код)

Все скрипты в `css-devops-demo/scripts/` — это рабочий код. Читай все перед изменениями:

| Файл | Что делает |
|---|---|
| `scripts/diff_analysis.py` | changed files → module IDs |
| `scripts/classify_modules.py` | module ID → тип (C_PROJECT, COBOL, AGS…). UNKNOWN = exit(1) |
| `scripts/resolve_build_sequence.py` | топологическая сортировка → build waves |
| `scripts/build_manifest.py` | генерирует build_manifest.json |
| `scripts/itt_check.py` | проверяет ITT:[N] в последнем commit PR |
| `build-sequence-rules.json` | правила порядка компиляции (topological sort input) |

### Шаг 3 — Workflows

| Файл | Что делает |
|---|---|
| `.github/workflows/pr-validation-reusable.yml` | ITT check + diff + classify + build sequence |
| `.github/workflows/build.yml` | MSBuild (C/AGS) + COBOL staging + manifest |
| `.github/workflows/deploy.yml` | Approval gate + deploy to environment |

### Шаг 4 — Три копии файлов (всегда держи в синхроне)

Главные файлы — в `css-devops-demo/`. Есть ещё две копии:

| Папка | Назначение |
|---|---|
| `css-devops-demo/` | **Основная рабочая версия** |
| `national-grid-ready/css-devops-demo/` | Готовые файлы для копирования на National Grid repo |
| `slava-personal-git/for-css-devops-demo/` | Личный GitHub Славы (marmuzevichslava) для тестирования |

После каждого изменения — синхронизируй все три через `cp`. Проверяй через `md5`.

### Шаг 4б — Git remotes и как пушить

**Remotes (в папке `css-devops-demo/`):**
| Remote | URL | Кто |
|---|---|---|
| `personal` | `git@github.com:marmuzevichslava/css-devops-demo.git` | Личный GitHub Славы |
| `origin` | `https://github.com/nationalgrid-customer/css-devops-demo.git` | NG org repo |

**⚠️ Нельзя пушить напрямую в `origin` с личного MacBook** — security policy National Grid блокирует.

**Workflow для деплоя на NG:**
1. Работаем на личном MacBook, пушим в `personal`: `git push personal main`
2. Скачиваем ZIP с личного GitHub
3. Копируем ZIP на NG машину (вручную, через корпоративные инструменты)
4. На NG машине: распаковываем, пушим в `origin` (NG repo)

**Для `national-grid-ready/` папки** — там содержимое копируется вручную в NG repo, не через git push.

Для css-demo (исходный репо) тоже есть:

| Папка | Назначение |
|---|---|
| `national-grid-ready/css-demo/` | pr-validation-caller.yml для NG |
| `slava-personal-git/for-css-demo/` | Тестовая структура папок (модули для демо) |

### Шаг 5 — Что сейчас в приоритете

Смотри Section 25 (статус) и Section 26 (открытые вопросы к Alan).

Главные блокеры прямо сейчас (обновлено 10.06.2026):
- ✅ AIX SSH menu — РЕШЕНО: Suryasish создал `~fcp/profiles/.profile.github` (sources `.profile.cob` + `.profile.fcp`). Осталось `echo test` с cssdapp01 → потом COBOL SSH в deploy.yml.
- Сессия с Rick Wiggins — подтвердить структуру repo (`host-win/`, `fsd/`, `client/dde/`, AGS) + COBOL compile sequence — Suryasish организует
- Новое направление Alan: компиляция через скрипты (`compile.ksh` + `compile_client.ps1`) — Section 34

**AIX структура (подтверждено 08.06.2026):**
- BUILD: `/css/c1/host/build/` → `files/`, `runtime/`, `source/`
- SVT: `/css/c1/host/svt/` → `runtime/`, `source/`
- COBOL compiler: `/opt/microfocus/cobol/bin/cob` (нужен `LIBPATH`)
- DevOps area: `/tmp_work/_devops/compile/` и `deploy/` (owned by fcp)

**Сделано (08.06.2026):**
- ✅ SSH firewall cssdapp02 → AIX — открыт (Alan подтвердил)
- ✅ SSH cssdapp02 → AIX как `marmuv` — работает, протестировано вручную
- ✅ Unix аккаунт `marmuv` на AIX (USNY7-CSSADV01) — создан
- ✅ BUILD vs SVT — одна компиляция, артефакт `artifacts\BUILD\` для всех сред
- ✅ deploy.yml + build_manifest.py — убран dual-compile
- ✅ build.yml — убран второй MSBuild шаг
- ✅ pr-validation-caller.yml — добавлен `trigger-build` job (dispatch после pass)
- ✅ build.yml — добавлен `repository_dispatch` триггер + checkout css-source
- ✅ Всё запушено в personal GitHub (marmuzevichslava)

**Флоу (реализован):**
```
PR opened в css-demo
  → pr-validation (ITT + diff + classify + waves)
  → если PASS → trigger-build → repository_dispatch
      → build.yml: checkout css-source + MSBuild + manifest + artifact
```

**Что осталось сделать (по порядку):**

1. ✅ **Секрет `CSS_REPO_TOKEN` в css-devops-demo на NG** — уже есть
2. **Скопировать national-grid-ready → NG repo** — css-devops-demo + css-demo в nationalgrid-customer
3. **SSH ключ для `fcp` на AIX** — спросить Alan: runner (US-SVC-T1-CssAgnt) должен SSH как `fcp@10.187.68.22`
4. **Прописать реальный COBOL SSH в deploy.yml** — убрать PLACEHOLDER (пути: `/css/c1/host/build/`, compiler: `/opt/microfocus/cobol/bin/cob`, нужен `LIBPATH`)
5. **Сессия с Rick Wiggins** — структура `host-win/`, `fsd/`, `client/dde/`
6. **Тест на NG** — открыть тест PR в css-demo → проверить полный флоу

Личный GitHub (marmuzevichslava) — полностью работает ✅ (PR Validation + Build Pipeline, тест 06.06.2026)

---

## 1. ЧТО ЭТО ЗА ПРОЕКТ

**CSS (Customer Service System)** — legacy enterprise приложение National Grid для работы с клиентами. Работает с ~1990-х. Будет заменено проектом **Kraken** к ~2030.

**Цель FCP Remediation (PRJ-10937):**
- Убрать техдолг пока CSS ещё живёт (AIX 7.1 end-of-life, PVCS устарел в 2018, Oracle 11.2 end-of-life с 2015)
- Мигрировать PVCS → GitHub
- Заменить ручные деплои на GitHub Actions CI/CD
- Заменить старый AIX сервер на новый
- Заменить сетевую шару на Azure Files

**FCP (Foundation for Cooperative Processing)** — проприетарный продукт Accenture. Middleware между Windows C++ клиентом и COBOL backend. Лицензия истекает **Dec 2026**. Это главный дедлайн проекта.

---

## 2. ТЕХНИЧЕСКИЙ СТЕК CSS

| Компонент | Технология | Где компилируется | Где запускается |
|---|---|---|---|
| Windows C++ клиент | C, MSBuild VS2019 | Compile Server | Network Share → юзер запускает |
| AGS modules (cug*) | C DLL, MSBuild VS2019 | Compile Server | AGS Windows серверы |
| COBOL services (BUILD/SVT) | Micro Focus COBOL | AIX сервер (via SSH) | AIX runtime |
| COBOL (CTST+) | IBM COBOL | Mainframe (via SSH) | Mainframe CICS |
| Codes Tables | .dat файлы | Нет компиляции | KCOD/WCOD database |
| Translation Maps | .xlt файлы | Нет компиляции | KCOD/WCOD database |

---

## 3. ИНФРАСТРУКТУРА

### Azure серверы (оба подняты ✅)

| Сервер | IP | Роль | Статус |
|---|---|---|---|
| azuse-cssdapp01 | 10.58.124.51 | Compile Server | ✅ готов |
| azuse-cssdapp02 | 10.58.124.61 | Deployment Server + Network Share | ✅ готов |

**azuse-cssdapp01 (Compile Server):**
- VS 2019 Build Tools
- OpenSSH Server + клиент
- Git v2.54
- .NET 9 runtime
- GitHub Runner (`[self-hosted, windows, compile]`)
- FCP Client + Repository
- Runner label: `[self-hosted, windows, compile]`

**azuse-cssdapp02 (Deployment Server):**
- OpenSSH Server + клиент
- GitHub Runner
- FCP Client + FCP utility (KCT/CDT для KCOD loads) ← тоже на compile server
- Network shares: `\\azuse-cssdapp02\cssapp` и `\\azuse-cssdapp02\_devops`
- Runner label: `[self-hosted, windows, deploy]`

### Network File Share (на cssdapp02)
```
cssapp\BUILD\client\     ← BUILD runtime для C++ клиента
cssapp\BUILD\source\     ← source reference
cssapp\BUILD\ags\        ← AGS runtime
cssapp\SVT\client\
cssapp\SVT\source\
cssapp\SVT\ags\
...
```

### AIX серверы

| Сервер | IP | Статус |
|---|---|---|
| USNY7-CSSADV01 (новый) | 10.187.68.22 | 🔄 настраивается (Samba/Kerberos проблемы) |
| NGUSNDC430T (старый) | TBD | ✅ работает, PVCS sync идёт с него |

**SSH доступ к новому AIX:**
- Compile Server → AIX ✅ работает (порт 22 открыт)
- Deployment Server → AIX ✅ firewall открыт (Alan подтвердил 08.06.2026)
- Unix аккаунт Славы на AIX: `marmuv` (создан 08.06.2026, credentials на email)
- Проверить вручную: `ssh marmuv@10.187.68.22` с cssdapp02
- Pipeline runner должен SSH как `fcp@10.187.68.22` — только `fcp` имеет write access к `/css/c1/host/build/` и `svt/`
- `marmuv` (личный аккаунт Славы) — read only, писать не может
- Нужно: SSH ключ для `fcp` аккаунта добавить на AIX, спросить Alan
- COBOL compiler: `/opt/microfocus/cobol/bin/cob` — требует `export LIBPATH=/opt/microfocus/cobol/lib:$LIBPATH`

**FCP instances на новом AIX:**
| Instance | Domain | Station | Port |
|---|---|---|---|
| BUILD | 222 | 2 | 5222 |
| SVT | 223 | 2 | 5223 |
| ARCHTST | 999 | 2 | 5999 |

### AGS серверы (on-prem, работают ✅)
- ngusappndc165, ngusappndc166
- USNWK-CSSFCPP01-06
- usny7-cssaqa02-11
- USNOR-CSSFCPR01-06, 11-14
- **Проблема:** fcpadmin SSH login не работает (в процессе)

### Mainframe
- NGUSLPRNWH016
- CICS regions: CTST, CSTG, PTST, STAG и другие

### Service Accounts
| Аккаунт | Назначение |
|---|---|
| NGPPE\US-SVC-T1CssAgnt | GitHub runner agent |
| NGPPE\US-SVC-T1CssAix | AIX SMB mount |

---

## 4. GITHUB / РЕПОЗИТОРИИ

**Org:** `nationalgrid-customer`

| Репозиторий | Назначение |
|---|---|
| css-demo | CSS source code (C++, COBOL, AGS, codes tables) |
| css-devops-demo | Pipeline workflows (твоя работа) |
| css-environments-demo | Environment manifests (audit log деплоев) |

**Архитектура: Option B (cross-repo)**
- В `css-demo` живёт `notify-pipeline.yml` — при открытии PR шлёт `repository_dispatch` в `css-devops-demo`
- `css-devops-demo` получает событие и запускает pipeline
- Alan предпочёл это разделение

**Доступы:**
- GitHub org доступ: ✅ есть
- GitHub Settings (admin/maintainer): ❌ нет → запросить у Alan
- CyberArk: ✅ есть (`https://ngpam.nationalgrid.com/PasswordVault/v10/logon/saml`, Safe: `GBL-PP-APP-IBM-CSSDA-T1`)

---

## 5. ENVIRONMENTS (порядок продвижения кода)

```
BUILD → SVT → PMVT → CTST → CSTG → PTST → STAG → PROD
```

| Environment | Где COBOL | AGS серверы | Примечание |
|---|---|---|---|
| BUILD | AIX (compile) | ✅ есть | Dev environment |
| SVT | AIX (compile) | ❌ нет | System Verification Test |
| PMVT | Mainframe | ✅ есть | Pre-Migration Validation |
| CTST | Mainframe | ✅ есть | Customer Test |
| CSTG | Mainframe | ✅ есть | Customer Staging |
| PTST | Mainframe | ✅ есть | Performance Test |
| STAG | Mainframe | ❌ нет | Staging |
| PROD | ❌ не деплоится через pipeline | ✅ есть | Production |

**Ключевые правила:**
- BUILD binary → только в BUILD
- SVT binary → SVT и все выше до PROD (без перекомпиляции)
- COBOL не деплоится в PROD через этот pipeline

---

## 6. SCOPE РАБОТЫ (твои задачи G2–G5)

| Задача | Ответственный | Статус |
|---|---|---|
| G1 — PVCS→GitHub миграция | Alan Chin | 🔄 в процессе |
| G2 — GitHub Integration + PR Validation | **Slava** | 🔄 начато |
| G3 — Compile Pipelines BUILD/SVT | **Slava** | ❌ не начато |
| G4 — Deploy Pipelines BUILD/SVT | **Slava** | ❌ не начато |
| G5 — Release Pipelines CTST+ | **Slava** | ❌ не начато |
| Azure Files Network Share | Slava + Suryasish | 🔄 в процессе |
| AIX Dev Server замена | Отдельная команда | 🔄 в процессе |

**Ramesh** — твой support на AIX/COBOL/Unix части. Ты lead, он помогает по твоей команде.

---

## 7. CI/CD АРХИТЕКТУРА (из CI-CD-Strategy.md)

### Масштаб кодовой базы
- **~630 C/C++ проектов** (Client + AGS)
- **~3,560 COBOL программ** (Host services + Batch)
- **BUILD binary = Debug build** (для разработки и unit testing)
- **SVT binary = Release build** (промоция через все env до PROD без перекомпиляции)

### Типы модулей и как они определяются

| Тип | Path pattern | Признак |
|---|---|---|
| C_PROJECT (dialog) | `client/dialog/*` | `.vcxproj` + `.gnd` файл |
| C_PROJECT (comwin) | `client/comwin/*` | `.vcxproj` + `.gnd` файл |
| AGS_MODULE | `client/ags/cug*` | `.vcxproj` БЕЗ `.gnd` |
| COBOL | `host/batch/`, `host/service/`, `host/io/` | `.cbl`, `.cob`, `.pco` |
| CODES_TABLE | `db/codestable/` | `.dat` |
| XLT_MAP | `client/xltmap/` | `.xlt` |

### Build Pipeline (Compile Server)

```
PR opened
    ↓
1. ITT Check — каждый commit должен иметь ITT:[number] → блокирует если нет
    ↓
2. Diff Analysis — git diff → список изменённых файлов → module IDs
    ↓
3. Module Classification — classify_modules.py → определяет тип каждого модуля
    ↓
4. Build Sequence — resolve_build_sequence.py → топологическая сортировка → waves
    ↓
5a. C/AGS Compile — MSBuild × 2 (BUILD binary + SVT binary)
5b. COBOL Validation (Deployment Server via SSH) — копирует source на AIX, компилирует в изолированной area, блокирует PR если ошибка
    ↓
6. Build Manifest — JSON с результатами: модули, ITT tickets, artifact locations, SHA
    ↓
7. Artifacts — BUILD.zip + SVT.zip загружаются в GitHub Artifacts store
```

### Deploy Pipeline (Deployment Server)

```
PR merged → push to main
    ↓
1. Impact Report — что будет задеплоено, что заменяет (NEW vs REPLACING)
    ↓
2. Glob Report — проверка ITT коллизий (один модуль от разных ITT tickets)
    ↓
3. Approval Gate — Required Reviewer в GitHub Environment → ждёт апрув
    ↓
4. Deploy:
   - C Projects → копирует binary на Network Share (SMB)
   - COBOL → SCP source на AIX → компилирует там (BUILD/SVT) или на Mainframe (CTST+)
   - AGS → SSH к каждому серверу: stop IIS → stop AGS process → copy DLL → restart → healthcheck
   - Codes Table → FCP utility → KCOD (.mdb) → export → SCP на AIX → WCOD
   - XLT Maps → аналогично Codes Table
    ↓
5. Environment Manifest update — записывает deployed_modules в JSON
    ↓
6. css-environments push — git commit --allow-empty → audit log
```

### Delta Build
- Только изменённые модули компилируются (не full rebuild — codebase слишком большой)
- Источники: git diff + `_recompiled/*.lst` override файлы
- Override нужен для: изменения shared headers, COBOL copybooks, явного форс-ребилда

### Compilation Waves (топологическая сортировка)
- `build-sequence-rules.json` определяет порядок компиляции
- Wave 1: независимые модули (нет зависимостей)
- Wave 2: зависят от Wave 1
- и т.д.
- Цикл в графе = fatal error

### Build Manifest (JSON)
```json
{
  "build_run_id": "GHA-1234",
  "source_commit": "abc123",
  "changed_source_files": ["client/dialog/cuar01/main.c"],
  "compiled_modules": [
    {
      "module_id": "client/dialog/cuar01",
      "type": "C_PROJECT",
      "trigger": "source_change",
      "itt_tickets": [123],
      "artifacts": {
        "BUILD": "artifacts/BUILD/cuar01.exe",
        "SVT": "artifacts/SVT/cuar01.exe"
      }
    }
  ]
}
```

### Environment Manifest (в css-environments repo)
```json
{
  "environment": "CTST",
  "deployed_modules": {
    "client/dialog/cuar01": {
      "build_run_id": "GHA-1234",
      "itt_tickets": [123],
      "deployed_at": "2026-05-27T10:00Z"
    }
  },
  "deployment_history": [...]
}
```

### Partial Promotion
Когда нужно продвинуть только часть модулей из build run:
- Создаётся derived build run под новым ITT ticket
- Без перекомпиляции — берёт существующие артефакты
- Scope ограничен выбранными модулями

### Rollback
- Читает `deployment_history`, находит prior state
- Специальные флаги: `NO_PRIOR_STATE`, `ARTIFACT_UNAVAILABLE`, `SUPERSEDED_ROLLBACK`
- C/AGS: берёт prior binary из artifact store
- COBOL: перекомпилирует prior source (нельзя взять binary)
- Запускается через `workflow_dispatch`

---

## 8. KCOD / WCOD

- **KCOD** — Windows-side база (.mdb MS Access). FCP utility (KCT/CDT) загружает .dat файлы
- **WCOD** — AIX-side runtime база. CSS читает коды отсюда
- **Sync:** KCOD → export → SCP на AIX → import в WCOD
- **Критично:** если KCOD/WCOD sync падает → весь deployment failure
- KCT/CDT utility установлена на **обоих** серверах (cssdapp01 и cssdapp02)
- Alan пришлёт PowerShell скрипт для KCOD/XLT loads (с другого клиента)

---

## 9. ITT TICKETS

- Каждый commit **обязан** содержать `ITT:[number]` в commit message
- ITT — внутренняя ticketing система National Grid (не Jira)
- Используется для SOX audit traceability
- Pipeline блокирует PR если ITT:[number] отсутствует хотя бы в одном commit
- Glob = ситуация когда один модуль имеет commits от **разных** ITT tickets → нужен апрув

---

## 10. ТЕКУЩИЙ СТАТУС (май 2026)

### Что уже написано тобой:
- ✅ ITT check script
- ✅ Diff analysis script
- ✅ Classify modules script
- ✅ Test repository создан
- ⚠️ Нужно запушить чтобы Ramesh мог видеть

### Что готово инфраструктурно:
- ✅ Оба Azure сервера подняты
- ✅ GitHub runners установлены (нужно проверить регистрацию в Settings)
- ✅ Network File Share настроен
- ✅ Service accounts созданы
- ✅ Firewall rules открыты (22, 443, 1521, 5222/5223/5999)
- ✅ PVCS→Git sync идёт (Alan пишет 14-шаговый process)
- ✅ CyberArk доступ есть

### Что заблокировано:
- ❌ Deployment Server → AIX SSH (timeout) — Alan + Jamil разбираются
- ❌ AGS серверы — fcpadmin SSH не работает
- ❌ GitHub Settings права (admin/maintainer) — запросить у Alan
- 🔄 Новый AIX USNY7-CSSADV01 — Samba/Kerberos проблемы (Suryasish)

---

## 11. ПРИОРИТЕТ ОТ ALAN (Meeting 5, 27 мая 2026)

> **"Just get a simple flow working. Classify project or a codestable. Don't worry about sequencing right now. Just get it to flow through."**

Alan хочет видеть **blueprint/template** — простой end-to-end flow хотя бы для одного типа модуля.

**Порядок действий:**
1. Создать SSH ключ для runner (отдельный, не личный) → отдать AIX team
2. Запушить existing scripts (ITT + diff + classify)
3. Сделать минимальный рабочий pipeline: trigger → classify → один тип → done
4. Встретиться с Ramesh 1-on-1 → разделить задачи

---

## 12. КЛЮЧЕВЫЕ ЛЮДИ

| Имя | Роль | Контакт |
|---|---|---|
| Alan Chin | Architect, главный по проекту | Alan.Chin@nationalgrid.com |
| Ramesh Seshadri | Infrastructure, твой support | — |
| Suryasish Dey | AIX/Kerberos troubleshooting | — |
| Rick Wiggins | CSS Client Developer SME | — |
| Kamal Garg | Tech team SME, Promotion workflow | — |
| Vijayalakshmi Kuntimaddi | Project coordinator | — |
| Mike Trovato | Manager | Mike.Trovato@nationalgrid.com |

---

## 13. CROSS-REPO TRIGGER (notify-pipeline.yml)

Живёт в **css-demo** (source repo):
```yaml
on:
  pull_request:
    types: [opened, synchronize, reopened]

# Шлёт repository_dispatch в css-devops-demo
# event_type: 'css-pr-opened'
# payload: pr_number, source_repo, sha, base_sha, ref
```

Secret нужен: `PIPELINE_REPO_TOKEN` — token с repo access к css-devops-demo.

---

## 14. РЕПОЗИТОРИЙ СТРУКТУРА (css repo)

```
css/
├── _recompiled/          # Manual override .lst файлы для force recompile
├── client/
│   ├── dialog/           # C EXE модули (main CSS UI) — компилируется ДВАЖДЫ (BUILD + SVT)
│   ├── comwin/           # C DLL модули — общие окна, используются dialog модулями
│   ├── common/           # C DLL — низкоуровневые зависимости, компилируются первыми (Wave 1)
│   ├── app/              # Windows DevOps tools (dz* names) — утилиты (MigTrax, Workbench)
│   ├── ags/cug*/         # AGS DLL модули — middleware между web/внешними и CSS Mainframe
│   ├── dde/              # DDE (Dynamic Data Exchange) модули — деплоится через addDde.bat
│   └── xltmap/           # XLT translation maps (.xlt) — загружается через mapload.exe
├── host/
│   ├── batch/            # COBOL batch программы
│   ├── service/          # COBOL online services
│   ├── io/               # COBOL I/O copybooks
│   ├── common/           # COBOL common (shared subprograms)
│   ├── table/            # COBOL table programs
│   ├── report/           # COBOL report programs
│   ├── app/              # AIX C executables (не COBOL) — компилируются через xlc
│   ├── aix/lib/          # AIX shared libraries
│   └── copy/
│       ├── msg/          # XLT translation maps (.xlt) — addXlt.bat (был баг: игнорировались)
│       └── ...           # COBOL copybooks (lib/, nongen/) — НЕ компилируются, игнорируются
├── host-win/             # ⚠️ PROVISIONAL — пути нужно подтвердить с Alan/Rick
│   ├── common/           # HOST_WIN_C Windows C проекты (buildHostVcxProj.bat)
│   │                     # Flat .pco файлы → COBOL_WIN (buildCobolFile.bat)
│   └── service/          # HOST_WIN_C Windows C сервисы
├── fsd/                  # ⚠️ PROVISIONAL — FSD (Full Screen Display) проекты (buildFsdProj.bat)
└── db/
    └── codestable/       # Codes tables (.dat) — загружается через ktcdtupd.exe → KCOD → WCOD
```

**Примечания по структуре:**
- `host/copy/msg/*.xlt` — это XLT_MAP модули (не игнорируются). Исправлено 05.06.2026.
- `host/copy/**/*.cpy` и `host/copy/lib/`, `host/copy/nongen/` — COBOL copybooks, НЕ модули. Игнорируются в diff_analysis.
- `host-win/`, `fsd/`, `client/dde/` — добавлены из compileConfig Alan (provisional). Нужна сессия с Rick Wiggins для финального подтверждения.
- AGS (`client/ags/`) — Alan не подтвердил новый путь. Пока оставлен старый.

---

## 15. PVCS → GIT МИГРАЦИЯ (Alan делает)

14-шаговый daily sync процесс:
- AIX (NGUSNDC430T) → Windows Sync Server → GitHub
- Инструменты: Perl скрипты на AIX, PowerShell на Windows
- Репозитории: css, css-devops, css-retired
- Каждый PVCS revision → отдельный Git commit с сохранением истории
- Author mapping: PVCS username → Git name + email (author-map.json)
- Path mapping: старые PVCS пути → новая GitHub структура (path-map.json)
- Идёт ежедневно, пока не будет финальный cutover с PVCS

---

## 16. ВАЖНЫЕ ТЕХНИЧЕСКИЕ ДЕТАЛИ

**C Projects компилируются ДВАЖДЫ:**
- BUILD binary (с BUILD env-specific source) → деплоится только в BUILD
- SVT binary (с SVT env-specific source) → деплоится в SVT и едет до PROD

**COBOL validation при PR (не deployment):**
- SCP source в изолированную area на AIX
- Компилирует → проверяет → cleanup
- Artifacts выбрасываются — это только validation
- Если ошибка → PR заблокирован

**AGS deploy — самый сложный:**
- Нет AGS серверов в SVT и STAG
- Нужна активная Windows user session на AGS сервере
- Порядок: stop IIS → stop AGS host process → copy DLL → restart → health check

**git commit --allow-empty в css-environments:**
- css-environments repo хранит только manifests (JSON)
- Сам manifest меняется отдельно
- Пустой коммит = audit log с deploy деталями в commit message

**Artifact retention:**
- Длина хранения артефактов = максимальная глубина rollback
- Нужно обсудить с Alan какой rollback window нужен бизнесу

---

## 17. AD ГРУППЫ ДОСТУПА

| Группа | Роль |
|---|---|
| AZ-CSS-Dev-SwitcherUsers | Business users с prod CSS |
| AZ-CSS-Dev-Testers | Business analysts, UAT |
| AZ-CSS-Dev-Developers | CSS developers (все environments) |
| AZ-CSS-Dev-Support | Tech team |
| AZ-CSS-Dev-Admins | Full admin (Alan, Kamal, Suresh) |
| AZ-CSS-Dev-Promotions | Release managers, promotion approvers |

---

## 18. РЕШЕНИЯ ИЗ МИТИНГОВ (новое)

### Meeting 2 (22 мая) — PR Workflow validation
- Alan сказал: **squash commit** — не проверять каждый commit в PR, только **последний squash commit** (именно там должен быть ITT:[number])
- Это упрощает ITT check: не надо итерировать по всем commits
- В GitHub можно принудительно включить squash-only merge через branch protection → это надо настроить когда будут admin права
- **Cross-repo trigger** подтверждён: css-demo (source) → repository_dispatch → css-devops-demo (pipeline). Это было финальное решение Alan
- Secrets: Alan предупредил что около **октября 2026** NG будет менять политику ротации секретов → держать в голове, не hardcode

### Meeting 3 с Alan, Surya, Slava (22 мая) — Python vs .NET decision
**Ключевое решение по языкам:**
- **Python** = для всех pipeline скриптов на Runners (diff analysis, classify modules, build manifest, impact/glob reports)
- **.NET/C# EXE** = только для специфических Windows-native задач:
  - AGS deployment helper (нужна .NET программа которая работает в user session на AGS сервере, принимает команды от runner и stop/start AGS host process)
  - Developer tools (workbench, recompile list helper) — отдельно от GitHub Actions
  - Возможно: KCOD load utility wrapper
- Alan имеет sample code с другого клиента для module classification (был на C# для ADO, нужно портировать на Python для GitHub)

**Module identification (подтверждено Alan):**
- Tracking идёт на уровне **модуля**, не файла
- Модуль = папка (например `client/dialog/atdw01` это один модуль)
- Glob report смотрит: один и тот же модуль в двух разных ITT tickets в одном environment → это glob

**CSS repository структура (Alan уточнил):**
- AGS модули (`cug*`) **перенесены** из `client/ags/` — теперь на том же уровне что client/host
- `host/batch/` планируется вынести на уровень выше (будет рядом с host, не внутри)
- Под `aix/` folder — AIX-specific код (не COBOL, просто C программы специфичные для AIX платформы)
- Всё что под `aix/` = AIX-only → compile validation тоже через SSH на AIX (не MSBuild)
- Всё что под `host/` = может компилироваться и на AIX и на Mainframe

**Начать с простого (Alan повторил):**
- Стартовый модуль для теста: `client/common/ktwes` — simple DLL, нет зависимостей от других libs, только Windows libs
- Почему: не надо SSH, всё на Windows runner, легко проверить

### Meeting 3 с Kamal (22 мая) — Unix & Mainframe Architecture
**Kamal объяснил архитектуру разработки:**
- Все разработчики (и COBOL и Client) логинятся на AIX сервер для разработки
- PVCS живёт на AIX — checkout/checkin через него
- После разработки на AIX → промоция через environments → финальный тест на Mainframe (CICS)
- Mainframe нужен потому что: batch processing для миллионов клиентов, только mainframe имеет нужную мощность
- BUILD и SVT = Unix/AIX environments для разработки и первичного тестирования
- CTST, CSTG, PTST = Mainframe environments для реального тестирования
- PROD = тоже Mainframe

**CSS Environment Switcher:**
- Windows приложение которое переключает рабочую среду разработчика между environments
- Маппит диски (X:, O:, V:) на network shares соответствующего environment
- Каждый environment = своя версия CSS client binary на Network Share

### Meeting "SVT Pipeline Setup" (20 мая) — первый митинг с командой
**Alan объяснил план:**
- Два главных направления работы параллельно:
  1. **PR side**: что происходит при создании PR (ITT check, diff analysis, module classification, compile validation, build manifest)
  2. **Deploy side**: деплой на AIX и Network Share (BUILD и SVT environments)
- Стартовать с PR validation flow (это подтверждено на всех последующих митингах)
- CSS repos: `analyse-sync` branch = рабочая ветка Alana для conversion (НЕ трогать, Alan её перезаписывает каждый раз при PVCS sync)
- Для тестирования: клонировать repo или создать отдельный тестовый repo

---

## 19. КАК ПОДКЛЮЧИТЬСЯ К СЕРВЕРАМ

### Через CyberArk (RDP)
```
URL: https://ngpam.nationalgrid.com/PasswordVault/v10/logon/saml
Safe: GBL-PP-APP-IBM-CSSDA-T1
Accounts: T1ADM-CSSDA01 / T1ADM-CSSDA02 / T1ADM-CSSDA03
```
Написать Suryasish: "Can you help me RDP into azuse-cssdapp01 via CyberArk?"

### Первичная проверка серверов (PowerShell)

**Compile Server (azuse-cssdapp01):**
```powershell
Get-Service -Name 'actions.runner.*' -ErrorAction SilentlyContinue | Select Name,Status
where.exe msbuild; git --version; python --version; dotnet --version
Get-Service sshd -ErrorAction SilentlyContinue | Select Name,Status
(Test-NetConnection 10.187.68.22 -Port 22 -WarningAction SilentlyContinue).TcpTestSucceeded
(Test-NetConnection github.com -Port 443 -WarningAction SilentlyContinue).TcpTestSucceeded
```

**Deployment Server (azuse-cssdapp02):**
```powershell
Get-Service -Name 'actions.runner.*' -ErrorAction SilentlyContinue | Select Name,Status
Get-SmbShare | Select Name,Path
Get-Service sshd -ErrorAction SilentlyContinue | Select Name,Status
(Test-NetConnection 10.187.68.22 -Port 22 -WarningAction SilentlyContinue).TcpTestSucceeded
(Test-NetConnection ngusappndc165 -Port 22 -WarningAction SilentlyContinue).TcpTestSucceeded
```

### SSH к AIX (после получения ключа)
```bash
ssh fcp@10.187.68.22
# Проверить FCP instances:
ps -ef | grep fcp
netstat -an | grep 5222
# Проверить COBOL:
which cobrun
ls /opt/microfocus/se/bin/
# CSS структура:
ls /css/c1/
```

---

## 20. СТАТУС СЕРВЕРОВ (подтверждено 27 мая 2026)

| Что | Статус | Детали |
|---|---|---|
| cssdapp01 GitHub runner | ✅ Running | Зарегистрирован в css-demo И css-devops-demo |
| cssdapp02 GitHub runner | ✅ Running | Зарегистрирован в css-demo И css-devops-demo |
| FCP path на cssdapp01 | ✅ Найден | `E:\Apps\FND32\bin` |
| ktcdtupd.exe + mapload.exe | ✅ Есть | `E:\Apps\FND32\bin` — на ОБОИХ серверах |
| cssapp структура cssdapp02 | ✅ OK | `E:\cssapp\BUILD\` и `E:\cssapp\SVT\` с `ags/client/source` папками |
| OpenSSH sshd на cssdapp01 | ⚠️ Stopped | Alan: "feel free to start" — просто запустить службу |
| OpenSSH sshd на cssdapp02 | ✅ Running | OK |
| SSH cssdapp01 → AIX port 22 | 🔄 Partial | Порт открыт, но просит пароль — нужен SSH ключ |
| SSH cssdapp02 → AIX port 22 | ❌ Timeout | Azure firewall блокирует — Suryasish встречается с Jamil |
| KCOD .mdb файлы | ⚠️ TODO | Точные пути уточнить у Alan |

**loadkcod.bat** — получен от Alan 27 мая. Лежит в репо как `loadkcod.bat.txt`. Нужно переписать в PowerShell. Пути: `%FNDROOT%\bin\mapload.exe` и `%FNDROOT%\bin\ktcdtupd.exe`. FNDROOT = `E:\Apps\FND32`.

---

## 21. PIPELINE УЖЕ ЧАСТИЧНО РАБОТАЕТ (27 мая 2026)

**27 мая сделано:**
- Склонирован css-devops-demo в `C:\projects` (вне OneDrive)
- Создана ветка `feature/add-workflows`
- Скопированы `.github/workflows/`, `scripts/`, `build-sequence-rules.json`
- Запушено в css-devops-demo
- Создан PR `feature/add-workflows` → main
- **PR VALIDATION СРАБОТАЛ АВТОМАТИЧЕСКИ!** Runner подхватил job! ✅
- ITT Reference Check: Failing after 12s — **ожидаемо, это правильно — workflow работает!**

**Важный факт:** GitHub Actions берёт workflow из source ветки PR — не из main. Workflow тестируется сразу при открытии PR из feature ветки.

**Прогресс по задачам:**

| Задача | Прогресс | Дедлайн | Статус |
|---|---|---|---|
| 3.5.2.3.2 — ITT check | 70% | 25 мая | РАБОТАЕТ на runner! |
| 3.5.2.3.3 — Diff/classify | 50% | 1 июня | Написан, нужен тест |
| 3.5.2.3.4 — Client pipelines | 0% | 8 июня | Не начат |
| 3.5.2.3.5-7 — XLT/DAT/Recompile | 0% | 29 июня | Не начат |
| **Итого 3.5.2.3** | **~25%** | **29 июня** | **33 дня осталось** |

---

## 22. ЧТО СДЕЛАНО (май 2026)

### Личный GitHub (`marmuzevichslava`)
- ✅ Создано два приватных репо: `css-demo` и `css-devops-demo`
- ✅ `css-demo` — source структура (client, host, db, aix) + `notify-pipeline.yml`
- ✅ `css-devops-demo` — все workflows + Python scripts + `build-sequence-rules.json`
- ✅ Секреты добавлены: `PIPELINE_REPO_TOKEN` в css-demo, `CSS_REPO_TOKEN` в css-devops-demo
- ✅ PR validation pipeline протестирован — **ITT check PASS + Diff analysis PASS**
- ✅ Артефакты сохраняются (classified.json, waves.json, build_manifest.json)
- ✅ Папка `national-grid-ready/` — готовые файлы для копирования на National Grid

### Скрипты (все написаны и протестированы)
- ✅ `scripts/itt_check.py` — проверяет ITT:[число] в последнем squash commit
- ✅ `scripts/diff_analysis.py` — changed files → module IDs
- ✅ `scripts/classify_modules.py` — module ID → тип (C_PROJECT, COBOL, AGS, etc.)
- ✅ `scripts/resolve_build_sequence.py` — топологическая сортировка → waves
- ✅ `scripts/build_manifest.py` — генерирует build_manifest.json
- ✅ `build-sequence-rules.json` — правила порядка компиляции с комментариями

### Workflows (все написаны)
- ✅ `pr-validation.yml` — ITT check + diff analysis (для NG: self-hosted runners)
- ✅ `build.yml` — compile pipeline + manifest
- ✅ `deploy.yml` — approval gate + deploy
- ✅ `test-pr-validation.yml` — копия для личного GitHub (ubuntu-latest)
- ✅ `notify-pipeline.yml` — cross-repo trigger (в css-demo, ubuntu-latest везде)

---

## 23. IMMEDIATE NEXT STEPS — ДЕПЛОЙ НА NATIONAL GRID

Папка `national-grid-ready/` содержит всё готовое. Инструкция: `national-grid-ready/README-INSTRUCTIONS.md`

**Кратко:**

**1. Создать PAT токен** (у тебя admin права)
- github.com → Settings → Tokens (classic) → repo scope

**2. css-demo репо** (`nationalgrid-customer/css-demo`)
- Добавить файл: `.github/workflows/notify-pipeline.yml`
- Добавить секрет: `PIPELINE_REPO_TOKEN` = токен

**3. css-devops-demo репо** (`nationalgrid-customer/css-devops-demo`)
- Добавить папку `.github/workflows/` (3 файла: pr-validation, build, deploy)
- Добавить папку `scripts/` (5 Python файлов)
- Добавить `build-sequence-rules.json`
- Добавить секрет: `CSS_REPO_TOKEN` = тот же токен

**4. Проверить runners онлайн**
```bash
gh api repos/nationalgrid-customer/css-devops-demo/actions/runners \
  --jq '.runners[] | {name, status}'
```

**5. Тест** — открыть PR в css-demo с `ITT:[число]` в commit → смотреть Actions в css-devops-demo

**После деплоя на NG — следующие задачи:**
- SSH ключ для runner → Suryasish добавляет на AIX
- Firewall cssdapp02 → AIX port 22 (Suryasish + Jamil)
- OpenSSH на cssdapp01: `Start-Service sshd`
- Переписать `loadkcod.bat` в PowerShell (`E:\Apps\FND32\bin`)

---

## 24. ОБНОВЛЕНИЕ — 1-2 июня 2026

### Python на compile server
- **Python 3.12 установлен на azuse-cssdapp01 ✅** (версия от Wintel/Software Center)
- Blocker снят — PR Validation скрипты могут запускаться
- Наши скрипты совместимы с 3.12 ✅ (используем только stdlib)

### Статус задач
| Задача | Статус |
|---|---|
| PR Validation на NG | ✅ работает |
| Python на cssdapp01 | ✅ Python 3.12 установлен |
| SSH ключ → AIX | ❌ ждём Suryasish |
| Firewall cssdapp02 → AIX | ❌ ждём Suryasish + Jamil |
| css-demo на NG — только `notify-pipeline.yml` | ⬜ не начато |
| css-devops-demo на NG — workflows + scripts | ⬜ не начато |

### Новое из митинга 01.06.2026

**Python:**
- Alan скачал Python 3.14 MSI installer на сервер → `E:\devops\software\`
- Ramesh поднял риск: Software Center имеет 3.12 — если IT заставит использовать его, будет конфликт
- Решение: **Python 3.12 установлен** (Wintel/Software Center версия) — 5 июня 2026

**Ветки (ВАЖНО — Alan удаляет analyze-sync):**
- `analyze-sync` ветка будет удалена Alan'ом — она была только для PVCS анализа
- `pvcs-sync` — ветка куда Alan постоянно синхронизирует из PVCS (не трогать)
- **`build`** — главная рабочая ветка (аналог main для разработчиков)
- Alan создаст `build` ветку в css-demo и css-devops-demo

**Developer workflow в новом мире:**
```
Создать ITT тикет
    ↓
git checkout -b ITT-12345 (от build ветки)
    ↓
Разработка на workstation
    ↓
PR: ITT-12345 → build
    ↓
Pipeline срабатывает автоматически
```

**Структура css-devops-demo (Alan объяснил):**
- `client/` в devops repo = developer tools/utilities для Windows (не CSS application code)
- `fcp/` = конфиги FCP Design tool
- `aix/` = AIX developer scripts
- Это intentional — всё для DevOps инструментов

**Вопрос Alan про workflow в css-demo:**
Хочет чтобы workflow YAML не был виден в git history css-demo.
Решение — Reusable Workflow (Вариант A):
- В css-devops-demo: `pr-validation-reusable.yml` с триггером `workflow_call`
- В css-demo: один маленький caller файл (5 строк)
- Логика pipeline меняется только в devops repo → history css-demo чистый

**Завтра (02.06.2026) — Alan хочет увидеть:**
Демо: как выглядит PR flow для разработчика:
1. Разработчик создаёт PR в css-demo
2. Как workflow появляется под PR (checks tab)
3. Что видит разработчик — pass/fail, детали

---

## 29. СДЕЛАНО — 9 ИЮНЯ 2026

### Изменения в pipeline (все три копии синхронизированы)

**build.yml** — новый шаг 8b "Stage changed source files":
- Берёт все changed files из `changed_files.json`
- Копирует в `artifacts/source/` (уходит в артефакт)
- Работает для `repository_dispatch` (css-source/ prefix) и push/manual
- Нужен для: tracking branches svt/prod

**deploy.yml** — два изменения:
1. **PMVT добавлен** в environment options: `BUILD, SVT, PMVT, CTST, CSTG, PTST, STAG, PROD`
2. **Новый шаг "Update environment tracking branch"** (срабатывает только для SVT и PROD):
   - Alan (митинг 09.06.2026): svt/prod ветки должны отражать точно то что задеплоено
   - НЕ merge build→svt (подхватит чужие ITT)
   - Берёт source файлы из пакета, применяет к ветке svt/prod, коммитит и пушит

**Синхронизировано во всех трёх копиях:**
- `css-devops-demo/` (root, личный GitHub)
- `national-grid-ready/css-devops-demo/` (для NG)
- `slava-personal-git/for-css-devops-demo/`

### Статус задач (из Gantt 09.06.2026)

**3.5.2.3 — Client developer pipelines: BUILD, SVT (27%)**

| Задача | Что есть | Что осталось |
|---|---|---|
| 3.5.2.3.1 Configure Compile Server (80%) | Runner ✅, VS2019 ✅, Python ✅ | SSH ключ fcp на AIX |
| 3.5.2.3.2 PR details extraction (60%) | ITT ✅, diff ✅, cross-repo ✅ | — |
| 3.5.2.3.3 Compilation sequence (50%) | classify ✅, waves ✅, rules ✅ | Подтверждение Rick Wiggins |
| 3.5.2.3.4 Client pipelines C/AGS (0%) | MSBuild ✅, DDE ✅ | AGS путь, Rick Wiggins сессия |
| 3.5.2.3.5 Translation maps import (0%) | ❌ | mapload.exe в pipeline |
| 3.5.2.3.6 Codes tables import (0%) | ❌ | ktcdtupd.exe в pipeline |
| 3.5.2.3.7 Recompilation list (0%) | ❌ | _recompiled/*.lst обработка |

**3.5.2.5 — COBOL compile pipelines (0%)** — заблокировано SSH ключом fcp

**3.5.2.7 — Deployment pipelines: BUILD, SVT (написано, не тестировалось)**

| Что | Статус |
|---|---|
| Impact Report + Glob Report | ✅ написано |
| Approval gate | ✅ написано |
| C binary → network share | ✅ написано |
| COBOL SSH deploy | ✅ placeholder (нужен fcp ключ) |
| SVT/PROD tracking branch | ✅ добавлено 09.06 |
| AGS deployment | ❌ не написано |
| Translation maps | ❌ не написано |
| Codes tables | ❌ не написано |

### Открытые вопросы к Suryasish (09.06.2026):
- SSH ключ: compile runner (cssdapp01) должен SSH как `fcp@10.187.68.22` для COBOL compile
- Нужно сгенерировать key pair на cssdapp01, передать public key Suryasish → он добавит в fcp authorized_keys

---

## 25. СТАТУС НА 6 ИЮНЯ 2026

### Что сделано и работает на National Grid:

| Компонент | Статус | Где |
|---|---|---|
| PR Validation — ITT check | ✅ работает | azuse-cssdapp01 |
| PR Validation — diff → classify → waves | ✅ работает | azuse-cssdapp01 |
| PR Validation — UNKNOWN = FAIL | ✅ реализовано (06.06) | azuse-cssdapp01 |
| Build — artifact naming `yyyyMMdd.run.attempt.manual` | ✅ реализовано (06.06) | azuse-cssdapp01 |
| Build — MSBuild (один артефакт, промоутится в SVT как есть) | ✅ работает | azuse-cssdapp01 |
| Build — HOST_WIN_C в MSBuild loops | ✅ реализовано (⚠️ provisional path) | azuse-cssdapp01 |
| Build — DDE staging | ✅ реализовано (⚠️ provisional path) | azuse-cssdapp01 |
| Build — COBOL source staging | ✅ работает | azuse-cssdapp01 |
| Build — manifest generation + upload | ✅ работает | azuse-cssdapp01 |
| Python 3.12 на cssdapp01 | ✅ установлен | azuse-cssdapp01 |

### Написано но НЕ тестировалось на National Grid (deploy):

| Компонент | Статус | Где |
|---|---|---|
| Deploy — Impact Report + Glob Report | ⏳ не тестировалось | azuse-cssdapp02 |
| Deploy — Approval Gate | ⏳ не тестировалось | azuse-cssdapp02 |
| Deploy — C binary copy to network share | ⏳ не тестировалось | azuse-cssdapp02 |
| Deploy — env manifest update + git push | ⏳ не тестировалось | azuse-cssdapp02 |

### Что заблокировано:

| Блокер | Статус | Ждём |
|---|---|---|
| SSH cssdapp02 → AIX port 22 | ❌ timeout | Suryasish + Jamil (firewall) |
| SSH cssdapp01 → AIX (ключ) | 🔄 частично | AIX team — добавить dedicated runner SSH key |
| COBOL deploy (AIX SSH paths) | ⏳ placeholder | Alan — подтвердить пути и команду cob |

### ⚠️ ВАЖНЫЕ ИСПРАВЛЕНИЯ (8 июня 2026 — не забыть):

**BUILD vs SVT — ОДИН артефакт, не два.**
Компиляция происходит один раз. BUILD артефакт промоутится в SVT как есть — без перекомпиляции. В build.yml сейчас два MSBuild шага — это НЕПРАВИЛЬНО, нужно убрать второй. Вопрос Q1 про "разные флаги BUILD vs SVT" был неверным — удалить из вопросов к Alan.

**Что можно сделать самому (не нужен Alan):**
1. **Исправить build.yml** — убрать второй MSBuild шаг (SVT = тот же артефакт что BUILD)
2. **FCP_ROOT путь** — проверить на сервере через CyberArk: `E:\Apps\FND32` — уже найдено, просто захардкодить
3. **Deploy workflow** — протестировать на azuse-cssdapp02 всё кроме COBOL SSH: Impact Report, Glob Report, Approval Gate, C binary copy to network share
4. **AGS путь** — проверить в css-demo репо самому (contributor доступ есть)
5. **Branches** — Slava contributor, может создавать ветки и управлять ими сам

**Что реально нужно от Alan:**
1. SSH firewall cssdapp02 → AIX (Jamil) — статус
2. Сессия с Rick Wiggins — подтвердить пути модулей в css-demo

### Личный GitHub (marmuzevichslava) — протестировано 06.06.2026:

- `css-demo` + `css-devops-demo` — оба приватных репо, ветка `main`
- PR Validation: ✅ **PASS** (ITT + diff + classify + waves — все шаги зелёные)
- Build Pipeline: ✅ **PASS** (все шаги включая MSBuild, COBOL staging, manifest)
- `national-grid-ready/` — готовые файлы для NG, **не содержат** vswhere (чистые VS2019 пути)
- `slava-personal-git/` в `.gitignore` основного репо — пушится отдельно через `git push personal main`

### Важное про три копии (обновлено 06.06):

| Копия | Runs-on | VS пути | Репозитории |
|---|---|---|---|
| `css-devops-demo/` (root) | `windows-latest` + vswhere | auto-detect VS2019/2022/2026 | `marmuzevichslava/...` |
| `national-grid-ready/` | `[self-hosted, windows, compile]` | фиксированные VS2019 | `nationalgrid-customer/...` |
| `slava-personal-git/` | — (не имеет .git, игнорируется) | — | копия root |

**Root `.github/workflows/` = то что пушится на личный GitHub.** `national-grid-ready/` — отдельная папка, в git не трекается, синхронизируется вручную через cp.

### Workflows (все написаны и работают):

| Файл | Назначение | Статус |
|---|---|---|
| `pr-validation-reusable.yml` | ITT check + diff + classify (css-devops-demo) | ✅ |
| `pr-validation-caller.yml` | 5-строчный caller (css-demo) | ✅ |
| `build.yml` | Compile pipeline + manifest (css-devops-demo) | ✅ |
| `deploy.yml` | Approval gate + deploy (css-devops-demo) | ✅ |

### Скрипты (все написаны):

| Файл | Назначение | Статус |
|---|---|---|
| `scripts/itt_check.py` | Проверяет ITT:[N] в последнем commit PR | ✅ |
| `scripts/diff_analysis.py` | changed files → module IDs | ✅ |
| `scripts/classify_modules.py` | module ID → тип (C_PROJECT, COBOL, AGS…) | ✅ |
| `scripts/resolve_build_sequence.py` | топологическая сортировка → waves | ✅ |
| `scripts/build_manifest.py` | генерирует build_manifest.json | ✅ |
| `build-sequence-rules.json` | правила порядка компиляции | ✅ |

---

## 26. ВОПРОСЫ К ALAN (актуально после 8 июня 2026)

### Только два реальных вопроса к Alan:

1. ~~**SSH firewall cssdapp02 → AIX port 22**~~ — ✅ РЕШЕНО (firewall открыт 08.06; `~fcp/profiles/.profile.github` создан Suryasish 10.06). См. Section 30.

2. **Сессия с Rick Wiggins** — когда? На сессии пройти все типы модулей и где компилируется каждый. Подтвердить пути: `host-win/`, `fsd/`, `client/dde/`, AGS новый путь, порядок `client/common`.

### НЕ спрашивать Alan (закрыто/решено самостоятельно):
- ~~MSBuild BUILD vs SVT флаги~~ — BUILD = SVT, один артефакт, нет разницы
- ~~FCP_ROOT путь~~ — уже найден: `E:\Apps\FND32`, проверить на сервере
- ~~build branch~~ — BUILD это environment, не branch
- ~~Admin права GitHub~~ — Slava contributor, всё можно самому
- ~~AGS путь~~ — проверить в репо самому
   - Чем отличаются MSBuild флаги для `HOST_WIN_C` от `C_PROJECT`?

### Прочие открытые:

5. **Build trigger** — после merge → build запускать автоматически или вручную?
6. **Artifact retention** — 30 дней или больше? Что нужно бизнесу для rollback?
7. **`build` branch** — создана ли ветка `build` в css-demo и css-devops-demo?
8. **css-environments repo** — `css-environments-demo` правильное имя? Когда создавать orphan branches?

### Решено на митинге 5 июня (уже закрыто):

- ✅ **Artifact naming** — реализовано: `yyyyMMdd.run_number.run_attempt.manual`
- ✅ **UNKNOWN = FAIL** — реализовано в classify_modules.py + pr-validation workflow
- ✅ **compileConfig sequence** — provisional 11 правил добавлены в build-sequence-rules.json (нужно подтверждение Rick)

---

## 27. СДЕЛАНО — МИТИНГ 5 ИЮНЯ 2026 (изменения в коде)

### Что было на митинге
Alan показал `compileConfig.xml` — конфигурация старой FCP/PVCS системы. Это **не финальная спецификация**, а **отправная точка** для pipeline. Структура репозитория будет финализирована на отдельной сессии с Rick Wiggins (он единственный кто знает AIX architecture modules).

### Что изменено в коде

**`classify_modules.py`** — 3 изменения:
1. **UNKNOWN = FAIL** — если модуль не распознан, pipeline завершается с `exit(1)` и сообщением об ошибке. Было: тихо помечался как UNKNOWN и продолжал. Alan сказал: *"Unknown is bad if you just silently drop it."*
2. **Новые типы (черновик, нужна сессия с Rick):**
   - `host-win/common/<proj>`, `host-win/service/<proj>` → `HOST_WIN_C` (buildHostVcxProj.bat)
   - `client/dde/<module>` → `DDE_MODULE` (addDde.bat)
   - `fsd/<proj>` → `FSD_MODULE` (buildFsdProj.bat)
   - `host/copy/msg/<name>` → `XLT_MAP` (addXlt.bat) ← до этого отсутствовало
3. **`has_csrmap: true` флаг** — для comwin и dialog модулей у которых в папке есть `.map` файлы → нужно `addCsrmap.bat` при деплое

**`diff_analysis.py`** — 2 исправления:
1. **XLT BUG ИСПРАВЛЕН**: `host/copy/msg/*.xlt` теперь детектируется как flat XLT_MAP модуль. Было в `NON_MODULE_PATHS` — эти файлы тихо игнорировались.
2. **Новые плоские пути**: `host-win/common/*.pco` и `host-win/service/*.pco` как flat COBOL файлы

**`build-sequence-rules.json`** — +11 правил (черновик):
Строгий порядок `client/common` из compileConfig `<sequence>`:
```
ktcomprs → ktwesatr → fdgstat → c1crsrc → azsecext → tcppipe → c1cfunc
→ archdisp → archfunc → cssfunc → csrntdll → cssclr01
```
⚠️ ПОМЕТКА: Это provisional — нужно подтверждение от Alan/Rick. Для National Grid может отличаться.

**`build.yml`** — 4 изменения:
1. **Artifact naming реализован**: `yyyyMMdd.run_number.run_attempt.manual` (или `.push`)
2. **`BUILD_RUN_ID` env** передаётся в `build_manifest.py`
3. **`HOST_WIN_C`** добавлен в оба MSBuild цикла (BUILD + SVT)
4. **DDE staging step** добавлен (`artifacts\DDE\`)

**`build_manifest.py`** — использует env var `BUILD_RUN_ID` → human-readable build_run_id в manifest

**`pr-validation-reusable.yml`** (все версии) — LASTEXITCODE check после classify: если unknown type → step fails с явным сообщением

### Что НЕ менялось и почему
- **AGS modules путь** — всё ещё `client/ags/cug*` (старый). Alan не подтвердил новый путь → оставлено как есть
- **MSBuild флаги BUILD vs SVT** — placeholder. Q1 для Alan
- **HOST_C** (AIX C) — пути в build workflow не добавлены (нужно подтверждение)

### Синхронизация
Все изменения скопированы в:
- `national-grid-ready/css-devops-demo/` (NG-ready файлы)
- `slava-personal-git/for-css-devops-demo/` (личный GitHub для тестирования)
- `slava-personal-git/for-css-demo/` — добавлена демо-структура (`host/batch/`, `db/codestable/`, `host/copy/msg/*.xlt`, `client/dde/`, `_recompiled/`)

---

## 28. СДЕЛАНО — 6 ИЮНЯ 2026 (тестирование + фиксы)

### Что протестировано и исправлено

**PR Validation** — оба фикса применены ко всем трём копиям:

1. **`workflow_dispatch` → `source_repo` input** (новый):
   - Был баг: при ручном запуске `inputs.source_repo` пустой → checkout качал сам `css-devops-demo` → diff выдавал `["scripts", "environment_manifests"]` → classify падал на UNKNOWN
   - Исправление: добавлен `source_repo` в `workflow_dispatch.inputs` с дефолтом (`marmuzevichslava/css-demo` / `nationalgrid-customer/css-demo`)

2. **Em dash `—` → ASCII `-`** в error message PowerShell classify step:
   - Был баг: UTF-8 em dash (U+2014, byte `0x94`) в PowerShell 5.1 через cp1252 = RIGHT DOUBLE QUOTATION MARK → ломал парсинг всего if-блока
   - Исправление: `"failed — unrecognised"` → `"failed - unrecognised"`

**Build Pipeline** — `windows-latest` теперь `windows-2025-vs2026` (VS2026):

3. **vswhere для поиска VS** вместо hard-coded путей:
   - `windows-latest` перенаправлен на `windows-2025-vs2026` → VS2026 не по стандартным путям
   - Исправление: `vswhere -latest` находит любой VS автоматически, определяет toolset (`v143` для VS2022/2026, `v142` для VS2019)
   - **В root `build.yml` (→ личный GitHub)**: vswhere + закомментированные NG пути
   - **В `national-grid-ready/build.yml`**: фиксированные VS2019 пути, без изменений

### Результат тестирования (личный GitHub, 06.06.2026)

| Workflow | Результат |
|---|---|
| PR Validation (manual) | ✅ PASS — все 6 шагов |
| Build Pipeline (manual) | ✅ PASS — все 14 шагов включая MSBuild |

### Что НЕ менялось в `national-grid-ready/`

- `build.yml` — VS2019 пути не изменены (vswhere только для личного GitHub)
- `pr-validation-reusable.yml` — получил только: source_repo default + em dash fix (оба нужны и для NG)
- Все скрипты Python — идентичны root версии

---

## ARTIFACT NAMING — ✅ РЕАЛИЗОВАНО (5 июня 2026)

Ramesh предложил, реализовано в этой же сессии.

Формат: `yyyyMMdd.run_number.run_attempt.manual` (или `.push` для auto-triggered)

```
Пример: 20260605.142.1.manual
```

Реализовано в:
- `build.yml` — шаг "Generate build run ID" (step 1a)
- `build_manifest.py` — читает `BUILD_RUN_ID` env var
- Artifact upload name: `build-${{ steps.run_id.outputs.value }}`

**Открытый вопрос:** deploy.yml — оператор вводит числовой GitHub run_id из URL страницы билда (для `download-artifact` API). Нужно ли показывать human-readable ID в approval gate UI? Уточнить с Alan.


---

## 30. СТАТУС — 09-10 ИЮНЯ 2026

### BUILD PIPELINE — ПОДТВЕРЖДЁН НА NATIONAL GRID ✅

**Тест 09.06.2026 — PR #7 → artifact `build-20260609.39.1.PR7` (14 файлов, 67KB)**

Всё что работает на azuse-cssdapp01:
- PR Validation: ITT check ✅, diff analysis ✅, classify ✅, waves ✅
- Auto-trigger build via repository_dispatch ✅
- MSBuild C compile → `artifacts\BUILD\testmod1.exe` ✅
- COBOL staging → `artifacts\COBOL\SOMCOB01`, `SOMSVC01` ✅
- XLT_MAP + CODES_TABLE — определяются, попадают в manifest ✅
- Source file staging → `artifacts\source\` ✅
- build_manifest.json генерируется и загружается ✅

### ФИКСЫ ПРИМЕНЁННЫЕ 09-10 ИЮНЯ

1. **`shell: pwsh` → `shell: powershell`** — pwsh не установлен на NG раннерах
   - Файлы: `build.yml` (10 мест), `pr-validation-caller.yml` (2 места)

2. **`Out-File` → temp файл + `Set-Content -Encoding utf8`** — PowerShell 5 pipe в Out-File иногда не флушит stdout, файл пустой
   - Файлы: `build.yml` шаги 4, 5, 6

3. **`encoding='utf-8-sig'` в Python скриптах** — PowerShell 5 пишет UTF-8 с BOM, Python не может читать без utf-8-sig
   - Файлы: `classify_modules.py`, `resolve_build_sequence.py`, `build_manifest.py`

4. **`paths-ignore`** добавлен в `build.yml` — мержи в css-devops-demo (workflows/scripts) больше не тригерят build

5. **PMVT в `$environments` array** в deploy.yml Glob Report шаге — без него nextEnv считался неправильно

6. **`.gitignore`** — добавлен в css-demo чтобы `.DS_Store` файлы (macOS) не попадали в git

### AIX SSH — РЕШЕНО, файл создан Suryasish (10.06.2026) ✅

- **SSH ключи установлены на обоих серверах** (cssdapp01 + cssdapp02) ✅
- **FQDN:** `USNY7-CSSADV01.preprod.nationalgrid.com` ✅
- **Blocker РЕШЁН:** когда SSH передаёт команду напрямую (`ssh fcp@host 'command'`), `.profile` не выполняется → menu не появляется. Стандартное AIX/Unix поведение (Slava подтвердил).

**Suryasish создал `~fcp/profiles/.profile.github`** (10.06.2026). Содержимое:
```sh
. ~/.profile.cob
. ~/.profile.fcp
```
Грузит COBOL compiler + FCP env (LIBPATH и т.д.) без интерактивного menu. Каждая SSH-команда pipeline сорсит его.

⚠️ Путь — **`~/profiles/.profile.github`** (подпапка `profiles/`), не `~/.profile.github`.

SSH команда в pipeline:
```bash
ssh fcp@USNY7-CSSADV01.preprod.nationalgrid.com 'source ~/profiles/.profile.github && cd /css/c1/host/build && cob program.pco'
```

**Осталось:** Slava с cssdapp01 прогоняет `ssh fcp@USNY7-CSSADV01.preprod.nationalgrid.com 'echo test'` → ждём `test` без menu → затем вписываем реальные SSH-команды в deploy.yml.

### ЧТО ОБНОВИТЬ В КОДЕ (файл `.profile.github` готов — Suryasish создал)

В `deploy.yml` шаг "Deploy COBOL (AIX compile via SSH)" заменить placeholder:
```powershell
# БЫЛО (placeholder):
Write-Host "  [PLACEHOLDER] SSH + AIX COBOL compile: $($mod.module_id)"

# СТАНЕТ (путь к profile — ~/profiles/.profile.github; пути AIX из Section 0):
$src = "artifacts\COBOL\$($mod.module_id).pco"
scp $src fcp@USNY7-CSSADV01.preprod.nationalgrid.com:/css/c1/host/$env_name/source/
ssh fcp@USNY7-CSSADV01.preprod.nationalgrid.com "source ~/profiles/.profile.github && cd /css/c1/host/$env_name && cob $($mod.module_id).pco"
```
> Лучший вариант (Section 34): эту SSH-логику вынести в `compile.ksh` на AIX, а deploy.yml/`compile_client.ps1` будут его вызывать.

### СЛЕДУЮЩИЕ ШАГИ (обновлено 10.06.2026)

| Приоритет | Задача | Статус / Ждём |
|---|---|---|
| ✅ | AIX environment prompt для non-interactive SSH | РЕШЕНО — Suryasish создал `~fcp/profiles/.profile.github` |
| 1 | Прогнать `ssh fcp@... 'echo test'` без menu с cssdapp01 | Slava (RDP) |
| 2 | Walkthrough 'client compile' PR на митинге | Slava — завтра |
| 3 | Compile-скрипты: `compile.ksh` (AIX) + `compile_client.ps1` (Windows) | направление Alan, Section 34 |
| 4 | Реализовать COBOL deploy (SSH команды) в deploy.yml | после п.1 |
| 5 | Тест deploy workflow на azuse-cssdapp02 | можно сейчас |
| 6 | Сессия с Rick Wiggins — пути модулей + COBOL compile sequence | Suryasish организует |
| 7 | translation maps (mapload.exe) / codes tables (ktcdtupd.exe) | — |


---

## 31. СТАТУС ПО ТАСКАМИ GANTT (обновлено 10.06.2026)

### 3.5.2.3 — Client developer pipelines: BUILD, SVT

| Задача | % | Что сделано | Что осталось |
|---|---|---|---|
| **3.5.2.3.1** Configure Compile Server | **95%** | Runner ✅, VS2019 ✅, Python ✅, SSH ключ fcp установлен ✅ | AIX interactive prompt решить (Suryasish 11.06) |
| **3.5.2.3.2** PR details extraction (ITT, diff, cross-repo) | **100%** ✅ | ITT check ✅, diff analysis ✅, cross-repo dispatch ✅, auto-trigger build ✅ | — |
| **3.5.2.3.3** Compilation sequence (classify, waves, rules) | **80%** | classify_modules.py ✅, resolve_build_sequence.py ✅, build-sequence-rules.json ✅, тест на NG ✅ | Подтверждение путей Rick Wiggins (host-win, fsd, dde, AGS) |
| **3.5.2.3.4** Client pipelines C/AGS compile | **70%** | MSBuild C_PROJECT ✅ (testmod1 скомпилирован на NG), DDE staging ✅, HOST_WIN_C ✅ (provisional) | AGS путь подтвердить, Rick Wiggins сессия |
| **3.5.2.3.5** Translation maps import (mapload.exe) | **10%** | XLT_MAP определяется и попадает в manifest ✅ | mapload.exe вызов в deploy.yml — не реализован |
| **3.5.2.3.6** Codes tables import (ktcdtupd.exe) | **10%** | CODES_TABLE определяется и попадает в manifest ✅ | ktcdtupd.exe вызов в deploy.yml — не реализован |
| **3.5.2.3.7** Recompilation list process | **80%** ✅ | `_recompiled/*.lst` обработка в diff_analysis.py ✅, тест на NG ✅ | — |

**Итого 3.5.2.3 ≈ 65%** (было 27% на 09.06 утром)

### 3.5.2.5 — COBOL compile pipelines

| Задача | % | Что сделано | Что осталось |
|---|---|---|---|
| **3.5.2.5** COBOL compile BUILD/SVT | **80%** | SSH ключ ✅, FQDN ✅, staging ✅, placeholder ✅, AIX prompt решён ✅ (source ~/.profile.github) | Ждём .profile.github от Алана → потом SSH команды в deploy.yml |

### 3.5.2.7 — Deployment pipelines: BUILD, SVT

| Задача | % | Что сделано | Что осталось |
|---|---|---|---|
| **3.5.2.7.1** Impact Report | **90%** | Написан и работает | Тест на azuse-cssdapp02 |
| **3.5.2.7.2** Glob Report | **90%** | Написан и работает, PMVT фикс применён | Тест на azuse-cssdapp02 |
| **3.5.2.7.3** Approval Gate | **90%** | Написан | Тест на azuse-cssdapp02 |
| **3.5.2.7.4** C binary deploy → network share | **90%** | Написан | Тест на azuse-cssdapp02 |
| **3.5.2.7.5** AGS deployment | **0%** | ❌ | Не реализован |
| **3.5.2.7.6** Environment manifest update | **90%** | Написан | Тест на azuse-cssdapp02 |
| **3.5.2.7.7** SVT/PROD tracking branch | **100%** ✅ | Реализован 09.06 | — |
| **3.5.2.7.8** COBOL SSH deploy | **70%** | Placeholder написан, FQDN ✅, ключ ✅, prompt решён ✅ | .profile.github от Алана → реальные SSH команды |

### Следующие приоритеты

1. **Suryasish 11.06** — решить AIX interactive prompt → разблокирует COBOL deploy
2. **Тест deploy workflow** на azuse-cssdapp02 (всё кроме COBOL) — можно сейчас
3. **Rick Wiggins сессия** — подтвердить пути host-win, fsd, dde, AGS → закрыть 3.5.2.3.3 и 3.5.2.3.4
4. **После п.1** — написать реальные SSH команды для COBOL deploy
5. **После п.3** — реализовать mapload.exe и ktcdtupd.exe (3.5.2.3.5, 3.5.2.3.6)


---

## 32. compileConfig.xml — АНАЛИЗ И ЧТО НУЖНО ДЛЯ ПОЛНОГО build-sequence-rules.json (10.06.2026)

Файл сохранён: `css-devops-demo/project/compileConfig.xml` (от Alan Chin, источник: встреча 05.06.2026)

> **Ответ Alan (10.06.2026):** compileConfig — это **начальная** последовательность только для **client compile** и **будет правиться** (делалась под другого клиента). Порядок для **COBOL/AIX определяем на сессии с Rick**. ⇒ 5 недостающих правил и типы CSRMAP/FSD/client/app **сейчас НЕ добавляем** — ждём Rick.

### Порядок компиляции из XML (сверху вниз = строгая последовательность типов)

| # | matchRegex | Тип | Что это |
|---|---|---|---|
| 1 | `host\common\*.pco` | COBOL | AIX COBOL flat files |
| 2 | `host\service\*.pco` | COBOL | AIX COBOL flat files |
| 3 | `host-win\common\*.pco` | COBOL | host-win COBOL flat files |
| 4 | `host-win\common\<proj>\*` | HOST_WIN_C | vcxproj на Windows |
| 5 | `host-win\service\<proj>\*` | HOST_WIN_C | vcxproj на Windows |
| 6 | `client\common\<proj>\*` | C_PROJECT | Windows client DLL |
| 7 | `client\comwin\<proj>\*` | C_PROJECT | Windows client DLL |
| 8 | `client\dialog\<proj>\*` | C_PROJECT | Windows client EXE |
| 9 | `client\app\<proj>\*` | C_PROJECT | Windows client app (**не было в rules!**) |
| 10 | `host\copy\msg\*.xlt` | XLT_MAP | Translation map → addXlt.bat |
| 11 | `client\comwin\<proj>\*.map` | CSRMAP | CSR map файл → addCsrmap.bat (**новый тип!**) |
| 12 | `client\dialog\<proj>\*.map` | CSRMAP | CSR map файл → addCsrmap.bat (**новый тип!**) |
| 13 | `db\codestable\*.dat` | CODES_TABLE | → addCodestable.bat |
| 14 | `client\dde\*` | DDE | → addDde.bat |
| 15 | `fsd\<proj>\*` | FSD | → buildFsdProj.bat (**новый тип!**) |

### Что УЖЕ есть в build-sequence-rules.json ✅

- `host/service → host/batch` (COBOL ordering) ✅
- `client/common → C_PROJECT` ✅
- `client/comwin → client/dialog` ✅
- `client/common` intra-sequence (12 правил) ✅
- `AGS_MODULE → C_PROJECT` ✅

### Что ОТСУТСТВУЕТ — нужно добавить после Rick Wiggins ⚠️

| Правило | Откуда | Статус |
|---|---|---|
| `host/common → host/service` (COBOL inter-type) | XML rule order 1→2 | ⚠️ нет в rules |
| `COBOL → HOST_WIN_C` (host перед host-win vcxproj) | XML rule order 3→4 | ⚠️ нет в rules |
| `HOST_WIN_C → C_PROJECT` (host-win перед client) | XML rule order 5→6 | ⚠️ нет в rules |
| `host-win/common → host-win/service` | XML rule order 4→5 | ⚠️ нет в rules |
| `client/app` в compile sequence | XML rule 9 | ⚠️ client/app не в rules |

### Новые типы из XML (не в classify / module-map)

| Тип | Путь | Команда | Статус |
|---|---|---|---|
| **CSRMAP** | `client/comwin/<proj>/*.map`, `client/dialog/<proj>/*.map` | `addCsrmap.bat` | ❌ не реализован |
| **FSD** | `fsd/<proj>/*` | `buildFsdProj.bat` | ❌ не реализован |
| **client/app** | `client/app/<proj>/*` | `buildClientVcxProj.bat` | ❌ не в module-map |

### Что нужно сделать после Rick Wiggins сессии

1. Добавить 5 недостающих правил порядка в `build-sequence-rules.json`
2. Добавить `CSRMAP` тип в `classify_modules.py` и `module-map.json`
3. Добавить `FSD` тип в `classify_modules.py` и `module-map.json`
4. Добавить `client/app/*` модули в `module-map.json`
5. Реализовать `addCsrmap.bat` эквивалент в deploy.yml (если нужно)
6. Реализовать `buildFsdProj.bat` эквивалент в build.yml

---

## 33. МИТИНГ С SURYASISH — Q&A и вопрос Алану (11.06.2026)

### Контекст
На митинге Suryasish спрашивал: что скомпилировано, что такое FCP libraries, как запустить MSBuild вручную, что на выходе. Ниже — правильные ответы и что надо было сказать.

### Ключевое что надо говорить в начале любого митинга

> "The pipeline infrastructure is built and proven. `testmod1` is a dummy test module on my branch in css-demo — just to prove MSBuild works on the runner. We have NOT connected real CSS source code yet. That is the next step. We need input from two people: **Alan** for client-side structure, **Rick Wiggins** for AIX/COBOL side."

### CSS vs FCP — что это

- **CSS** = само приложение (Customer Service System). C++ клиент на Windows + COBOL на AIX.
- **FCP** = старая система сборки. Батники (`buildClientVcxProj.bat`, `buildCobolFile.bat`), PVCS triggers, утилиты (`ktcdtupd.exe`, `mapload.exe`). **Мы их заменяем.**
- **Что остаётся из FCP:** сами исходные файлы — copybooks, .map файлы, codes tables, .dat, .xlt — они в репо, pipeline их обрабатывает.
- **Pipeline зависимости:** только MSBuild, Python, Git. Никаких FCP батников.

### Правильные ответы на вопросы Suryasish

**"Покажи пример — что скомпилировано"**
PR #7 → артефакт `build-20260609.39.1.PR7`:
- `artifacts\BUILD\testmod1.dll` — скомпилирован на azuse-cssdapp01 через VS2019 MSBuild ✅
- `artifacts\COBOL\` — staged COBOL source для AIX
- `build_manifest.json` — каждый модуль, ITT ticket, source files, статус

**"Как запустить MSBuild вручную"**
css-demo должен быть склонирован на сервере (pipeline делает git checkout автоматически). Manual:
```powershell
cd C:\projects\css-demo\client\dialog\testmod1
msbuild testmod1.vcxproj /p:Configuration=Release /p:Platform=Win32
```

**"Where are FCP modules in your codebase?"**
Pipeline не вызывает FCP батники вообще. CSS source файлы (copybooks, map, dat, xlt) остаются в репо. Мы меняем инструменты сборки, не source.

**"What is the output?"**
Versioned GitHub Actions artifact `build-YYYYMMDD.run.attempt.PRxx`. Содержит DLL/EXE (BUILD/), COBOL source (COBOL/), build_manifest.json. Один артефакт — промоутится на все env без рекомпиляции.

**"Next steps and blockers?"**
1. AIX interactive prompt — Suryasish пришлёт решение
2. Rick Wiggins сессия — host/COBOL пути
3. Alan сессия — client пути и FCP include headers вопрос

### Вопросы Алану — ОТВЕЧЕНЫ Аланом (10.06.2026) ✅

**1. FCP includes/dependencies** — есть ли FCP SDK include paths / runtime libs / env dependencies на azuse-cssdapp01, или `.vcxproj` самодостаточен?
> **Ответ Alan:** env-конфиги для компиляции (include paths и пр.) **нужны**. **НЕ все хедеры в css-demo** — FCP-хедеры подтягиваются через **environment-переменные**, которые выставит compile-скрипт (Section 34). ⇒ Windows compile-скрипт перед MSBuild должен выставлять FCP env (FND32/includes).

**2. compileConfig.xml как source of truth?**
> **Ответ Alan:** compileConfig — **начальная** последовательность только для **client compile** и **её придётся править** (делалась под другого клиента). Порядок для **AIX/COBOL — определяем на сессии с Rick**. ⇒ provisional правила/типы сейчас НЕ добавляем (Section 32).

**3. CIS Platform Library на HomeLink (документация) — preferred location?**
> **Ответ Alan:** скорее подойдёт, но у Alan нет modify-доступа — **запросил у Martin Polacek**. Ждём доступ.

---

## 34. НАПРАВЛЕНИЕ ОТ ALAN — компиляция через отдельные скрипты (10.06.2026)

Alan: логика компиляции должна жить в **отдельных wrapper-скриптах, которые вызывает workflow**, а не в YAML. Плюс — скрипты можно гонять/тестировать в изоляции прямо на сервере.

- **AIX:** `compile.ksh` — workflow вызывает с аргументами (что компилировать, COBOL). Тестируется standalone на AIX. Sequence для него — определяем с Rick.
- **Windows:** параллельный **client compile-скрипт** (C/AGS), напр. `compile_client.ps1` — рефакторим MSBuild-циклы из `build.yml` в него; принимает модуль/волну; **выставляет FCP env (FND32/includes)** перед MSBuild (ответ Alan Q1 — не все хедеры в репо).

**Завтра:** Slava проводит **walkthrough 'client compile' PR** на митинге.

