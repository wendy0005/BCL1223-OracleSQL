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

## Quick start: run the database on Oracle Live SQL

1. Go to [https://livesql.oracle.com/](https://livesql.oracle.com/) and sign in.
2. Click **SQL Worksheet**.
3. Open `20260718_Database_Fundamentals_Assignment_LiveSQL.sql` from this repo.
4. Copy the entire contents into the worksheet.
5. Click **Run** (or press `Ctrl+Enter` / `Cmd+Enter`).
6. The script will:
   - Drop any existing tables (if rerunning)
   - Create all 11 tables and constraints
   - Insert sample data (10 faculties, 30 students, 15 clubs, 50 memberships, etc.)
   - Execute the required queries and validation tests

---

## Presenting with GitHub Codespaces (recommended)

This repo is configured with a GitHub Codespace — the easiest way to present during your demo.

1. Click the **"Open in GitHub Codespaces"** badge at the top of this README (or go to `Code > Codespaces > Create codespace on main`)
2. In Codespace, open `BCL1223_Demo_Script.md` in the VS Code editor to follow your demo flow
3. Preview the report: right-click `20260718_Database_Fundamentals_Assignment.md` > **Open Preview**
4. For the live SQL portion, switch to your browser tab with **Oracle Live SQL**: https://livesql.oracle.com/
5. Copy the contents of `20260718_Database_Fundamentals_Assignment_LiveSQL.sql` into Live SQL and run it

You have the full VS Code editor, file tree, and terminal available — the lecturer will see your screen as you navigate everything from one place.

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
