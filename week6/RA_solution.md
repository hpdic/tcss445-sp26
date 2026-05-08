# Relational Algebra and SQL Practice Exercises

Please use the following database schema to write the Relational Algebra expression and the corresponding SQL query for each request.

Schema Definitions:
```sql
Student(sid, sname, major, age)
Course(cid, cname, credits, department)
Enroll(sid, cid, grade, term)
```

### Exercise 1
Find the names of all students who are majoring in Computer Science.
```sql
-- Relational Algebra
π_sname(σ_major='Computer Science'(Student))
-- SQL Query
SELECT sname 
FROM Student 
WHERE major = 'Computer Science';
```

### Exercise 2
Retrieve the course names and credits of all courses offered by the Math department that have exactly 4 credits.
```sql
-- Relational Algebra
π_{cname,credits}(σ_{department='Math' AND credits=4}(Course))
-- SQL Query
SELECT cname, credits 
FROM Course 
WHERE department = 'Math' AND credits = 4;
```

### Exercise 3
List the names of students who have received an A grade in any course.
```sql
-- Relational Algebra
π_{sname}(σ_{grade='A'}(Student ⨝ Enroll))
-- SQL Query
SELECT sname 
FROM Student S 
JOIN Enroll E ON S.sid = E.sid 
WHERE E.grade = 'A';
```

### Exercise 4
Find the departments offering courses that a student named Alice is enrolled in.
```sql
-- Relational Algebra
π_{department}(σ_{sname='Alice'}(Student ⨝ Enroll ⨝ Course))
-- SQL Query
SELECT C.department 
FROM Student S 
JOIN Enroll E ON S.sid = E.sid 
JOIN Course C ON E.cid = C.cid 
WHERE S.sname = 'Alice';
```

### Exercise 5
Return the names of courses taken by students who are older than 20 where the grade received is a B.
```sql
-- Relational Algebra
π_{cname}(σ_{age>20 AND grade='B'}(Student ⨝ Enroll ⨝ Course))
-- SQL Query
SELECT C.cname 
FROM Student S 
JOIN Enroll E ON S.sid = E.sid 
JOIN Course C ON E.cid = C.cid 
WHERE S.age > 20 AND E.grade = 'B';
```