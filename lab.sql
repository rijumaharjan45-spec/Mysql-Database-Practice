DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'Sales'),
    (2, 'Engineering'),
    (3, 'Human Resources'),
    (4, 'Customer Service'),
    (5, 'Research And Development');

INSERT INTO employees (id, employee_name, department_id)
VALUES
    (1, 'Homer Simpson', 4),
    (2, 'Ned Flanders', 1),
    (3, 'Barney Gumble', 5),
    (4, 'Clancy Wiggum', 3),
    (5, 'Moe Szyslak', NULL);

-- Show individual tables
SELECT * FROM employees;
SELECT * FROM departments;

-- INNER JOIN
SELECT *
FROM employees emp
INNER JOIN departments dep
ON emp.department_id = dep.department_id;

-- LEFT JOIN
SELECT *
FROM employees emp
LEFT JOIN departments dep
ON emp.department_id = dep.department_id;

-- RIGHT JOIN (Output like your image)
SELECT *
FROM departments dep
RIGHT JOIN employees emp
ON emp.department_id = dep.department_id;

-- Clean formatted RIGHT JOIN
SELECT
    dep.department_id,
    dep.department_name,
    emp.id AS employee_id,
    emp.employee_name,
    emp.department_id AS emp_department_id
FROM departments dep
RIGHT JOIN employees emp
ON emp.department_id = dep.department_id;