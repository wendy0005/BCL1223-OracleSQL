COLUMN advisor_name FORMAT A20
COLUMN may_aug_2026 FORMAT 99999
COLUMN sep_dec_2026 FORMAT 99999
COLUMN jan_apr_2027 FORMAT 99999
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
