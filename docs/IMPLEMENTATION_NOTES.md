# Implementation and Performance Notes - Hospital Management System (HMS)

## 1. Architectural Overview
The **Hospital Management System (HMS)** PL/SQL application follows a modular structure split across the following directories:
* `00_schema/`: Database table creation and sample data scripts.
* `01_procedures/`: Business logic stored procedures.
* `02_functions/`: Stored functions, including local object type definitions.
* `03_tests/`: Dedicated, individual test scripts for each procedure and function.

---

## 2. Key PL/SQL Concepts Demonstrated

### Records (`%ROWTYPE` and User-Defined)
* **`%ROWTYPE`**: Used in `generate_appointment_report.sql` to dynamically inherit table row structures.
* **User-Defined Records (`TYPE`)**: Group related attributes (`doctor_id`, `full_name`, `salary`) into custom composite variables in `process_department_shift_bulk.sql`.

### Collections
* **Nested Tables**: Used for dynamic in-memory collections (`doctor_salary_table`) storing object instances returned by functions. Local object types (`doctor_salary_obj` and `doctor_salary_table`) are encapsulated directly within the function script where they are utilized.
* **Associative Arrays & VARRAYS**: Integrated for indexing and batch identifier storage during bulk data modifications.

### Cursors (Implicit and Explicit)
* **Implicit Cursors**: Managed automatically during `INSERT`, `UPDATE`, and `SELECT INTO` statements, using attributes like `SQL%FOUND`, `SQL%NOTFOUND`, `SQL%ROWCOUNT`, and `SQL%ISOPEN`.
* **Explicit Cursors**: Used with parameterized queries (`c_appts`) and managed via standard `OPEN`, `FETCH`, `CLOSE` lifecycles.
* **`SYS_REFCURSOR`**: Returned by `get_doctor_workload_refcursor` to pass dynamic result sets between database functions and caller blocks.

### Bulk Processing (`BULK COLLECT` and `FORALL`)
* **Performance Benefits**: Row-by-row loops cause heavy context-switching overhead between the PL/SQL and SQL engines. In contrast, `BULK COLLECT` and `FORALL` process data sets in memory in batches, greatly reducing context switches and improving speed.
* **Exception Resilience**: Implemented `SAVE EXCEPTIONS` with `SQL%BULK_EXCEPTIONS` to capture row-level errors without stopping the entire batch job.

### Exception Handling
* Predefined exceptions (`NO_DATA_FOUND`) and custom application errors (`RAISE_APPLICATION_ERROR` with codes `-20001`, `-20002`, `-20003`) are utilized to handle errors safely and return clear messages.