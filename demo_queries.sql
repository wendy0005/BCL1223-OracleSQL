COLUMN table_name FORMAT A30
COLUMN constraint_name FORMAT A30
COLUMN constraint_type FORMAT A15
COLUMN status FORMAT A10
COLUMN rows FORMAT 99999

PROMPT ==========================================
PROMPT 1. LIST ALL 11 TABLES
PROMPT ==========================================
SELECT table_name FROM user_tables ORDER BY table_name;

PROMPT
PROMPT ==========================================
PROMPT 2. ROW COUNTS PER TABLE (228 total)
PROMPT ==========================================
SELECT 'FACULTY' AS table_name, COUNT(*) AS rows FROM faculty
UNION ALL SELECT 'ADVISOR', COUNT(*) FROM advisor
UNION ALL SELECT 'VENUE_PIC', COUNT(*) FROM venue_pic
UNION ALL SELECT 'SEMESTER', COUNT(*) FROM semester
UNION ALL SELECT 'STUDENT', COUNT(*) FROM student
UNION ALL SELECT 'CLUB', COUNT(*) FROM club
UNION ALL SELECT 'VENUE', COUNT(*) FROM venue
UNION ALL SELECT 'MEMBERSHIP', COUNT(*) FROM membership
UNION ALL SELECT 'CLUB_PRESIDENT', COUNT(*) FROM club_president
UNION ALL SELECT 'EVENT', COUNT(*) FROM event
UNION ALL SELECT 'EVENT_REGISTRATION', COUNT(*) FROM event_registration
ORDER BY table_name;

PROMPT
PROMPT ==========================================
PROMPT 3. CONSTRAINT ENFORCEMENT TEST
PROMPT Try to insert a president who is NOT a member
PROMPT ==========================================
INSERT INTO club_president (club_id, student_id, appointment_date) VALUES ('C001', 'aa1001', SYSDATE);
PROMPT (Oracle should reject this with ORA-02291)

PROMPT
PROMPT ==========================================
PROMPT 4. QUERY 1 - MULTI-CLUB ADVISORS
PROMPT ==========================================
SELECT a.advisor_name,
       COUNT(c.club_id) AS number_of_clubs,
       LISTAGG(c.club_name, '; ') WITHIN GROUP (ORDER BY c.club_name) AS assigned_clubs
FROM advisor a
JOIN club c ON c.advisor_id = a.advisor_id
GROUP BY a.advisor_id, a.advisor_name
HAVING COUNT(c.club_id) > 1
ORDER BY a.advisor_name;

PROMPT
PROMPT ==========================================
PROMPT 5. QUERY 2 - MISSING APPROVAL FORMS
PROMPT ==========================================
SELECT s.student_id, s.student_name, s.phone_number
FROM student s
WHERE s.approval_form = 'N'
  AND EXISTS (
      SELECT 1 FROM membership m WHERE m.student_id = s.student_id
  )
ORDER BY s.student_name;

PROMPT
PROMPT ==========================================
PROMPT 6. QUERY 3 - PIVOT BY SEMESTER
PROMPT ==========================================
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

PROMPT
PROMPT ==========================================
PROMPT DONE - ALL QUERIES COMPLETE
PROMPT ==========================================
