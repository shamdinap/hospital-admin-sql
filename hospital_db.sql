CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;
-- Dept table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
USE hospital_db;
-- 2️⃣ Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    phone VARCHAR(15),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id));
USE hospital_db;
--  Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15)
);
USE hospital_db;
--  Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Completed', 'Pending', 'Cancelled') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
USE hospital_db;
-- Billing Table
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    bill_date DATE NOT NULL,
    payment_status ENUM('Paid', 'Unpaid') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
Use hospital_db;
-- Departments Data
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'General Medicine');

-- Doctors Data
INSERT INTO Doctors (doctor_id, doctor_name, specialization, department_id, phone) VALUES
(1, 'Dr. Anil Kumar', 'Cardiologist', 1, '9876543210'),
(2, 'Dr. Meera Nair', 'Neurologist', 2, '9876543222'),
(3, 'Dr. John Thomas', 'Orthopedic', 3, '9876543233');

-- Patients Data
INSERT INTO Patients (patient_id, patient_name, age, gender, phone) VALUES
(1, 'Rahul Menon', 35, 'Male', '9123456780'),
(2, 'Anjali Devi', 28, 'Female', '9123456791'),
(3, 'Suresh Kumar', 52, 'Male', '9123456792');

-- Appointments Data
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1, 1, 1, '2025-01-05', '10:30:00', 'Completed'),
(2, 2, 2, '2025-01-06', '11:00:00', 'Pending'),
(3, 3, 1, '2025-01-06', '12:00:00', 'Cancelled');

-- Billing Data
INSERT INTO Billing (bill_id, patient_id, amount, bill_date, payment_status) VALUES
(1, 1, 2500.00, '2025-01-05', 'Paid'),
(2, 2, 4000.00, '2025-01-06', 'Unpaid'),
(3, 3, 1500.00, '2025-01-06', 'Paid');
SELECT * FROM Departments;
SELECT * FROM Doctors;
SELECT * FROM Patients;
SELECT * FROM Appointments;
SELECT * FROM Billing;

--	Display all patients along with their doctor's name and specialization
SELECT
    p.patient_name AS Patient,
    d.doctor_name AS Doctor,
    d.specialization AS Specialization
FROM
    Patients p
JOIN
    Appointments a ON p.patient_id = a.patient_id
JOIN
    Doctors d ON a.doctor_id = d.doctor_id
ORDER BY
    p.patient_name;
    
--	Show all appointments scheduled for today
SELECT
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    a.appointment_time
FROM
    Appointments a
JOIN
    Patients p ON a.patient_id = p.patient_id
JOIN
    Doctors d ON a.doctor_id = d.doctor_id
WHERE
    a.appointment_date = CURDATE();
    
-- List doctors working in a specific department
SELECT
    d.doctor_name,
    d.specialization,
    dep.department_name
FROM
    Doctors d
JOIN
    Departments dep ON d.department_id = dep.department_id
WHERE
    dep.department_name = 'Cardiology';
-- Find the total revenue collected from paid bills
SELECT
    SUM(amount) AS total_paid_revenue
FROM
    Billing
WHERE
    payment_status = 'Paid';

-- 	Display patients who have unpaid bills
SELECT
    p.patient_name,
    b.amount AS unpaid_amount,
    b.bill_date
FROM
    Patients p
JOIN
    Billing b ON p.patient_id = b.patient_id
WHERE
    b.payment_status = 'Unpaid';
    
-- 6.	Count total appointments handled by each doctor

SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM
    Doctors d
LEFT JOIN -- LEFT JOIN ensures doctors with 0 appointments are included
    Appointments a ON d.doctor_id = a.doctor_id
GROUP BY
    d.doctor_name
ORDER BY
    total_appointments DESC;
--	Show department-wise doctor count

SELECT
    dep.department_name,
    COUNT(d.doctor_id) AS doctor_count
FROM
    Departments dep
LEFT JOIN -- LEFT JOIN ensures departments with 0 doctors are included
    Doctors d ON dep.department_id = d.department_id
GROUP BY
    dep.department_name
ORDER BY
    doctor_count DESC;
-- Update & Delete Operations
-- Update appointment status from Pending to Complete
UPDATE Appointments
SET status = 'Completed'
WHERE appointment_id = 2 AND status = 'Pending';
-- Delete appointments that are cancelled
DELETE FROM Appointments
WHERE status = 'Cancelled';

-- Update billing status once payment is done
UPDATE Billing
SET payment_status = 'Paid'
WHERE bill_id = 2 AND payment_status = 'Unpaid';

-- Advanced SQL (For Extra Credit)
-- Use a subquery to find patients whose bill amount is above average
SELECT
    p.patient_name,
    b.amount
FROM
    Patients p
JOIN
    Billing b ON p.patient_id = b.patient_id
WHERE
    b.amount > (SELECT AVG(amount) FROM Billing);
    
-- Use GROUP BY & HAVING to find doctors who handled more than one appointment
SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM
    Doctors d
JOIN
    Appointments a ON d.doctor_id = a.doctor_id
GROUP BY
    d.doctor_name
HAVING
    COUNT(a.appointment_id) > 1;

-- Display the highest bill amount paid
SELECT
    MAX(amount) AS highest_paid_bill
FROM
    Billing
WHERE
    payment_status = 'Paid';
    
   -- END
   



    

    

 
