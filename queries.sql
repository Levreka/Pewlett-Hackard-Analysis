-- begin querying data after importing our data from the csv files
-- for anyone born between 1952 and 1955 because they will begin
-- retiring according to class work
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


-- create another query looking for only employees born 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

--query to search employees born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';


--query to search employees born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';


--query to search employees born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
-- two conditional statements to further filter our data to find the individuals
-- who actually fit the retirement requirements
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--using count just like python in sql
-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- creating a new table out of query by exporting the data
-- code doesnt change much except from the query notice the into tells it the name of 
-- the new table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- how to see how our data looks like by making a simple query
SELECT*FROM retirement_info;

-- to export the data right click the table just like when importing you choose the destination file name the format
--which in our case we will use csv header option to yes delimiter to , remeber csv



-- recreating the retirement info table but with the emp_no for later to be able to join 
--first drop the table for code to work this doesnt have to always be our case but for our purposes
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
-- we still have our condition for filtering the data
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables using inner join
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables using lef joint
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
	FROM retirement_info
	LEFT JOIN dept_emp
	ON retirement_info.emp_no = dept_emp.emp_no;

-- use left join for retirement info and dept emp tables
-- well be using allias in this code to make it shorter and creating a new table out of this join
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--looking at the table
SELECT*FROM current_emp

--Let's continue to work on these lists this time using COUNT, GROUP BY, and ORDER BY with the joins.
--- Employee count by department number count was run on the emp_no on the current_emp table
SELECT COUNT(ce.emp_no), de.dept_no
-- creating a new table with this join and query
INTO employee_count
-- this next two lines are creating our allias 
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
-- will group them by the deptartement number
GROUP BY de.dept_no
-- will put them departemnt order from smallets to largest
ORDER BY de.dept_no;

--VIEWING THE TABLE
SELECT*FROM employee_count


