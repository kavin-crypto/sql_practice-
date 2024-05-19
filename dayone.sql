use employees;

SELECT 
    *
FROM
    Salaries;

SELECT 
    dept_no
FROM
    departmentsect all data from the “departments” table.
Select * From departments;

#Select all people from the “employees” table whose first name is “Elvis”.
Select *
From employees
Where first_name = "Elvis";

# Retrieve a list with all female employees whose first name is Kellie. 
Select *
From employees
Where first_name = "Kellie" AND gender = "F";

# Retrieve a list with all employees whose first name is either Kellie or Aruna.
Select *
From employees
Where first_name = "Kellie" OR first_name = "Aruna";

# Retrieve a list with all female employees whose first name is either Kellie or Aruna.
Select *
From employees
Where gender = "F" AND (first_name = "Kellie" OR first_name = "Aruna");

# Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.
Select *
From employees
Where first_name IN( "Denis","Elvis");

# Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.
Select *
From employees
Where first_name NOT IN("John", "Mark","Jacob");

/*Working with the “employees” table, use the LIKE operator to select the data about all 
individuals, whose first name starts with “Mark”; specify that the name can be succeeded 
by any sequence of characters.*/
Select *
From employees
Where first_name LIKE ("Mark%");

# Retrieve a list with all employees who have been hired in the year 2000.
Select *
From employees
Where hire_date LIKE ("%2000%");

# Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 
Select *
From employees
Where emp_no LIKE ("1000_");

# Extract all individuals from the ‘employees’ table whose first name contains “Jack”.
Select *
From employees
Where emp_no LIKE ("%Jack%");

# Once you have done that, extract another list containing the names of employees that do not contain “Jack”.
Select *
From employees
Where emp_no Not LIKE ("Jack");

/* Select all the information from the “salaries” table regarding contracts 
from 66,000 to 70,000 dollars per year.*/
Select *
From salaries
Where salary Between "66000" AND "70000";

# Retrieve a list with all individuals whose employee number is not between ‘10004emp_nosalaries’ and ‘10012’.
Select *
From salaries
Where emp_no NOT Between "10004" AND "10012";

# Select the names of all departments with numbers between ‘d003’ and ‘d006’.
Select dept_name
From departments
Where dept_no NOT Between "d003" AND "d006";

# Select the names of all departments whose department number value is not null.
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL;

# Retrieve a list with data about all female employees who were hired in the year 2000 or after.
Select *
From employees
Where gender = "F" And (hire_date >= "2000-01-01");

# Extract a list with all employees’ salaries higher than $150,000 per annum.
Select *
From salaries
Where salary > "150000";

# Obtain a list with all different “hire dates” from the “employees” table.
Select distinct hire_date
From employees;

/* How many annual contracts with a value higher 
than or equal to $100,000 have been registered in the salaries table?*/
Select Count(*)
from salaries
Where salary >= 100000;

# How many managers do we have in the “employees” database? 
Select Count(*)
From dept_manager;

# Select all data from the “employees” table, ordering it by “hire date” in descending order.
Select *
From employees
Order By hire_date DESC;

/* Write a query that obtains an output whose first column must contain annual salaries higher 
than 80,000 dollars. The second column, renamed to “emps_with_same_salary”, must show the 
number of employee contracts signed with this salary. */

SELECT salary, COUNT(emp_no) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary;

# Select all employees whose average salary is higher than $120,000 per annum.
Select *
From salaries
WHERE salary > "120000";

/* Select the employee numbers of all individuals who have signed more 
than 1 contract after the 1st of January 2000.*/
select emp_no, count(emp_no) as contract
From dept_emp
Where from_date > "2000-01-01"
group by emp_no
Having count(emp_no)>1
Order by emp_no;

# Select the first 100 rows from the ‘dept_emp’ table.
Select *
From dept_emp
limit 100;

# How many departments are there in the “employees” database? 
Select count(distinct dept_no)
From dept_emp;

/* What is the total amount of money spent on salaries for all 
contracts starting after the 1st of January 1997?*/
Select sum(salary)
From salaries
where from_date > "1997-01-01";

# Which is the lowest employee number in the database?
Select min(emp_no)
From employees;

# Which is the highest employee number in the database?
Select max(emp_no)
From employees;

# What is the average annual salary paid to employees who started after the 1st of January 1997?
Select avg(salary)
From salaries
where from_date > "1997-01-01";

