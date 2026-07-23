# BCL1223 Database Fundamentals — SEGi Student Clubs and Societies Database

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/wendy0005/BCL1223-OracleSQL)

This repository contains the continuous assessment submission for **BCL1223 Database Fundamentals**.

| | |
|---|---|
| **Student** | Chan Jing Yi |
| **Student ID** | SUOL2500321 |
| **Programme** | Bachelor of Information Technology (Hons) / Bachelor of Computer Science |
| **Submission Date** | 25 July 2026 |
| **Report Date** | 18 July 2026 |

---

## What this project is

A complete Oracle database design and implementation for a fictional **SEGi Student Clubs and Societies** system. The schema covers:

- **Faculties** and **students**
- **Clubs**, **advisors**, and **memberships**
- Elected **club presidents**
- **Venues** and venue person-in-charge
- **Events** scheduled across **semesters**
- **Event registrations** with a business rule: only club members can register for a club's event

The database contains **11 normalized relations** with referential integrity enforced through primary keys, foreign keys, unique constraints, and check constraints.

---

## Repository guide

| File | What it is | How to use it |
|---|---|---|
| `20260718_Database_Fundamentals_Assignment.md` | Full report (Task 1–4) | Read the design, ERD, data dictionary, and SQL explanations |
| `20260718_Database_Fundamentals_Assignment.html` | Rendered HTML version of the report | Open in a browser for nicer formatting |
| `20260718_Database_Fundamentals_Assignment.pdf` | PDF version of the report | Best for sharing/printing |
| `20260718_Database_Fundamentals_Assignment.sql` | Full SQL build script | Run in Oracle SQL*Plus / Oracle AI Database Free |
| `20260718_Database_Fundamentals_Assignment_LiveSQL.sql` | Live SQL friendly version | Run on [Oracle Live SQL](https://livesql.oracle.com/) (no `SET`/`SPOOL` commands) |
| `20260718_Database_Fundamentals_Assignment_Oracle_Output.txt` | Captured output log | Shows the script executing successfully and validation results |
| `20260718_render_assignment.py` | Python helper | Converts the Markdown report to HTML and PDF |
| `BCL1223_Demo_Script.md` | Demo script | Step-by-step script for the live demonstration to the lecturer |
| `DatabaseFundamentalAssignmentMay-Aug2026.pdf` | Assignment brief | Original module brief for reference |

---

## Quick start: run the SQL (two ways)

### Option A: Docker (in Codespace)

```bash
./run_sql.sh
```

This runs `20260718_Database_Fundamentals_Assignment_LiveSQL.sql` against the local Oracle container.

### Option B: Oracle Live SQL (fallback)

1. Go to [https://livesql.oracle.com/](https://livesql.oracle.com/) and sign in.
2. Click **SQL Worksheet**.
3. Open `20260718_Database_Fundamentals_Assignment_LiveSQL.sql` from this repo.
4. Copy the entire contents into the worksheet.
5. Click **Run**.

### What the script does
- Drop any existing tables (safe to rerun)
- Create all 11 tables and constraints
- Insert sample data (10 faculties, 30 students, 15 clubs, 50 memberships, etc.)
- Execute the required queries and validation tests

---

## Presenting with GitHub Codespaces (recommended)

This repo is configured with a GitHub Codespace that runs **Oracle Database Free** + **CloudBeaver GUI** inside Docker containers — no external website needed.

1. Click the **"Open in GitHub Codespaces"** badge at the top of this README
2. Wait for setup to complete (~5 min first time — pulls Oracle + CloudBeaver images)
3. VS Code will auto-open CloudBeaver in a browser tab at `http://localhost:8978`
4. Create an admin account on first visit, then add a database connection:
   - **Host:** `localhost` | **Port:** `1521`
   - **Database:** `FREEPDB1` | **User:** `system` | **Password:** `oracle`
5. You now have a full GUI — click tables to explore data, use the SQL Editor to run queries
6. Also open `BCL1223_Demo_Script.md` and preview the report for the demo walkthrough

### What CloudBeaver gives you
- **Database Navigator** — expand tables, see columns and data types at a glance
- **Data viewer** — double-click any table to browse all rows in a grid
- **SQL Editor** — write queries, execute, see results in a table
- **Connection panel** — manage multiple Oracle connections

### Terminal (backup)
```bash
./run_sql.sh                    # Build the whole database
docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 01_show_tables.sql
```

---

## Key design highlights

- **Normalized to 3NF** — no repeating groups, no partial dependencies, no transitive dependencies.
- **M:N relationship** between `STUDENT` and `CLUB` resolved via the `MEMBERSHIP` junction table.
- **Composite foreign keys** in `EVENT_REGISTRATION` enforce that only a member of the organising club can register for an event.
- **`CLUB_PRESIDENT`** is linked back to `MEMBERSHIP`, so a president must already be a member of that club.
- **Six deliberate invalid transactions** are included in the script to demonstrate that the constraints reject bad data.

---

## Demo flow

See `BCL1223_Demo_Script.md` for the full 5–7 minute demo script, including:

1. ERD & design walkthrough
2. Oracle Live SQL execution
3. Query results and constraint validation

---

## Notes

- This is a fictional assessment dataset. Club names were inspired by publicly listed SEGi College student organisations but do not represent live operational records.

---

## License / academic use

This repository is for academic demonstration purposes for the BCL1223 module assessment.
