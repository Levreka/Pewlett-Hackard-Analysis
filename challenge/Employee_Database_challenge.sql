--- DELIVERABLE 1:

--selecting the columns needed noticed you dont need to call the emp.no again
--for the other tables since that is where you will be joining them
SELECT  em.emp_no,
        em.first_name,
        em.last_name,
        ti.title,
        ti.from_date,
        ti.to_date
-- we are converting our query into a new table
INTO retirement_titles
---- selecting the tables we want to retrieve data from using allias
FROM employees AS em
    -- first join setting allias as well for table using right join because we are 
	--taking everything from our table 2 and only portions of table 1-employees
	RIGHT JOIN titles AS ti
        --we are joining them on the following
		ON (em.emp_no = ti.emp_no)
--filtering data on birth_date between 1952 and 1955 
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--setting table from smallest to largest by employee number NOTE: order by will automaticly 
-- order things in ascending order with out typing the "asc" parameter but if you want them in descending order
-- type desc after 
ORDER BY em.emp_no asc

--creating unique title list 
-- Use Dictinct with Orderby to remove duplicate rows
-- Creating unique_titles.csv

--distinc on is grabbing the first occurance of the emp_no which is the paranthesis paramater
--the second comment not to be confused is asking for the first colum name and is not actually part
--of the distinct on synthax 
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
-- creating new table 
INTO unique_titles
-- setting the table we are gathing data from
FROM retirement_titles as rt
--filtering out all other dates except ('9999-01-01')
WHERE rt.to_date = ('9999-01-01')
--table will be ascending order for emp_no and desc for date
ORDER BY rt.emp_no, rt.to_date DESC;



--creating a table that shows how many employees are in each department
-- count is being done on emp_no so it will add each unique emp_no into a bucket
SELECT count (ut.emp_no),
	ut.title
--transfering our query to a new table 
INTO retiring_titles
--setting our allias and table we are pulling info
FROM unique_titles as ut
--grouping by the title
GROUP BY title
--order by works with both emp_no and title need to further research why
--this is and which is the proper way
ORDER BY COUNT(emp_no) DESC;




--DELIVERABLE 2: mentorship-eligibility table 

-- using distinc on pull non repeating emp_no
--remeber the second comment outside the paranthesis is the first column we want to pull out
SELECT DISTINCT ON (em.emp_no) em.emp_no,
	   em.first_name,
	   em.last_name,
	   em.birth_date,
	   de.from_date,
	   de.to_date,
	   ti.title
--creating a table out of our query
INTO mentorship_eligibilty	
--setting allias and pulling data from employees table
FROM employees as em
--creating a inner join setting alias 
INNER JOIN dept_emp as de
--joining them on Primary key
ON (em.emp_no = de.emp_no)
--creating a inner join setting alias 
INNER JOIN titles as ti
--joining them on Primary key
ON (em.emp_no = ti.emp_no)
--setting up condition to return only to_date that equals ('9999-01-01') and
--birth_date is between 01/01/1965 and 12/31/1965
WHERE de.to_date = ('9999-01-01')
AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
-- arranging the table in ascending order by emp_no
ORDER BY em.emp_no asc