/* Round the average amount of money spent on salaries for all contracts that started 
after the 1st of January 1997 to a precision of cents.*/
Select Round(avg(salary),2)
From salaries
where from_date > "1997-01-01";

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup
(
dept_no CHAR(4) NULL,
dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup

(

    dept_no,

    dept_name

)SELECT *
FROM departments;
INSERT INTO departments_dup (dept_name)

VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE dept_no = 'd002'; 
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (

  emp_no int(11) NOT NULL,

  dept_no char(4) NULL,

  from_date date NOT NULL,

  to_date date NULL

  );
INSERT INTO dept_manager_dup
select * from dept_manager;
INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES (999904, '2017-01-01'),(999905, '2017-01-01'),
(999906, '2017-01-01'),(999907, '2017-01-01');
#DELETE FROM dept_manager_dup
#WHERE dept_no = 'd001';

/* Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date.*/

Select m.dept_no, e.emp_no, e.first_name, e.last_name, e.hire_date
From employees e
inner join dept_manager_dup m on e.emp_no = m.emp_no
order by e.hire_date;

/* Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees 
whose last name is Markovitch. See if the output contains a manager with that name. */
Select e.emp_no, e.first_name, e.last_name,m.dept_no, m.from_date
From employees e
Left join dept_manager m on e.emp_no = m.emp_no
Where e.last_name = "Markovitch"
order by m.dept_no DESC,e.emp_no;

/* Extract a list containing information about all managers’ employee number, first and last name, 
department number, and hire date. Use the old type of join syntax to obtain the result.*/ 
Select e.emp_no, e.first_name, e.last_name,m.dept_no,e.hire_date
From employees e,dept_manager m
Where e.emp_no = m.emp_no
order by e.emp_no;

/* Select the first and last name, the hire date, and the job title of all employees whose first name 
 is “Margareta” and have the last name “Markovitch”.*/
 
Select e.emp_no, e.first_name, e.last_name,e.hire_date, t.title
From employees e
join titles t on e.emp_no = t.emp_no
Where e.first_name = "Margareta" AND e.last_name = "Markovitch"
order by e.emp_no;

/* Use a CROSS JOIN to return a list with all possible combinations between managers from 
the dept_manager table and department number 9.*/
Select d.*,dm.*
From departments d
Cross Join dept_manager dm
Where d.dept_no = "d009";

# Return a list with the first 10 employees with all the departments they can be assigned to.
Select d.*,e.*
From employees e
Cross Join departments d
Where e.emp_no < 10011
Order By e.emp_no, d.dept_no;

# Select all managers’ first and last name, hire date, job title, start date, and department name.
Select e.first_name, e.last_name, e.hire_date, t.title, dm.from_date, d.dept_name
From employees e
Join titles t on e.emp_no = t.emp_no
Join dept_manager dm on t.emp_no = dm.emp_no
Join departments d on dm.dept_no = d.dept_no
Where t.title = "Manager"
ORDER BY e.emp_no;

# How many male and how many female managers do we have in the ‘employees’ database?
Select count(e.gender) as gender, t.title
From employees e
Join titles t on e.emp_no = t.emp_no
Where t.title = "Manager"
Group BY gender;

/*Go forward to the solution and execute the query. What do you think is the meaning 
of the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)?*/
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;

/*Extract the information about all department managers who were hired between 
the 1st of January 1990 and the 1st of January 1995.*/
Select * 
From dept_manager dm 
Where dm.emp_no IN (Select emp_no
From employees e
Where  e.hire_date between "1990-01-01" And "1995-01-01" );

# Select the entire information for all employees whose job title is “Assistant Engineer”. 
Select *
From employees e
Where EXISTS (Select *
From titles t
Where  t.emp_no = e.emp_no AND t.title = "Assistant Engineer" );

DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (

   emp_no INT(11) NOT NULL,

   dept_no CHAR(4) NULL,

   manager_no INT(11) NOT NULL

);

/*A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). 
In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 
(this must be subset A), and employee number 110039 as a manager to all employees from 10021 to 10040 (
this must be subset B).

Use the structure of subset A to create subset C, where you must assign employee number 110039 
as a manager to employee 110022.

Following the same logic, create subset D. Here you must do the opposite - assign 
employee 110022 as a manager to employee 110039.
*/

Select U.* From(SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(dm.dept_no) AS dep_id,
            (SELECT 
                    emp_no
                FROM
                    dept_emp
                WHERE
                    emp_no = '110022') AS manager_ID
    FROM
        employees e
    JOIN dept_emp dm ON e.emp_no = dm.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(dm.dept_no) AS dep_id,
            (SELECT 
                    emp_no
                FROM
                    dept_emp
                WHERE
                    emp_no = '110039') AS manager_ID
    FROM
        employees e
    JOIN dept_emp dm ON e.emp_no = dm.emp_no
    WHERE
        e.emp_no BETWEEN 10021 AND 10040
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS B
    
    Union Select C.*
    FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(dm.dept_no) AS dep_id,
            (SELECT 
                    emp_no
                FROM
                    dept_emp
                WHERE
                    emp_no = '110039') AS manager_ID
    FROM
        employees e
    JOIN dept_emp dm ON e.emp_no = dm.emp_no
    WHERE
        e.emp_no = "110022"
    GROUP BY e.emp_no
    ORDER BY e.emp_no) as C
    
    Union Select D.*
    FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(dm.dept_no) AS dep_id,
            (SELECT 
                    emp_no
                FROM
                    dept_emp
                WHERE
                    emp_no = '110022') AS manager_ID
    FROM
        employees e
    JOIN dept_emp dm ON e.emp_no = dm.emp_no
    WHERE
        e.emp_no = "110039"
    GROUP BY e.emp_no
    ORDER BY e.emp_no) as D) as U;
    

    
