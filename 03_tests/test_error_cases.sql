SET DEFINE OFF;
SET SERVEROUTPUT ON;

PROMPT =====================================================================
PROMPT TEST ERR-1: Triggering User-Defined Exception & RAISE_APPLICATION_ERROR
PROMPT =====================================================================
BEGIN
    assign_doctor_allowances(p_doctor_id => 1, p_allowance_amount => -500);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Exception Code: ' || SQLCODE || ' - ' || SQLERRM);
END;
/



PROMPT =====================================================================
PROMPT TEST ERR-2: Triggering NO_DATA_FOUND Exception
PROMPT =====================================================================
BEGIN
    assign_doctor_allowances(p_doctor_id => 99999, p_allowance_amount => 200);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Exception Code: ' || SQLCODE || ' - ' || SQLERRM);
END;
/