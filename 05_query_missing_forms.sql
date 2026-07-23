COLUMN student_id FORMAT A10
COLUMN student_name FORMAT A25
COLUMN phone_number FORMAT A15
SELECT s.student_id, s.student_name, s.phone_number
FROM student s
WHERE s.approval_form = 'N'
  AND EXISTS (
      SELECT 1 FROM membership m WHERE m.student_id = s.student_id
  )
ORDER BY s.student_name;
