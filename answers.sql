
//ANSWER 1 
ALTER TABLE HR.employees ADD (Max_Salary NUMBER (8));

UPDATE HR.EMPLOYEES
SET Max_Salary = (SELECT MAX(salary) FROM HR.employees
);

DELETE FROM HR.employees
WHERE salary = (SELECT MIN(salary) FROM HR.employees);



//Answer 2 
CREATE INDEX DPR_NAME_IDX ON HR.departments (department_name);

ALTER TABLE HR.employees ADD CONSTRAINT CNSTR_SALARY
CHECK (salary>1000 AND salary<100000);

DROP INDEX DPR_NAME_IDX;

ALTER TABLE HR.employees ENABLE CONSTRAINT CNSTR_SALARY;
ALTER TABLE HR.employees DISABLE CONSTRAINT CNSTR_SALARY;
ALTER TABLE HR.employees DROP CONSTRAINT CNSTR_SALARY;


//Answer 3
CREATE TABLE NEW_TABLE AS (SELECT department_id FROM HR.departments);

ALTER TABLE NEW_TABLE ADD (department_name VARCHAR2(30));

MERGE INTO NEW_TABLE t USING (SELECT * FROM HR.departments) d ON
(t.department_id = d.department_id) WHEN MATCHED THEN
UPDATE SET t.department_name = d.department_name;  

//Answer 4 

WITH MY_EMPLOYEES AS (SELECT FIRST_NAME,LAST_NAME,JOB_ID,DEPARTMENT_ID
FROM HR.EMPLOYEES WHERE job_id LIKE 'S%'),
JOB_MAX_MIN AS (SELECT JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY FROM HR.JOBS),
DEP_DETAIL AS (SELECT DEPARTMENT_ID,DEPARTMENT_NAME FROM HR.DEPARTMENTS)
SELECT
e.first_name,
e.last_name,
e.job_id,
e.department_id,
j.job_title,
j.min_salary,
j.max_salary,
d.department_name,
e.first_name || ' ' || e.last_name AS full_name 
FROM MY_EMPLOYEES e
JOIN JOB_MAX_MIN j ON e.job_id = j.job_id
JOIN DEP_DETAIL d ON e.department_id = d.department_id;

//Answer 5
commit;
ROLLBACK;



