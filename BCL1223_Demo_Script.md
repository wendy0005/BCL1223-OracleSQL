# BCL1223 Database Fundamentals — Demo Script

**Student:** _________________  
**ID:** _________________  
**Date:** Saturday, 8 August 2026 (Week 11, 4th Live Session)  
**Platform:** MS Teams — screen share + camera on  
**Duration:** ~5-7 minutes  

---

## Before Demo (have these ready)

- [ ] **GitHub Codespace** open in your browser (this is your main demo window)
- [ ] **Codespace terminal**: `./run_sql.sh` already done (database built and populated)
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

### 2. Switch to Codespace Terminal → "Show it working" (1.5 min)

**Share your Codespace terminal** (screen share the whole window).

> *"Here's my database running in a Dockerized Oracle instance inside this Codespace."*

```bash
# Run all proof queries at once:
docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < demo_queries.sql
```

Or step by step:

**Step 2a — Show 11 tables + row counts:**

```sql
SELECT table_name FROM user_tables ORDER BY table_name;
```

> *"11 tables — all normalized to 3NF. 228 rows of seed data total."*

**Step 2b — Run rejection test** (the most impressive part):

```sql
-- Try to insert a president who isn't a member yet
INSERT INTO club_president (club_id, student_id, appointment_date) VALUES ('C001', 'aa1001', SYSDATE);
```

> *"Oracle rejects it because aa1001 isn't a member of club C001. This is the composite FK I mentioned — `fk_president_membership` references the MEMBERSHIP table. The database enforces the rule, not the application code."*

### 3. Run 3 Queries Live → "Reports" (2-3 min)

**Query 1 — Multi-club advisors** (JOIN + GROUP BY + HAVING):

```sql
SELECT a.advisor_name,
       COUNT(c.club_id) AS number_of_clubs,
       LISTAGG(c.club_name, '; ') WITHIN GROUP (ORDER BY c.club_name) AS assigned_clubs
FROM advisor a
JOIN club c ON c.advisor_id = a.advisor_id
GROUP BY a.advisor_id, a.advisor_name
HAVING COUNT(c.club_id) > 1
ORDER BY a.advisor_name;
```

> *"Management wanted to know which lecturers advise more than one club. The JOIN links advisors to their clubs, GROUP BY counts them, HAVING filters for 2+, and LISTAGG shows which clubs."*

**Query 2 — Missing approval forms** (correlated subquery):

```sql
SELECT s.student_id, s.student_name, s.phone_number
FROM student s
WHERE s.approval_form = 'N'
  AND EXISTS (
      SELECT 1 FROM membership m WHERE m.student_id = s.student_id
  )
ORDER BY s.student_name;
```

> *"Staff need to call students who joined a club but haven't submitted their faculty approval form. The correlated subquery with EXISTS ensures we only list students who actually enrolled in a club — not those who never signed up."*

**Query 3 — Pivot by semester** (spreadsheet output):

```sql
SELECT advisor_name,
       NVL(may_aug_2026, 0) AS may_aug_2026,
       NVL(sep_dec_2026, 0) AS sep_dec_2026,
       NVL(jan_apr_2027, 0) AS jan_apr_2027
FROM (
    SELECT a.advisor_name, s.semester_name, e.event_id
    FROM advisor a
    LEFT JOIN club c ON c.advisor_id = a.advisor_id
    LEFT JOIN event e ON e.club_id = c.club_id
    LEFT JOIN semester s ON s.semester_id = e.semester_id
)
PIVOT (
    COUNT(event_id)
    FOR semester_name IN (
        'May-Aug 2026' AS may_aug_2026,
        'Sep-Dec 2026' AS sep_dec_2026,
        'Jan-Apr 2027' AS jan_apr_2027
    )
)
ORDER BY advisor_name;
```

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

## Terminal Quick Reference (copy-paste these)

| What | Command |
|------|---------|
| Run all proof queries | `docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < demo_queries.sql` |
| Interactive SQL | `docker exec -it oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1` |
| Run your build script | `./run_sql.sh` |
| Check Oracle is alive | `docker exec oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 "SELECT 1 FROM dual;"` |