# Create a procedure that will provide the average salary of all employees.

Drop procedure If Exists Salary_employees; 


Delimiter $$
Create Procedure avg_salary()
Begin

Select avg(salary)
From salaries;

End$$

Delimiter ;

Call avg_salary();

/* Create a procedure called ‘emp_info’ that uses as parameters the first and 
the last name of an individual, and returns their employee number. */
Drop procedure If Exists emp_info; 
Delimiter $$
Create Procedure emp_info(In p_first_name varchar(255), in p_last_name varchar(255), out pp_empno Integer)
Begin
Select emp_no
Into pp_empno From employees
Where first_name= p_first_name AND last_name = p_last_name;
End$$
Delimiter ;

/*Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.
Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively. */
Set @v_emp_no = 0;
Call emp_info('Aruna','Journel',@v_emp_no);
SELECT @v_emp_no;

/* Create a function called ‘emp_info’ that takes for parameters the first 
and last name of an employee, and returns the salary from the newest contract of that employee. */
Drop function If Exists f_emp_info; 
Delimiter $$
Create Function f_emp_info(p_first_name varchar(255),p_last_name varchar(255)) Returns Decimal(10,2)
DETERMINISTIC
Begin
Declare v_max_from_date Date;
Declare v_salary Decimal(10,2);
Select from_date, Max(from_date)
Into v_max_from_date
From employees e
Join salaries s on e.emp_no = s. emp_no
Where first_name= p_first_name AND last_name = p_last_name;

Return v_max_from_date;
SELECT

    s.salary

INTO v_salary FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

           
Return v_salary;
 
End$$
Delimiter ;

SELECT f_emp_info('Aruna', 'Journel');

/* Similar to the exercises done in the lecture, obtain a result set containing the employee number, 
first name, and last name of all employees with a number higher than 109990. Create a fourth column in the query, 
indicating whether this employee is also a manager, according to the data provided in the dept_manager table, 
or a regular employee. */

Select e.emp_no,e.first_name,e.last_name,
Case 
When dm.emp_no IS NOT NULL THEN "Manager"
Else "Employee"
END as Position
From employees e
Left Join dept_manager dm on e.emp_no = dm.emp_no
Where e.emp_no > "109990";

/* Extract a dataset containing the following information about the managers: employee number, 
first name, and last name. Add two columns at the end – one showing the difference between 
the maximum and minimum salary of that employee, and another one saying whether this salary raise was higher 
than $30,000 or NOT. */
Select e.emp_no,e.first_name,e.last_name,  Max(s.salary) - Min(s.salary) as salary_diff,
Case
When Max(s.salary) - Min(s.salary) > "30000" THEN "salary raise was higher than $30,000"
Else "salary raise was not higher than $30,000"
End as salary_rise 
From dept_manager dm 
Join employees e on dm.emp_no = e.emp_no
Join salaries s ON e.emp_no = s.emp_no
Group By s.emp_no;

/* Extract the employee number, first name, and last name of the first 100 employees, 
and add a fourth column, called “current_employee” saying “Is still employed” if the employee 
is still working in the company, or “Not an employee anymore” if they aren’t. */
Select  e.emp_no,e.first_name,e.last_name,
CASE
WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
ELSE 'Not an employee anymore'
END AS current_employee
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

