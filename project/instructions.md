# National Grid — FCP Remediation
## DevOps Engineer: Slava Marmuzevich
### Полный контекст проекта (обновлено: май 2026)

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
- Deployment Server → AIX ❌ заблокирован (timeout) — Alan разбирается с Jamil (firewall team)

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
│   ├── dialog/           # C EXE модули (main CSS UI)
│   ├── comwin/           # C DLL модули
│   ├── ags/cug*/         # AGS DLL модули
│   └── xltmap/           # XLT translation maps (.xlt)
├── host/
│   ├── batch/            # COBOL batch программы
│   ├── service/          # COBOL online services
│   ├── io/               # COBOL I/O copybooks
│   └── copy/             # COBOL copybooks (lib/, nongen/)
└── db/
    └── codestable/       # Codes tables (.dat)
```

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
- PR Validation работает на NG серверах ✅
- Blocker: Python не установлен на azuse-cssdapp01
- Alan ответил: открыть SNOW тикет к Wintel team
- Alan рекомендует: **Python 3.14** (поддержка до 2030-10)
- Наши скрипты совместимы с 3.14 ✅ (используем только stdlib)
- SNOW тикет открыт на azuse-cssdapp01 (cssdapp02 не нужен — там только PowerShell)

### Статус задач
| Задача | Статус |
|---|---|
| PR Validation на NG | ✅ работает (blocker: Python) |
| Python на cssdapp01 | 🔄 SNOW тикет открыт к Wintel |
| SSH ключ → AIX | ❌ ждём Suryasish |
| Firewall cssdapp02 → AIX | ❌ ждём Suryasish + Jamil |
| css-demo на NG — только `notify-pipeline.yml` | ⬜ не начато |
| css-devops-demo на NG — workflows + scripts | ⬜ не начато |

### Новое из митинга 01.06.2026

**Python:**
- Alan скачал Python 3.14 MSI installer на сервер → `E:\devops\software\`
- Ramesh поднял риск: Software Center имеет 3.12 — если IT заставит использовать его, будет конфликт
- Ramesh взял на себя: спросить James/Wintel какая версия разрешена
- Пока ждём ответа — не устанавливать

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
