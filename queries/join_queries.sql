-- =========================================
-- JOIN QUERIES
-- Hospital Management System
-- =========================================


-- List all appointments with patient name, doctor name, date and status

SELECT 
    p.patient_name,
    d.doctor_name,
    a.appointment_date,
    a.status
FROM appointments a
JOIN patients p 
    ON p.patient_id = a.patient_id
JOIN doctors d 
    ON a.doctor_id = d.doctor_id;



-- List only COMPLETED appointments with patient and doctor details

SELECT 
    p.patient_name,
    d.doctor_name,
    a.appointment_date
FROM appointments a
JOIN patients p 
    ON p.patient_id = a.patient_id
JOIN doctors d 
    ON a.doctor_id = d.doctor_id
WHERE a.status = 'COMPLETED';



-- Patients who have MORE THAN 1 appointment

SELECT 
    p.patient_name,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
JOIN appointments a 
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
HAVING COUNT(a.appointment_id) > 1;
