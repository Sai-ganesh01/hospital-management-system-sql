-- =========================================
-- BASIC QUERIES
-- Hospital Management System
-- =========================================


-- View all patients
SELECT * FROM patients;


-- View all doctors
SELECT * FROM doctors;


-- View all appointments
SELECT * FROM appointments;


-- View all treatments
SELECT * FROM treatments;


-- Total number of patients
SELECT COUNT(*) AS total_patients FROM patients;


-- Total number of doctors
SELECT COUNT(*) AS total_doctors FROM doctors;


-- Total number of appointments
SELECT COUNT(*) AS total_appointments FROM appointments;


-- Total number of treatments
SELECT COUNT(*) AS total_treatments FROM treatments;
