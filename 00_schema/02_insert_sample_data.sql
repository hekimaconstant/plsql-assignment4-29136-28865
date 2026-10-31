 -- Insert Departments
    INSERT INTO departments (department_name, location) VALUES ('Cardiology', 'Block A - Floor 1');
    INSERT INTO departments (department_name, location) VALUES ('Pediatrics', 'Block B - Floor 2');
    INSERT INTO departments (department_name, location) VALUES ('Neurology', 'Block C - Floor 3');
    INSERT INTO departments (department_name, location) VALUES ('Emergency', 'Block A - Ground');
    
    -- Insert Doctors
    INSERT INTO doctors (first_name, last_name, specialty, department_id, salary, hire_date) 
    VALUES ('Jean', 'Makuza', 'Cardiologist', 1, 4500.00, TO_DATE('2022-03-15', 'YYYY-MM-DD'));
    
    INSERT INTO doctors (first_name, last_name, specialty, department_id, salary, hire_date) 
    VALUES ('Alice', 'Uwase', 'Pediatrician', 2, 4000.00, TO_DATE('2023-01-10', 'YYYY-MM-DD'));
    
    INSERT INTO doctors (first_name, last_name, specialty, department_id, salary, hire_date) 
    VALUES ('Eric', 'Nkurunziza', 'Neurologist', 3, 5200.00, TO_DATE('2021-07-20', 'YYYY-MM-DD'));
    
    INSERT INTO doctors (first_name, last_name, specialty, department_id, salary, hire_date) 
    VALUES ('Diane', 'Kamanzi', 'Emergency Physician', 4, 4800.00, TO_DATE('2022-11-05', 'YYYY-MM-DD'));

    -- Insert Patients
    INSERT INTO patients (first_name, last_name, dob, gender, phone, address) 
    VALUES ('Patrick', 'Habimana', TO_DATE('1985-06-12', 'YYYY-MM-DD'), 'Male', '0788112233', 'Kigali, Nyarugenge');
    
    INSERT INTO patients (first_name, last_name, dob, gender, phone, address) 
    VALUES ('Claudine', 'Mukamana', TO_DATE('1992-09-25', 'YYYY-MM-DD'), 'Female', '0788445566', 'Kigali, Gasabo');
    
    INSERT INTO patients (first_name, last_name, dob, gender, phone, address) 
    VALUES ('Olivier', 'Bizimana', TO_DATE('1978-02-14', 'YYYY-MM-DD'), 'Male', '0788778899', 'Kigali, Kicukiro');

    -- Insert Appointments
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) 
    VALUES (1, 1, SYSDATE + 1, 'Scheduled');
    
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) 
    VALUES (2, 2, SYSDATE + 2, 'Scheduled');
    
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) 
    VALUES (3, 3, SYSDATE - 1, 'Completed');

    -- Insert Allowances
    INSERT INTO allowances (doctor_id, allowance_amount, effective_date) 
    VALUES (1, 500.00, SYSDATE);
    
    INSERT INTO allowances (doctor_id, allowance_amount, effective_date) 
    VALUES (2, 450.00, SYSDATE);

    -- Insert Attendance
    INSERT INTO attendance (doctor_id, attendance_date, status)
    VALUES (1, TRUNC(SYSDATE), 'Present');
    
    INSERT INTO attendance (doctor_id, attendance_date, status)
    VALUES (2, TRUNC(SYSDATE), 'Present');
    
    INSERT INTO attendance (doctor_id, attendance_date, status)
    VALUES (3, TRUNC(SYSDATE), 'Leave');

    COMMIT;