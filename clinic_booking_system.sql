-- create database clinic_booking_system;
use clinic_booking_system;
-- Create Patients Table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE
);

-- Create Doctors Table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100),
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE
);

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Many-to-Many: Doctor ↔ Department
CREATE TABLE Doctor_Department (
    DoctorID INT,
    DepartmentID INT,
    PRIMARY KEY (DoctorID, DepartmentID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Appointments Table (One-to-Many: Patient → Appointments)
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- One-to-One: Appointment → Prescription
CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT UNIQUE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Medications Table
CREATE TABLE Medications (
    MedicationID INT AUTO_INCREMENT PRIMARY KEY,
    MedicationName VARCHAR(100) NOT NULL UNIQUE,
    Dosage VARCHAR(50)
);

-- Many-to-Many: Prescription ↔ Medications
CREATE TABLE Prescription_Med (
    PrescriptionID INT,
    MedicationID INT,
    PRIMARY KEY (PrescriptionID, MedicationID),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

-- -------------------
-- Sample Data Inserts
-- -------------------

-- Patients
INSERT INTO Patients (FirstName, LastName, DOB, Gender, Phone, Email) VALUES
('John', 'Doe', '1990-05-12', 'Male', '1234567890', 'john.doe@example.com'),
('Jane', 'Smith', '1985-08-23', 'Female', '0987654321', 'jane.smith@example.com');

-- Doctors
INSERT INTO Doctors (FirstName, LastName, Specialty, Phone, Email) VALUES
('Alice', 'Brown', 'Cardiology', '5551234567', 'alice.brown@clinic.com'),
('Robert', 'Wilson', 'Neurology', '5559876543', 'robert.wilson@clinic.com');

-- Departments
INSERT INTO Departments (DepartmentName) VALUES
('Cardiology'),
('Neurology'),
('General Medicine');

-- Doctor ↔ Department links
INSERT INTO Doctor_Department (DoctorID, DepartmentID) VALUES
(1, 1), -- Alice in Cardiology
(2, 2); -- Robert in Neurology

-- Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason) VALUES
(1, 1, '2025-05-10 09:30:00', 'Chest pain'),
(2, 2, '2025-05-11 14:00:00', 'Headache and dizziness');

-- Prescriptions
INSERT INTO Prescriptions (AppointmentID, Notes) VALUES
(1, 'Monitor blood pressure, reduce salt intake.'),
(2, 'Prescribed MRI and rest');

-- Medications
INSERT INTO Medications (MedicationName, Dosage) VALUES
('Aspirin', '100mg daily'),
('Paracetamol', '500mg every 6 hours'),
('Atorvastatin', '20mg nightly');

-- Prescription ↔ Medications
INSERT INTO Prescription_Med (PrescriptionID, MedicationID) VALUES
(1, 1),
(1, 3),
(2, 2);
