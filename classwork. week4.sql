DROP DATABASE IF EXISTS school;
CREATE DATABASE school;
USE school;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    age INT CHECK (age >= 18),
    city VARCHAR(50) DEFAULT 'Unknown',
    join_date DATE
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    product VARCHAR(50) NOT NULL,
    order_date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE datatypes_example (
    id INT,
    name VARCHAR(50),
    price DECIMAL(10,2),
    is_active BOOLEAN,
    join_date DATE,
    description TEXT
);

INSERT INTO students (name, age, city, join_date)
VALUES
    ('Ram', 20, 'Lalitpur', '2025-01-15'),
    ('Shyam', 22, 'Kathmandu', '2025-02-10'),
    ('Gucci', 19, 'Bhaktapur', '2025-03-05');

INSERT INTO orders (student_id, product, order_date)
VALUES
    (1, 'Laptop', '2024-04-01'),
    (2, 'Phone', '2024-04-02');

SELECT * FROM students;
SELECT * FROM orders;

CREATE INDEX idx_students_name ON students(name);

CREATE VIEW student_view AS
SELECT name, city, join_date
FROM students;

SELECT * FROM student_view;

ALTER TABLE students
ADD COLUMN email VARCHAR(100);

ALTER TABLE students
DROP COLUMN email;

SELECT * FROM students WHERE name = 'Ram';

-- Optional cleanup
-- DROP INDEX idx_students_name ON students;
-- DROP TABLE orders;
-- DROP TABLE students;
-- DROP DATABASE school;