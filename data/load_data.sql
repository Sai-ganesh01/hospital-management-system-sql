USE hm;

-- Load Patients Data
LOAD DATA INFILE 'patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(patient_id, patient_name, age, gender);

-- Load Doctors Data
LOAD DATA INFILE 'doctors.csv'
INTO TABLE doctors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(doctor_id, doctor_name, specialization);

-- Load Appointments Data
LOAD DATA INFILE 'appointments.csv'
INTO TABLE appointments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(appointment_id, patient_id, doctor_id, appointment_date, status);

-- Load Treatments Data
LOAD DATA INFILE 'treatments.csv'
INTO TABLE treatments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(treatment_id, appointment_id, treatment_name, cost);
