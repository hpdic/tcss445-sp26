-- 1. Clean and initialize the database
DROP DATABASE IF EXISTS University;
CREATE DATABASE University;
USE University;

-- 2. Create Majors table
CREATE TABLE Majors (
    major_id INT PRIMARY KEY,
    major_name VARCHAR(50)
);

-- 3. Create Students table with Foreign Key
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    major_id INT,
    FOREIGN KEY (major_id) REFERENCES Majors(major_id)
);

-- 4. Create Grades table with Foreign Key
CREATE TABLE Grades (
    student_id INT,
    course_name VARCHAR(50),
    score INT,
    PRIMARY KEY (student_id, course_name),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 5. Insert test data for Majors
INSERT INTO Majors VALUES (1, 'Computer Science');
INSERT INTO Majors VALUES (2, 'Mathematics');
INSERT INTO Majors VALUES (3, 'Physics');

-- 6. Insert test data for Students
INSERT INTO Students VALUES (101, 'Alice', 1);
INSERT INTO Students VALUES (102, 'Bob', 1);
INSERT INTO Students VALUES (103, 'Charlie', 2);
INSERT INTO Students VALUES (104, 'David', 3);

-- 7. Insert test data for Grades
INSERT INTO Grades VALUES (101, 'Database', 90);
INSERT INTO Grades VALUES (101, 'Algorithm', 85);
INSERT INTO Grades VALUES (102, 'Database', 88);
INSERT INTO Grades VALUES (103, 'Calculus', 95);

-- =========================================
-- 5 Aggregate Operations
-- =========================================

-- Aggregation 1: COUNT total students
SELECT COUNT(*) FROM Students;

-- Aggregation 2: AVG score
SELECT AVG(score) FROM Grades;
-- Aggregation 2': AVG score per student (more in week 3)
SELECT student_id, AVG(score) FROM Grades GROUP BY student_id;

-- Aggregation 3: MAX global score
SELECT MAX(score) FROM Grades;

-- Aggregation 4: MIN score
SELECT MIN(score) FROM Grades;

-- Aggregation 5: SUM scores
SELECT SUM(score) FROM Grades;

-- =========================================
-- JOIN Operations
-- =========================================

-- JOIN 1: Translate major codes using explicit INNER JOIN
SELECT student_name, major_name
FROM Students
INNER JOIN Majors ON Students.major_id = Majors.major_id;

-- JOIN 2: Combine three tables using implicit join syntax in FROM clause
SELECT Students.student_name, Majors.major_name, Grades.course_name, Grades.score
FROM Students, Majors, Grades
WHERE Students.major_id = Majors.major_id AND Students.student_id = Grades.student_id;

-- JOIN 3: LEFT OUTER JOIN to show all students
-- David will appear with NULL course_name and NULL score (more in week 3)
SELECT Students.student_name, Grades.course_name, Grades.score
FROM Students
LEFT OUTER JOIN Grades ON Students.student_id = Grades.student_id;