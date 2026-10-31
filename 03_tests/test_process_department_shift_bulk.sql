SET SERVEROUTPUT ON SIZE 100000;

PROMPT =====================================================================
PROMPT TEST 2.1: Success Case - Bulk Salary Adjustment for Department 1
PROMPT =====================================================================
BEGIN
    process_department_shift_bulk(
        p_department_id    => 1,
        p_salary_increment => 250.00
    );
END;
/

PROMPT =====================================================================
PROMPT TEST 2.2: Edge Case - Department with No Doctors
PROMPT =====================================================================
BEGIN
    process_department_shift_bulk(
        p_department_id    => 999,
        p_salary_increment => 100.00
    );
END;
/