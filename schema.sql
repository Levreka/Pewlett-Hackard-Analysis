-- Creating tables for PH-EmployeeDB in order to comment we use (--)
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
-- note you can also create a table by going to schemas
--and drop down to tables right click create table
--this however doesn't create a schema we can save 
--later. note also the very last line of code after the parenthesis doesnt required a comma
--if you add a comma after the last piece of code it will give you a synthax error and point at this );

-- creating table for employees
CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

-- creating dept_manager table with foreing keys and primary keys
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- creating salaries table with also foreing key and primary key
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
	

-- create table for dept_emp
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL, 
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
-- create table titles with foreing key, NOTE IMPORTANT: for the primary key here
--is a composite primary key here is the reason lookin at the data in this table
--in order to find one individual you need their emp_no but you also have repeating
-- emp_no so we need to add tittles unfortunaly tittles also repeats
-- we go to begining and ending dates to create one big composite key if you dont do 
-- this importing your data you will get an error saying repeating key 
CREATE TABLE titles (
    emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title,from_date,to_date)
);	

SELECT * FROM departments;
--there was an error with importing the data we got pgadmin utility error go to preference to set binary path
--in order to fix this go to file menu preferences find binary path got to your version of postgress downloaded
-- click the folder to browse if you did the default installing go to c drive--program files--find postgresql
-- go into folder click the only folder in there wich should equal the number of your version mine was 15
-- and select the bin number that would be the last folder to select after that save and close out of preferences
