# hospital-admin-sql
This is an excellent idea for documenting your work on GitHub. A good description should cover the project's goal, the technologies used, and a summary of the key deliverables.

Here is a comprehensive description you can use for your GitHub repository's README.md file or as a detailed commit message.

Hospital Administration System - MySQL Database Project
## Overview
This repository contains the complete SQL script for designing, implementing, and querying a relational database that models a core Hospital Administration System.

The project was executed based on specified requirements and sample data derived from a multi-sheet Excel dataset (CSV files for Departments, Doctors, Patients, Appointments, and Billing). The resulting script is a single, executable file for quick deployment.
Key Features & Deliverables
# 1. Database Definition Language (DDL)
Database Creation: Sets up the hospital_db schema.

Relational Schema: Created five tables (Departments, Doctors, Patients, Appointments, Billing).

Data Integrity: Established appropriate Primary Keys and Foreign Keys to enforce relationships and maintain data integrity (e.g., ensuring appointments link to existing doctors and patients).

 # 2. Data Manipulation Language (DML)
Data Import: Includes INSERT statements to populate the five tables with sample data.

Maintenance Operations: Contains UPDATE and DELETE queries for essential data management tasks, such as updating appointment statuses and deleting cancelled records.

# 3. Business Requirement Queries (DQL & Reporting)
   
A comprehensive set of queries was developed to fulfill real-world operational and business intelligence needs, including:

Mapping Patients to their Doctors and Specialization.

Calculating Total Revenue from paid bills.

Identifying Patients with Unpaid Bills.

Generating Doctor-wise Appointment Counts.

Advanced SQL queries using subqueries and GROUP BY/HAVING clauses for complex reporting (e.g., finding above-average bill amounts).

## Technologies Used

Database: MySQL

Tool: MySQL Workbench / Command Line Client (for execution)

Source Data: CSV files (derived from Excel)

Requirements: Structured Task Document (TASK1.docx)
