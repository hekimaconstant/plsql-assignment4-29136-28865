CREATE OR REPLACE FUNCTION get_doctor_workload_refcursor (
    p_doctor_id IN NUMBER
) RETURN SYS_REFCURSOR IS

    v_cursor SYS_REFCURSOR;

BEGIN
    OPEN v_cursor FOR
        SELECT d.first_name || ' ' || d.last_name AS doctor_name,
               COUNT(a.appointment_id) AS total_appointments,
               SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments
        FROM doctors d
        LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
        WHERE d.doctor_id = p_doctor_id
        GROUP BY d.first_name, d.last_name;

    RETURN v_cursor;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error generating workload refcursor: ' || SQLERRM);
END get_doctor_workload_refcursor;
/