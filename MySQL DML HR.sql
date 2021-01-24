SELECT FIRST_NAME AS 'FIRST NAME' , LAST_NAME AS 'LAST NAME' FROM EMPLOYEES;

SELECT DISTINCT(DEPARTMENT_ID) FROM EMPLOYEES;

SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME DESC; 

SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY, SALARY*.15 AS PF FROM EMPLOYEES;

SELECT EMPLOYEE_ID AS 'EMPLOYEE_ID', FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY
FROM EMPLOYEES ORDER BY SALARY ASC; 

SELECT SUM(SALARY) AS 'TOTAL SALARY' FROM EMPLOYEES;

SELECT MAX(SALARY) AS 'MAXIMUM SALARY', MIN(SALARY) AS 'MINIMUM SALARY' FROM EMPLOYEES;

SELECT AVG(SALARY) AS 'AVERAGE SALARY PER EMPLOYEE' , COUNT(EMPLOYEE_ID) AS 'TOTAL EMPLOYEES' FROM EMPLOYEES;

SELECT COUNT(EMPLOYEE_ID) AS 'TOTAL EMPLOYEES' FROM EMPLOYEES;

SELECT COUNT(DISTINCT(JOB_ID)) AS 'TOTAL JOBS' FROM EMPLOYEES;

SELECT UCASE(FIRST_NAME) AS 'FIRST NAME' FROM EMPLOYEES;

SELECT SUBSTR(UCASE(FIRST_NAME), 1, 3) AS 'FIRST NAME' FROM EMPLOYEES;

SELECT DEPARTMENT_ID AS 'DEPARTMENT ID' , MAX(SALARY) AS 'MAX SALARY' 
FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'EMPLOYEE NAME' FROM EMPLOYEES;

SELECT TRIM(FIRST_NAME) AS 'FIRST NAME' FROM EMPLOYEES;

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'EMPLOYEE NAME', LENGTH(FIRST_NAME) + LENGTH(LAST_NAME) AS 'NAME LENGTHS' 
FROM EMPLOYEES;

SELECT * FROM EMPLOYEES WHERE FIRST_NAME REGEXP '[0-9]';

SELECT * FROM EMPLOYEES LIMIT 10; 

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'EMPLOYEE NAME', ROUND(SALARY/12, 2) AS 'MONTHLY SALARY PER EMPLOYEE' 
FROM EMPLOYEES;

SELECT DEPARTMENT_ID AS 'DEPARTMENT ID', COUNT(EMPLOYEE_ID) AS 'EMPLOYEE ID' 
FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

-- ------------------------------------------------------------------------------------------------------------------------

-- MySQL Function and GROUP BY exercise
SELECT COUNT(DISTINCT JOB_ID) FROM EMPLOYEES;

SELECT SUM(SALARY) AS 'TOTAL SALARY' FROM EMPLOYEES;

SELECT MIN(SALARY) AS 'MINIMUM SALARY' FROM EMPLOYEES;

SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'; 

SELECT ROUND(AVG(SALARY), 2) AS 'AVERAGE EMPLOYEE SALARY FROM DEPARTMENT 90',
 COUNT(EMPLOYEE_ID) AS 'NUMBER OF EMPLOYEES FROM DEPARTMENT 90'
 FROM EMPLOYEES WHERE DEPARTMENT_ID = '90';
 
SELECT MAX(SALARY) AS 'MAXIMUM EMPLOYEE SALARY', MIN(SALARY) AS 'MINIMUM EMPLOYEE SALARY',
 SUM(SALARY) AS 'TOTAL EMPLOYEE SALARY' ,ROUND(AVG(SALARY), 2) AS 'AVERAGE EMPLOYEE SALARY' FROM EMPLOYEES;
 
SELECT JOB_ID AS 'JOB NAME', COUNT(EMPLOYEE_ID) AS 'TOTAL EMPLOYEES' FROM EMPLOYEES GROUP BY JOB_ID;

SELECT MAX(SALARY) - MIN(SALARY) AS 'SALARY DIFFERENCE' FROM EMPLOYEES;

SELECT MANAGER_ID AS 'MANAGER ID', MIN(SALARY) AS 'MINIMUM SALARY FOR MANAGER'
 FROM EMPLOYEES WHERE MANAGER_ID IS NOT NULL GROUP BY MANAGER_ID ORDER BY MIN(SALARY) ASC;

SELECT DEPARTMENT_ID AS 'DEPARTMENT ID', SUM(SALARY) AS 'TOTAL SALARY'
 FROM EMPLOYEES WHERE DEPARTMENT_ID IS NOT NULL GROUP BY DEPARTMENT_ID ORDER BY SUM(SALARY) ASC;
 
