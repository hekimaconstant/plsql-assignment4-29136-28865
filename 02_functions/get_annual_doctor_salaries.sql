CREATE OR REPLACE TYPE doctor_salary_obj AS OBJECT (
    full_name      VARCHAR2(100),
    specialty      VARCHAR2(100),
    monthly_salary NUMBER(10, 2),
    annual_salary  NUMBER(10, 2)
);
/


CREATE OR REPLACE TYPE doctor_salary_table AS TABLE OF doctor_salary_obj;
/

CREATE OR REPLACE FUNCTION get_annual_doctor_salaries (
    p_department_id IN NUMBER
) RETURN doctor_salary_table
    
    IS
    v_salaries doctor_salary_table := doctor_salary_table();
    
    CURSOR c_docs IS
        SELECT first_name || ' ' || last_name AS full_name, specialty, salary
        FROM doctors
        WHERE department_id = p_department_id;
        
    v_name    doctors.first_name%TYPE;
    v_spec    doctors.specialty%TYPE;
    v_monthly doctors.salary%TYPE;

BEGIN
    OPEN c_docs;
    LOOP
        FETCH c_docs INTO v_name, v_spec, v_monthly;
        EXIT WHEN c_docs%NOTFOUND;
        
        v_salaries.EXTEND;
        v_salaries(v_salaries.COUNT) := doctor_salary_obj(
            full_name      => v_name,
            specialty      => v_spec,
            monthly_salary => v_monthly,
            annual_salary  => v_monthly * 12
        );
    END LOOP;
    CLOSE c_docs;

    RETURN v_salaries;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF c_docs%ISOPEN THEN CLOSE c_docs; END IF;
        RETURN doctor_salary_table();

    WHEN OTHERS THEN
        IF c_docs%ISOPEN THEN CLOSE c_docs; END IF;
        RAISE_APPLICATION_ERROR(-20002, 'Error in get_annual_doctor_salaries: ' || SQLERRM);
        
END get_annual_doctor_salaries;
/