COLUMN msg FORMAT A60
SELECT 'Attempting: INSERT INTO club_president VALUES (C001, aa1001, SYSDATE)' AS msg FROM dual;
INSERT INTO club_president (club_id, student_id, appointment_date) VALUES ('C001', 'aa1001', SYSDATE);
SELECT 'ERROR: Insert should have failed!' AS msg FROM dual;
ROLLBACK;
