SET SERVEROUTPUT ON SIZE 100000;

PROMPT =====================================================================
PROMPT TEST 4.1: Success Case - Fetch Annual Doctor Salaries for Department 1
PROMPT =====================================================================

DECLARE
    v_results doctor_salary_table;
BEGIN
    v_results := get_annual_doctor_salaries(p_department_id => 1);
    
    IF v_results.COUNT > 0 THEN
        FOR i IN 1..v_results.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Doctor Name : ' || v_results(i).full_name);
            DBMS_OUTPUT.PUT_LINE('Specialty   : ' || v_results(i).specialty);
            DBMS_OUTPUT.PUT_LINE('Monthly Sal : $' || TO_CHAR(v_results(i).monthly_salary, '999,999.00'));
            DBMS_OUTPUT.PUT_LINE('Annual Sal  : $' || TO_CHAR(v_results(i).annual_salary, '999,999.00'));
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No record found for department 1.');
    END IF;
END;
/