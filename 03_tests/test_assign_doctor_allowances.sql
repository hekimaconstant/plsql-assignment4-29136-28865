SET SERVEROUTPUT ON SIZE 100000;

PROMPT =====================================================================
PROMPT TEST 1.1: Success Case - Assign Valid Allowance to Existing Doctor
PROMPT =====================================================================
BEGIN
    assign_doctor_allowances(
        p_doctor_id        => 1,
        p_allowance_amount => 500.00
    );
END;
/


PROMPT =====================================================================
PROMPT TEST 1.2: Error Case - Non-Existent Doctor ID (NO_DATA_FOUND)
PROMPT =====================================================================
BEGIN
    assign_doctor_allowances(
        p_doctor_id        => 9999,
        p_allowance_amount => 500.00
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Expected Exception Caught: ' || SQLERRM);
END;
/



PROMPT =====================================================================
PROMPT TEST 1.3: Error Case - Invalid Negative Allowance Amount
PROMPT =====================================================================
BEGIN
    assign_doctor_allowances(
        p_doctor_id        => 1,
        p_allowance_amount => -200.00
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Expected Exception Caught: ' || SQLERRM);
END;
/