-- CARA 1
SELECT JOB_ID AS 'JOB ID', ROUND(AVG(SALARY)) AS 'AVERAGE SALARY'
 FROM EMPLOYEES WHERE JOB_ID !='IT_PROG'
 GROUP BY JOB_ID ORDER BY ROUND(AVG(SALARY));
 
 -- CARA 2
SELECT JOB_ID AS 'JOB ID', ROUND(AVG(SALARY)) AS 'AVERAGE SALARY'
 FROM EMPLOYEES WHERE JOB_ID NOT IN('IT_PROG', 'MK_REP')
 GROUP BY JOB_ID ORDER BY ROUND(AVG(SALARY));
 
SELECT JOB_ID AS 'JOB ID', COUNT(JOB_ID) AS 'TOTAL JOBS', SUM(SALARY) AS 'TOTAL SALARY', MAX(SALARY) AS 'MAXIMUM SALARY', 
 MIN(SALARY) AS 'MINIMUM SALARY', ROUND(AVG(SALARY), 2) AS 'AVERAGE SALARY'
 FROM EMPLOYEES WHERE DEPARTMENT_ID = 90 GROUP BY JOB_ID ORDER BY SUM(SALARY);
 
SELECT JOB_ID AS 'JOB ID', MAX(SALARY) AS 'MAX SALARY'
 FROM EMPLOYEES GROUP BY JOB_ID
 HAVING MAX(SALARY) >= 4000 ORDER BY MAX(SALARY) ASC;
 
SELECT DEPARTMENT_ID AS 'DEPARTMENT ID', COUNT(EMPLOYEE_ID) AS 'TOTAL EMPLOYEES', 
 ROUND(AVG(SALARY), 2) AS 'AVERAGE SALARY FOR EMPLOYEES'
 FROM EMPLOYEES GROUP BY DEPARTMENT_ID
 HAVING COUNT(EMPLOYEE_ID) > 10 ORDER BY DEPARTMENT_ID, COUNT(EMPLOYEE_ID) ASC;
 
 -- ----------------------------------- SUBQUERY -------------------------------------- --
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY' FROM EMPLOYEES 
 WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME = 'BULL')
 ORDER BY SALARY ASC;

SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME 'LAST NAME', DEPARTMENT_ID AS 'DEPARTMENT ID' FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT' );
 
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', 
 MANAGER_ID AS 'MANAGER ID', DEPARTMENT_ID AS 'DEPARTMENT ID' FROM EMPLOYEES
 WHERE MANAGER_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID
 IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE LOCATION_ID
 IN (SELECT LOCATION_ID FROM LOCATIONS WHERE COUNTRY_ID = 'US')))
 ORDER BY FIRST_NAME ASC;
 
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', MANAGER_ID AS 'MANAGER'
 FROM EMPLOYEES WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID FROM EMPLOYEES)
 ORDER BY FIRST_NAME ASC;
 
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY' FROM EMPLOYEES 
 WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
 ORDER BY SALARY ASC;

SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY'
 FROM EMPLOYEES WHERE SALARY = (SELECT MIN_SALARY FROM JOBS WHERE EMPLOYEES.JOB_ID = JOBS.JOB_ID);
 
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY', DEPARTMENT_ID AS 'DEPARTMENT ID'
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME LIKE 'IT%')
   AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) 
 ORDER BY SALARY ASC;
 
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY'
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);

SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY'
  FROM EMPLOYEES
 WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME LIKE '%BELL%')
 ORDER BY SALARY ASC;

SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY'
  FROM EMPLOYEES
 WHERE SALARY > ALL(SELECT AVG(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID);
 
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY'
  FROM EMPLOYEES
 WHERE SALARY > (SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'SH_CLERK')
 ORDER BY SALARY ASC;
 
SELECT A.FIRST_NAME AS 'FIRST NAME', A.LAST_NAME AS 'LAST NAME'
  FROM EMPLOYEES AS A
 WHERE NOT EXISTS (SELECT B.EMPLOYEE_ID FROM EMPLOYEES AS B WHERE A.MANAGER_ID = B.EMPLOYEE_ID);

SELECT E.EMPLOYEE_ID AS 'EMPLOYEE ID', E.FIRST_NAME AS 'FIRST NAME', E.LAST_NAME AS 'LAST NAME', 
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS AS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) DEPARTMENT
  FROM EMPLOYEES AS E
 ORDER BY DEPARTMENT ASC;
 
