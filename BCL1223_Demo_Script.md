# BCL1223 Database Fundamentals — Demo Script

**Student:** _________________  
**ID:** _________________  
**Date:** Saturday, 8 August 2026 (Week 11, 4th Live Session)  
**Platform:** MS Teams — screen share + camera on  
**Duration:** ~5-7 minutes  

---

## Before Demo (have these ready)

- [ ] **GitHub Codespace** open in your browser (this is your main demo window)
- [ ] **CloudBeaver** tab open at `http://localhost:8978` — connected to Oracle
- [ ] **VS Code**: `20260718_Database_Fundamentals_Assignment.md` open in Preview (Ctrl+Shift+V)
- [ ] **Camera**: On. No need to dress up, just be presentable
- [ ] **Mute notifications** on your PC

---

## Demo Flow

### 1. ERD & Design → "What I built" (1.5 min)

**Share your report PDF**, scroll to the ERD diagram.

> *"Good morning. I built a database for the SEGi Student Clubs and Societies system. I have **11 tables** total.
> The core entities are FACULTY, STUDENT, CLUB, ADVISOR, VENUE, EVENT, and SEMESTER.
> 
> The key design decisions:
> - **MEMBERSHIP** — a junction table because one student can join many clubs, one club has many students (M:N).
> - **EVENT_REGISTRATION** — tracks which student signed up for which event. I also used it to enforce that only club members can register for a club's event.
> - **CLUB_PRESIDENT** — separate table with a composite FK back to MEMBERSHIP so Oracle won't let me appoint a president who isn't already a member.
> 
> Everything is normalized to 3NF — no repeating groups, no transitive dependencies."*

### 2. Switch to Code Runner → "Show it working" (1.5 min)

**Share your Codespace** (screen share the whole window).

> *"Here's my database running in a Dockerized Oracle instance inside this Codespace."*

Open each `.sql` file, right-click → **Run Code** (or `Ctrl+Alt+N`), explain after each:

**File `01_show_tables.sql`** → Run Code

> *"11 tables — all normalized to 3NF."*

**File `02_row_counts.sql`** → Run Code

> *"228 rows of seed data."*

**File `03_constraint_test.sql`** → Run Code

> *"This is the most impressive part — Oracle rejects it because aa1001 isn't a member of club C001. This is the composite FK `fk_president_membership` that references MEMBERSHIP. The database enforces the rule, not the application code."*

### 3. Run 3 Queries Live → "Reports" (2-3 min)

**Query 1 — Multi-club advisors** → open `04_query_multiclub_advisors.sql` → **Run Code**
> *"Management wanted to know which lecturers advise more than one club. The JOIN links advisors to their clubs, GROUP BY counts them, HAVING filters for 2+, and LISTAGG shows which clubs."*

**Query 2 — Missing approval forms** → open `05_query_missing_forms.sql` → **Run Code**
> *"Staff need to call students who joined a club but haven't submitted their faculty approval form. The correlated subquery with EXISTS ensures we only list students who actually enrolled in a club — not those who never signed up."*

**Query 3 — Pivot by semester** → open `06_query_pivot.sql` → **Run Code**
> *"This uses Oracle's PIVOT to turn semester rows into columns. Now staff can see at a glance: Dr. Aisha has 3 events every semester. Only advisors with assigned events appear — hence 10 rows not 15."*

### 4. Wrap-up (30 sec)

> *"That covers the main points:
> - 11 normalized tables with 228 rows
> - All PK, FK, CHECK, UNIQUE constraints enforced
> - 6 rejection tests passed (Oracle blocks bad data)
> - All 6 assessment queries return correct results
> 
> Thank you."*

---

## If the lecturer asks questions

| Question | Answer |
|----------|--------|
| "Why did you add EVENT_REGISTRATION?" | *"Because attending an event is different from being a club member. A student can be a member but not attend — separate table captures both facts."* |
| "Why not put president in CLUB table?" | *"Then I couldn't enforce that the president must be a member. With CLUB_PRESIDENT, I use a composite FK to MEMBERSHIP."* |
| "What tool did you use?" | *"I developed in Oracle Live SQL and SQL*Plus. This demo runs Oracle Database Free in Docker inside a GitHub Codespace — everything is in one window."* |
| "Did you use AI?" | *"I used it for brainstorming ideas and debugging syntax, but I wrote and understand every line. The design decisions are mine."* |
| "What normalization level?" | *"3NF. MEMBERSHIP resolves M:N, no transitive dependencies — faculty name is in FACULTY, not repeated in STUDENT."* |

---

## Quick Reference Sheet

**Your 11 tables:** FACULTY, ADVISOR, VENUE_PIC, SEMESTER, STUDENT, CLUB, VENUE, MEMBERSHIP, CLUB_PRESIDENT, EVENT, EVENT_REGISTRATION

**Your 228 rows:** 10 + 10 + 10 + 3 + 30 + 15 + 10 + 50 + 15 + 45 + 30

**Your 6 queries:** phone list, multi-club advisors, missing forms, event schedule, pivot table, club assignments

**Your DB:** Oracle AI Database 26ai Free 23.26.2.0.0

## VS Code: Right-click → Run Code

**Code Runner** is pre-installed. For any `.sql` file:
- Right-click in the editor → **Run Code** (or `Ctrl+Alt+N`)
- File runs against Oracle, output appears in terminal tab
- Use this for each demo step instead of typing terminal commands

## CloudBeaver Connection Details

| Field | Value |
|-------|-------|
| **Host** | `oracle-demo` |
| **Port** | `1521` |
| **Database** | `FREEPDB1` |
| **Username** | `system` |
| **Password** | `oracle` |

## Terminal Quick Reference

| Step | Command |
|------|---------|
| 1. Show 11 tables | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 01_show_tables.sql` |
| 2. Row counts | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 02_row_counts.sql` |
| 3. Constraint test | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 03_constraint_test.sql` |
| 4. Multi-club advisors | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 04_query_multiclub_advisors.sql` |
| 5. Missing forms | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 05_query_missing_forms.sql` |
| 6. Pivot table | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 06_query_pivot.sql` |
| Run all at once | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < demo_queries.sql` |
| Interactive SQL | `docker exec -it oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1` |
| Build database | `./run_sql.sh` |
