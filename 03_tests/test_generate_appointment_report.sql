SET SERVEROUTPUT ON SIZE 100000;

PROMPT =====================================================================
PROMPT TEST 3.1: Success Case - Generate Report for Department 1
PROMPT =====================================================================
BEGIN
    generate_appointment_report(p_department_id => 1);
END;
/

PROMPT =====================================================================
PROMPT TEST 3.2: Success Case - Generate Report for Department 2
PROMPT =====================================================================
BEGIN
    generate_appointment_report(p_department_id => 2);
END;
/