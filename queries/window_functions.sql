-- =========================================
-- WINDOW FUNCTION QUERIES
-- Hospital Management System
-- =========================================


-- Appointment running number per doctor (oldest to newest)

SELECT 
    d.doctor_name,
    a.appointment_id,
    a.appointment_date,
    ROW_NUMBER() OVER (
        PARTITION BY d.doctor_id 
        ORDER BY a.appointment_date ASC
    ) AS appointment_number_per_doctor
FROM appointments a
JOIN doctors d
    ON a.doctor_id = d.doctor_id;



-- Latest appointment per doctor

SELECT 
    doctor_name,
    appointment_id,
    appointment_date
FROM (
    SELECT 
        d.doctor_name,
        a.appointment_id,
        a.appointment_date,
        ROW_NUMBER() OVER (
            PARTITION BY d.doctor_id 
            ORDER BY a.appointment_date DESC
        ) AS rn
    FROM appointments a
    JOIN doctors d
        ON a.doctor_id = d.doctor_id
) ranked
WHERE rn = 1;



-- Last 2 appointments per doctor

SELECT 
    doctor_name,
    appointment_id,
    appointment_date
FROM (
    SELECT 
        d.doctor_name,
        a.appointment_id,
        a.appointment_date,
        ROW_NUMBER() OVER (
            PARTITION BY d.doctor_id 
            ORDER BY a.appointment_date DESC
        ) AS rn
    FROM appointments a
    JOIN doctors d
        ON a.doctor_id = d.doctor_id
) ranked
WHERE rn <= 2;



-- Gap in days between consecutive appointments per doctor

SELECT
    doctor_name,
    appointment_id,
    appointment_date,
    DATEDIFF(
        appointment_date,
        LAG(appointment_date) OVER (
            PARTITION BY doctor_id
            ORDER BY appointment_date
        )
    ) AS days_since_previous_appointment
FROM (
    SELECT
        d.doctor_id,
        d.doctor_name,
        a.appointment_id,
        a.appointment_date
    FROM appointments a
    JOIN doctors d
        ON a.doctor_id = d.doctor_id
) temp;



-- Doctors whose latest appointment is CANCELLED

SELECT 
    doctor_name,
    appointment_id,
    appointment_date,
    status
FROM (
    SELECT 
        d.doctor_name,
        a.appointment_id,
        a.appointment_date,
        a.status,
        ROW_NUMBER() OVER (
            PARTITION BY d.doctor_id 
            ORDER BY a.appointment_date DESC
        ) AS rn
    FROM appointments a
    JOIN doctors d
        ON a.doctor_id = d.doctor_id
) ranked
WHERE rn = 1
AND status = 'CANCELLED';
