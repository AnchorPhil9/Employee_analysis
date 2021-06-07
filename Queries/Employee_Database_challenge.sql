-- Module 1
-- Making a new table called retirement_titles per the Module 7 Challenge (2021).
-- We base our code from similar code in 7.3.1 (2021), 
-- inner join code from 7.3.3 (2021), 
-- and ordering by code from 7.3.4 (2021).
SELECT e.emp_no, e.first_name, e.last_name, 
	ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows.
-- Referred to official documentation for PostgreSQL 9.5 (2021),
-- per the directions of the Module 7 Challenge hint (2021).
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name, 
rt.last_name, 
rt.title
INTO unique_titles
FROM retirement_titles as rt
-- Referred to 7.3.5 (2021) for the DESC syntax.
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

-- Retiring employee count by their most recent title.
-- Referred to 7.3.4 (2021) for the COUNT function and some of the code syntax.
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT (ut.title) DESC;
-- Checking the new retiring_titles table: SELECT * FROM retiring_titles;
-- In case of error, DROP TABLE retiring_titles CASCADE;

-- Module 2
-- For employees: SELECT * FROM employees;
-- For dept_emp: SELECT * FROM dept_emp;
-- For titles: SELECT * FROM titles;
-- Based this compound code on similar code from 7.3.5 (2021)
-- and instructions from the Module 7 Challenge (2021).
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti ON (de.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
SELECT * FROM mentorship_eligibility;
-- In case of error, DROP TABLE mentorship_eligibility CASCADE;

