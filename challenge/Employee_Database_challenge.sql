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