SELECT FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME', SALARY AS 'SALARY'
  FROM EMPLOYEES
 WHERE SALARY > ALL(SELECT AVG(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID);
 
 SET @i = 0;
 SELECT i, EMPLOYEE_ID AS 'EMPLOYEE ID', FIRST_NAME AS 'FIRST NAME', LAST_NAME AS 'LAST NAME'
   FROM (SELECT @i := @i + 1 AS i, EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES) AS A
  WHERE MOD(A.i, 2) = 0;

SET @i = 0; 
SELECT i, salary 
FROM (SELECT @i := @i + 1 AS i, salary FROM employees order by salary desc)
a WHERE a.i = 5;

SET @i = 0; 
SELECT i, salary 
FROM (SELECT @i := @i + 1 AS i, salary FROM employees order by salary asc)
a WHERE a.i = 4;

select * from employees order by EMPLOYEE_ID desc limit 10;

select * from employees order by salary asc limit 3;

select department_id as 'department id', department_name as 'department name' from departments
where department_id not in(select department_id from employees)
order by department_name asc; 

 -- ----------------------------------- JOIN TABLE -------------------------------------- --
select departments.department_id, departments.department_name, locations.street_address,
	   locations.location_id, locations.city, locations.state_province, countries.country_name
  from departments, locations, countries
 where departments.location_id = locations.location_id
   and locations.COUNTRY_ID = countries.country_id
 order by department_id asc;
 
select  employees.department_id, departments.department_name, employees.first_name, employees.last_name
  from departments, employees
 where employees.department_id = departments.department_id
 order by department_name asc;

select employees.first_name, employees.last_name, employees.job_id, 
       jobs.job_title, employees.department_id, departments.department_name, locations.city
  from employees, jobs, departments, locations
 where employees.department_id=departments.department_id
   and employees.job_id=jobs.job_id
   and locations.location_id=departments.location_id
   and departments.location_id=locations.location_id
   and locations.city = 'London';
   
select a.employee_id, a.last_name, b.employee_id, b.last_name
  from employees a, employees b
 where a.manager_id=b.employee_id;

select b.hire_date, b.first_name, b.last_name
  from employees a, employees b
 where a.hire_date <= b.hire_date
   and a.last_name = 'Jones'
 order by b.hire_date asc;
 
select departments.department_id, departments.department_name,
       count(employees.employee_id) as 'Number of employees'
  from departments, employees
 where departments.department_id=employees.department_id
 group by departments.department_id, departments.department_name
 order by department_id asc;
 
select job_history.employee_id, job_history.start_date, job_history.end_date, 
	   round(datediff(job_history.end_date, job_history.start_date)/365,1) as 'number of years between end date and start date'
       ,job_history.job_id, jobs.job_title
  from job_history, jobs
 where job_history.job_id=jobs.job_id
   and job_history.department_id = 90;
   
select departments.department_id, departments.department_name, departments.manager_id
	   , a.first_name, a.last_name
  from departments, employees a
 where departments.manager_id = a.employee_id
 order by departments.department_id asc;
 
select departments.department_name, employees.first_name, locations.city
  from departments, employees, locations
 where departments.manager_id = employees.employee_id
   and locations.location_id = departments.location_id
 order by department_name asc;

select jobs.job_title as 'job title', round(avg(employees.salary), 2) as 'average salary'
  from jobs, employees
 where jobs.job_id=employees.job_id
 group by jobs.job_title;

select jobs.job_title, employees.first_name, employees.last_name,
	   jobs.min_salary as 'minimum salary', employees.salary - jobs.min_salary as 'salary difference'
  from jobs, employees
 where jobs.job_id = employees.job_id;
 
select job_history.*, employees.salary
  from job_history, employees
 where job_history.employee_id = employees.employee_id
   and employees.salary > 10000
 order by employee_id asc;
 
select departments.department_name, employees.first_name, employees.last_name,
	   employees.hire_date, employees.salary,
       round(datediff(now(), employees.hire_date)/365,2) as 'job experience'
  from departments, employees
 where employees.employee_id = departments.manager_id
   and round(datediff(now(), employees.hire_date)/365,2) > 15;
   
select employees.employee_id, employees.first_name, employees.last_name, 
	   departments.department_name, regions.region_name, countries.country_name, locations.*
  from employees, departments, regions, countries, locations
 where employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
   and regions.region_id = countries.REGION_ID
   and countries.country_id = locations.country_id
   and departments.location_id = locations.location_id
 order by employee_id asc;
 
select departments.department_name, count(employees.employee_id) as 'total employees'
  from departments, employees
 where departments.DEPARTMENT_ID = employees.DEPARTMENT_ID
 group by department_name;