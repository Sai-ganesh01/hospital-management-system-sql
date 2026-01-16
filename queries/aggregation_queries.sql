-- =========================================
-- AGGREGATION & KPI QUERIES
-- Hospital Management System
-- =========================================


-- Doctor wise COMPLETED appointment count

SELECT 
    d.doctor_name,
    COUNT(a.appointment_id) AS completed_appointments_count
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
WHERE a.status = 'COMPLETED'
GROUP BY d.doctor_name;



-- Doctors who handled MORE THAN 10 appointments

SELECT 
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
HAVING COUNT(a.appointment_id) > 10;



-- TOP 3 doctors by total treatment revenue

SELECT 
    d.doctor_name,
    SUM(t.cost) AS total_revenue
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_name
ORDER BY total_revenue DESC
LIMIT 3;



-- Patients who spent MORE THAN 10000 in treatments

SELECT 
    p.patient_name,
    SUM(t.cost) AS total_spent
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY p.patient_id, p.patient_name
HAVING SUM(t.cost) > 10000;



-- Month with HIGHEST number of appointments

SELECT 
    DATE_FORMAT(appointment_date, '%Y-%m') AS year_month,
    COUNT(appointment_id) AS total_appointments
FROM appointments
GROUP BY year_month
ORDER BY total_appointments DESC
LIMIT 1;



-- Doctors contributing more than 30% of hospital revenue

SELECT
    doctor_name,
    doctor_revenue,
    hospital_revenue,
    (doctor_revenue / hospital_revenue) * 100 AS contribution_percentage
FROM (
    SELECT
        d.doctor_name,
        SUM(t.cost) AS doctor_revenue,
        SUM(SUM(t.cost)) OVER () AS hospital_revenue
    FROM doctors d
    JOIN appointments a
        ON d.doctor_id = a.doctor_id
    JOIN treatments t
        ON a.appointment_id = t.appointment_id
    GROUP BY d.doctor_name
) revenue_data
WHERE (doctor_revenue / hospital_revenue) * 100 > 30;
