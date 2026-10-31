SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE assign_doctor_allowances (
    p_doctor_id        IN NUMBER,
    p_allowance_amount IN NUMBER
) AS
    v_doc_exists NUMBER;
    e_invalid_amount EXCEPTION;

BEGIN
    IF p_allowance_amount <= 0 THEN
        RAISE e_invalid_amount;
    END IF;

    -- Check if doctor exists using implicit cursor
    SELECT COUNT(*)
    INTO v_doc_exists
    FROM doctors
    WHERE doctor_id = p_doctor_id;

    IF SQL%FOUND AND v_doc_exists > 0 THEN
        INSERT INTO allowances (doctor_id, allowance_amount, effective_date)
        VALUES (p_doctor_id, p_allowance_amount, SYSDATE);

        IF SQL%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Successfully assigned allowance of ' || p_allowance_amount || 
                                 ' to Doctor ID ' || p_doctor_id || '. Rows affected: ' || SQL%ROWCOUNT);
        END IF;
    ELSE
        RAISE NO_DATA_FOUND;
    END IF;

    IF SQL%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Implicit cursor is open.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Implicit cursor is closed.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN e_invalid_amount THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Error: Allowance amount must be greater than zero.');
   
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Doctor ID ' || p_doctor_id || ' does not exist.');
    
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END assign_doctor_allowances;
/