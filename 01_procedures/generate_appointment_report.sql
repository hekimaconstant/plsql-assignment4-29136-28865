CREATE OR REPLACE PROCEDURE generate_appointment_report (
    p_department_id IN NUMBER
) AS

    CURSOR c_appts (cp_dept_id NUMBER) IS
        SELECT a.appointment_id, p.first_name || ' ' || p.last_name AS patient_name,
               d.first_name || ' ' || d.last_name AS doctor_name,
               a.appointment_date, a.status
        FROM appointments a
        JOIN patients p ON a.patient_id = p.patient_id
        JOIN doctors d ON a.doctor_id = d.doctor_id
        WHERE d.department_id = cp_dept_id;

    v_appt_rec c_appts%ROWTYPE;
BEGIN
    OPEN c_appts(p_department_id);

    IF c_appts%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Appointment cursor opened for Department ID: ' || p_department_id);
    END IF;


    LOOP
        FETCH c_appts INTO v_appt_rec;
        EXIT WHEN c_appts%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Appt ID: ' || v_appt_rec.appointment_id || 
                             ' | Patient: ' || v_appt_rec.patient_name || 
                             ' | Doctor: ' || v_appt_rec.doctor_name || 
                             ' | Date: ' || TO_CHAR(v_appt_rec.appointment_date, 'YYYY-MM-DD') ||
                             ' | Status: ' || v_appt_rec.status);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Appointments Processed (%ROWCOUNT): ' || c_appts%ROWCOUNT);

    CLOSE c_appts;
EXCEPTION
    WHEN OTHERS THEN
        IF c_appts%ISOPEN THEN CLOSE c_appts; END IF;
        DBMS_OUTPUT.PUT_LINE('Error in generate_appointment_report: ' || SQLERRM);
END generate_appointment_report;
/