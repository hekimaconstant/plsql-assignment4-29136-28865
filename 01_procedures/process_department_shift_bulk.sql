CREATE OR REPLACE PROCEDURE process_department_shift_bulk (
    p_department_id    IN NUMBER,
    p_salary_increment IN NUMBER
) AS

    TYPE t_doc_rec IS RECORD (
        doctor_id doctors.doctor_id%TYPE,
        full_name VARCHAR2(100),
        salary    doctors.salary%TYPE
    );

    TYPE t_doc_list IS TABLE OF t_doc_rec;
    v_doctors t_doc_list;
    
    TYPE t_id_list IS TABLE OF NUMBER;
    v_doc_ids t_id_list := t_id_list();
    
    e_bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_bulk_errors, -24381);

BEGIN
    -- Bulk collect doctor records
    SELECT doctor_id, first_name || ' ' || last_name, salary
    BULK COLLECT INTO v_doctors
    FROM doctors
    WHERE department_id = p_department_id;

    IF v_doctors.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No doctors found in department ID ' || p_department_id);
        RETURN;
    END IF;

    FOR i IN 1..v_doctors.COUNT LOOP
        v_doc_ids.EXTEND;
        v_doc_ids(i) := v_doctors(i).doctor_id;
    END LOOP;

    -- Bulk update
    FORALL i IN 1 .. v_doc_ids.COUNT SAVE EXCEPTIONS
        UPDATE doctors
        SET salary = salary + p_salary_increment
        WHERE doctor_id = v_doc_ids(i);

    -- Track rows affected
    FOR i IN 1..v_doc_ids.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Doctor ID ' || v_doc_ids(i) || 
                             ' - Rows updated: ' || SQL%BULK_ROWCOUNT(i));
    END LOOP;

    COMMIT;

EXCEPTION
    WHEN e_bulk_errors THEN
        DBMS_OUTPUT.PUT_LINE('Encountered errors during bulk update:');
        FOR i IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Error index ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX ||
                                 ' : Error Code ' || SQL%BULK_EXCEPTIONS(i).ERROR_CODE);
        END LOOP;
        COMMIT;
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Unexpected error in bulk processing: ' || SQLERRM);
END process_department_shift_bulk;
/