/*Write a query that upon execution, assigns a row number to all managers we have information for in the "employees" 
database (regardless of their department).
Let the numbering disregard the department the managers have worked in. Also, let it start from the value of 1. 
Assign that value to the manager with the lowest employee number.*/
Select *,
Row_Number()Over(ORDER BY emp_no) as row_num
From dept_manager;

/* Write a query that upon execution, assigns a sequential number for each employee number registered in the "employees" table. 
Partition the data by the employee's first name and order it by their last name in ascending order (for each partition). */
Select emp_no,first_name,last_name,
Row_Number()Over(Partition By first_name ORDER BY last_name) as row_num
From employees;

/*Obtain a result set containing the salary values each manager has signed a contract for. 
To obtain the data, refer to the "employees" database.
Use window functions to add the following two columns to the final output:
- a column containing the row number of each row from the obtained dataset, starting from 1.
- a column containing the sequential row numbers associated to the rows for each manager, 
where their highest salary has been given a number equal to the number of rows in the given partition, 
and their lowest - the number 1.
Finally, while presenting the output, make sure that the data has been ordered by the values in the 
first of the row number columns, and then by the salary values for each partition in ascending order. */
Select dm.emp_no, s.salary,
Row_Number()Over(Partition By emp_no Order by salary ASC)as row_num,
Row_Number()Over(Partition By emp_no Order by salary DESC) as manager_row_num
From salaries s
Join dept_manager dm on s.emp_no = dm.emp_no;

/* Obtain a result set containing the salary values each manager has signed a contract for. 
To obtain the data, refer to the "employees" database.
Use window functions to add the following two columns to the final output:
- a column containing the row numbers associated to each manager, where their highest salary 
has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.
- a column containing the row numbers associated to each manager, where their highest salary has been given 
the number of 1, and the lowest - a value equal to the number of rows in the given partition.
Let your output be ordered by the salary values associated to each manager in descending order. */
Select dm.emp_no, s.salary,
Row_Number()Over()as row_num,
Row_Number()Over(Partition By emp_no Order by salary DESC) as manager_row_num
From salaries s
Join dept_manager dm on s.emp_no = dm.emp_no
Order by row_num, emp_no, salary ASC;

/* Write a query that provides row numbers for all workers from the "employees" table, partitioning 
the data by their first names and ordering each partition by their employee number in ascending order.*/
Select *,
row_number()Over w as row_num
From employees
Window w as (Partition By first_name Order By emp_no);

/* Find out the lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, as well as a window 
specification introduced with the help of the WINDOW keyword.
Also, to obtain the desired result set, refer only to data from the “salaries” table. */
Select a.emp_no, min(salary) as min_salary 
From (
Select emp_no, salary,
Row_number()Over w as row_num
From salaries
Window w as (Partition by emp_no order by salary ASC)) a
Group by emp_no; 

/* Find out the lowest salary value each employee has ever signed a contract for. Once again, 
to obtain the desired output, use a subquery containing a window function. This time, however, 
introduce the window specification in the field list of the given subquery.
To obtain the desired result set, refer only to data from the “salaries” table.*/
Select a.emp_no, min(salary) as min_salary 
From (
Select emp_no, salary,
Row_number()Over (Partition by emp_no order by salary ASC) as row_num
From salaries) a
Group by emp_no; 

/* Once again, find out the lowest salary value each employee has ever signed a contract for. 
This time, to obtain the desired output, avoid using a window function. Just use an aggregate function and a subquery.
To obtain the desired result set, refer only to data from the “salaries” table.*/

Select emp_no, min(salary) as min_salary 
From (
Select emp_no, salary
From salaries) a
Group by emp_no;

/* Once more, find out the lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, as well as a window 
specification introduced with the help of the WINDOW keyword. Moreover, obtain the output without 
using a GROUP BY clause in the outer query.
To obtain the desired result set, refer only to data from the “salaries” table. */ 
Select a.emp_no, a.salary as min_salary 
From (
Select emp_no, salary,
Row_number()Over w as row_num
From salaries
Window w as (Partition by emp_no order by salary )) a
Where a.row_num = 1; 

/* Find out the second-lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, as well as a window 
specification introduced with the help of the WINDOW keyword. Moreover, obtain the desired result set 
without using a GROUP BY clause in the outer query.
To obtain the desired result set, refer only to data from the “salaries” table. */
Select a.emp_no, a.salary as min_salary 
From (
Select emp_no, salary,
Row_number()Over w as row_num
From salaries
Window w as (Partition by emp_no order by salary )) a
Where a.row_num = 2;

