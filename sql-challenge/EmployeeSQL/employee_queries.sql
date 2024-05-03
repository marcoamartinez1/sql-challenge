-- Employee number, last name, first name, sex, and salary

SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	e.sex,
	s.salary
FROM
	"Employees" e
JOIN
	"Salaries" s ON e.emp_no = s.emp_no; 



-- First Names, Last Names, and hire dates of employees hired in 1986
-- I found the extract method from online research and ChatGPT
SELECT
	first_name,
	last_name,
	hire_date
FROM "Employees"
WHERE
	EXTRACT(YEAR FROM hire_date) = 1986;
	
-- List department managers, include department number, department name, employee number,
-- first name, and last name

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
 	d.dept_name,
  	dm.dept_no
FROM
    "Employees" e
JOIN
    "Department_Manager" dm ON e.emp_no = dm.emp_no
JOIN
    "Departments" d ON dm.dept_no = d.dept_no;

-- List department number, include employee number, last name, first name, and department name
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
	d.dept_name
FROM
    "Employees" e
JOIN
    "Department_Employee" de ON e.emp_no = de.emp_no
	
JOIN "Departments" d on de.dept_no = d.dept_no


-- List first name, last name, and sex of everyone named Hercules whose last name begins with B
SELECT
	first_name,
	last_name,
	sex
FROM "Employees"
WHERE
	first_name = 'Hercules' AND
	last_name LIKE 'B%';

-- List each employee in the Sales department, with employee number, last name, and first name
-- dept_no is d007

-- Result via sub query
	SELECT emp_no, first_name, last_name
	FROM "Employees"
	WHERE emp_no IN
	(
		SELECT emp_no
		FROM "Department_Employee"
		WHERE dept_no = 'd007'
	)

-- Result via join
	SELECT
		e.emp_no,
		e.first_name,
		e.last_name
	FROM
		"Employees" e
	JOIN
		"Department_Employee" de ON e.emp_no = de.emp_no
	WHERE
		de.dept_no = 'd007'

-- List each in employee in Sales and Development departments, with employee number, first name, last name,
-- and department name

-- Result via subquery
SELECT emp_no, first_name, last_name
FROM "Employees"
WHERE emp_no IN
	(
	SELECT emp_no
	FROM "Department_Employee"
	WHERE dept_no IN
		(
		SELECT dept_no
		FROM "Departments"
		WHERE dept_name = 'Sales' or
			dept_name = 'Development'
		)
	);

--Result via join
SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    d.dept_name
FROM 
    "Employees" e
JOIN 
    "Department_Employee" de ON e.emp_no = de.emp_no
JOIN 
    "Departments" d ON de.dept_no = d.dept_no
WHERE 
    d.dept_name IN ('Sales', 'Development');

-- List frequency counts of all employee last names
SELECT last_name, COUNT(last_name) AS "last name count"
FROM "Employees"
GROUP BY last_name
ORDER BY "last name count" DESC

