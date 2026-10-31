SET SERVEROUTPUT ON SIZE 100000;

PROMPT =====================================================================
PROMPT TEST 5.1: Success Case - Fetch Workload Ref Cursor for Doctor ID 1
PROMPT =====================================================================
DECLARE
    v_cur       SYS_REFCURSOR;
    v_doc_name  VARCHAR2(100);
    v_total     NUMBER;
    v_completed NUMBER;
BEGIN
    v_cur := get_doctor_workload_refcursor(p_doctor_id => 1);
    
    LOOP
        FETCH v_cur INTO v_doc_name, v_total, v_completed;
        EXIT WHEN v_cur%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Doctor Name          : ' || v_doc_name);
        DBMS_OUTPUT.PUT_LINE('Total Appointments   : ' || v_total);
        DBMS_OUTPUT.PUT_LINE('Completed Appts      : ' || v_completed);
    END LOOP;
    
    CLOSE v_cur;
END;
/