/*Write a query containing a window function to obtain all salary values 
that employee number 10560 has ever signed a contract for.
Order and display the obtained salary values from highest to lowest.*/
Select emp_no, salary,
rank() over w as rank_num
From salaries
where emp_no = 10560
Window  w as(Partition by emp_no order By salary desc);

/* Write a query that upon execution, displays the number of salary contracts 
that each manager has ever signed while working in the company. */
Select dm.emp_no, (count(s.salary))as salary_count
#rank() over w as rank_num
From salaries s
Join dept_manager dm on s.emp_no = dm.emp_no
Group by emp_no
order by emp_no;
#Window  w as(Partition by emp_no order By salary);

/* Write a query that upon execution retrieves a result set containing all salary values that 
employee 10560 has ever signed a contract for. Use a window function to rank all salary values 
from highest to lowest in a way that equal salary values bear the same rank and that gaps in the 
obtained ranks for subsequent rows are allowed. */
Select emp_no, salary,
rank() over w as rank_num
From salaries
where emp_no = 10560
Window  w as(Partition by emp_no order By salary desc);

/* Write a query that upon execution retrieves a result set containing all salary values that employee 
10560 has ever signed a contract for. Use a window function to rank all salary values from highest to lowest 
in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed.*/
Select emp_no, salary,
dense_rank() over w as rank_num
From salaries
where emp_no = 10560
Window  w as(Partition by emp_no order By salary desc);

/* Write a query that ranks the salary values in descending order of all contracts signed by employees numbered 
between 10500 and 10600 inclusive. Let equal salary values for one and the same employee bear the same rank. 
Also, allow gaps in the ranks obtained for their subsequent rows. */
Select e.emp_no, 
rank() over w as rank_num, s.salary 
From employees e
Join salaries s on e.emp_no = s.emp_no
where e.emp_no between 10500 AND 10600
Window  w as(Partition by emp_no order By salary desc);

/* Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:
- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the 
company for the first time.
In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps 
in the ranks obtained for their subsequent rows. */

Select e.emp_no,s.salary, 
Dense_rank() over w as rank_num, e.hire_date, s.from_date,
(YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
From employees e
Join salaries s on e.emp_no = s.emp_no
AND YEAR(s.from_date) - YEAR(e.hire_date) >= 4
where e.emp_no between 10500 AND 10600
Window  w as(Partition by emp_no order By salary desc);

/*Write a query that can extract the following information from the "employees" database:
- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive
- a column showing the previous salary from the given ordered list
- a column showing the subsequent salary from the given ordered list
- a column displaying the difference between the current salary of a certain employee and their previous salary
- a column displaying the difference between the next salary of a certain employee and their current salary
Limit the output to salary values higher than $80,000 only.
Also, to obtain a meaningful result, partition the data by employee number. */
Select emp_no, salary,
lag(salary)over w as previous_salary,
lead(salary)over w as subsequent_salary,
salary - lag(salary) over w as diff_previous_salary,
lead(salary) over w - salary as diff_subsequent_salary
from salaries 
Where salary > 80000 and emp_no between 10500 AND 10600
Window w as(PARTITION BY emp_no Order by salary ASC);

/* The MySQL LAG() and LEAD() value window functions can have a second argument, 
designating how many rows/steps back (for LAG()) or forth (for LEAD()) we'd like to refer to with respect to a given record.
With that in mind, create a query whose result set contains data arranged by the salary 
values associated to each employee number (in ascending order). Let the output contain the following six columns:
- the employee number
- the salary value of an employee's contract (i.e. which we’ll consider as the employee's current salary)
- the employee's previous salary
- the employee's contract salary value preceding their previous salary
- the employee's next salary
- the employee's contract salary value subsequent to their next salary
Restrict the output to the first 1000 records you can obtain. */
Select emp_no, salary,
lag(salary)over w as previous_salary,
LAG(salary, 2) OVER w AS 1_before_previous_salary,
lead(salary)over w as subsequent_salary,
Lead(salary, 2) OVER w AS 1_after_next_salary
from salaries 
Window w as(PARTITION BY emp_no Order by salary ASC)
Limit 1000;

/* Create a query that upon execution returns a result set containing the employee numbers, 
contract salary values, start, and end dates of the first ever contracts that each employee signed for the company.
To obtain the desired output, refer to the data stored in the "salaries" table. */
select ss.emp_no, s.salary, s.from_date, s.to_date
From salaries s
Join(Select emp_no, Min(from_date)as from_date
From salaries ss
GROUP BY emp_no) ss ON s.emp_no = ss.emp_no
WHERE s.from_date = ss.from_date;

