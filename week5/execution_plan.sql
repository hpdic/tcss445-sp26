
/**
 * Create a database and tables for a university system, and insert sample data.
 * This script will be used to demonstrate execution plans in SQL.
 */

DROP DATABASE IF EXISTS UniversityDB;
CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    major VARCHAR(50),
    age INT
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50),
    score DECIMAL(5, 2),
    INDEX (student_id)
);

INSERT INTO Students (student_id, student_name, major, age) VALUES
(1, 'Alice', 'Computer Science', 20),
(2, 'Bob', 'Mathematics', 22),
(3, 'Charlie', 'Computer Science', 21),
(4, 'Diana', 'Physics', 19),
(5, 'Eve', 'Mathematics', 23);

INSERT INTO Grades (grade_id, student_id, course_name, score) VALUES
(101, 1, 'Database Systems', 95.0),
(102, 1, 'Algorithms', 88.5),
(103, 2, 'Calculus', 92.0),
(104, 3, 'Database Systems', 85.0),
(105, 4, 'Quantum Mechanics', 90.0);

/**
 * Now we will run an EXPLAIN statement to see the execution plan for a query that retrieves
 * the names and ages of Computer Science students older than 20.

 * It should be clear that "Explain" is for MySQL. In other database systems, the syntax may differ (e.g., "EXPLAIN PLAN FOR" in Oracle, "EXPLAIN" in PostgreSQL). Always refer to your specific database documentation for the correct syntax and usage of execution plan analysis.
 */

EXPLAIN SELECT student_name, age
FROM Students
WHERE major = 'Computer Science' AND age > 20;
/**
 * Example output:
    mysql> EXPLAIN SELECT student_name, age
    -> FROM Students
    -> WHERE major = 'Computer Science' AND age > 20;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | Students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |    20.00 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

 * id: The identifier for the query execution step.
 * select_type: The type of SELECT statement (SIMPLE, PRIMARY, etc.).
 * table: The name of the table being accessed.
 * partitions: The partitions used (if any). In this case, it is NULL, indicating that there are no partitions. A partition is a way to divide a large table into smaller, more manageable pieces, which can improve query performance. Since this table is not partitioned, the value is NULL. A "partitioin" should not be confused with the "group by" clause, which is used to group rows based on a specified column or expression.
 * type: The type of access method used (ALL, index, range, etc.). ALL indicates a full table scan, which is not efficient for large datasets.
 * possible_keys: The indexes that could be used to optimize the query. In this case, it is NULL, indicating that there are no indexes that can be used for this query.
 * key: The index actually used by the query. Since possible_keys is NULL, this is also NULL.
 * key_len: The length of the key used. Since no index is used, this is NULL.
 * ref: The columns or constants used to compare with the index. Since no index is used, this is NULL. This should not be confused with the foreign key constraint, which is a database constraint that establishes a relationship between two tables. The "ref" column in the EXPLAIN output indicates the columns or constants used to compare with the index, while a foreign key constraint is a rule that ensures referential integrity between tables by enforcing that values in one table correspond to values in another table.
 * rows: The estimated number of rows that will be examined. In this case, it is 5, which is the total number of rows in the Students table.
 * filtered: The percentage of rows that will be filtered by the WHERE clause. In this case, it is 20.00, meaning that 20% of the rows will match the conditions specified in the WHERE clause. The reason why it is 20% is because there are 5 rows in total, and only 1 row (Charlie) meets the criteria of being a Computer Science student older than 20. Therefore, the calculation is (1/5) * 100 = 20.00%. But how does the database engine arrive at this estimate? The database engine uses statistics about the data distribution in the table to make an educated guess about how many rows will match the WHERE clause conditions. In this case, it likely knows that there are 2 Computer Science students (Alice and Charlie) and that only one of them is older than 20, leading to the 20% estimate. This is one of the most active areas of research in query optimization, as accurate estimates can significantly impact the choice of execution plan and overall query performance.
 * Extra: Additional information about the query execution. "Using where" indicates that the WHERE clause is being used to filter rows after the full table scan.
 */

EXPLAIN SELECT major, AVG(age) AS average_age
FROM Students
GROUP BY major;

/**

Example output:
mysql> EXPLAIN SELECT major, AVG(age) AS average_age
    -> FROM Students
    -> GROUP BY major;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-----------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra           |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-----------------+
|  1 | SIMPLE      | Students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |   100.00 | Using temporary |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-----------------+
1 row in set, 1 warning (0.00 sec)

 * id: The identifier for the query execution step.
 * select_type: The type of SELECT statement (SIMPLE, PRIMARY, etc.).
 * table: The name of the table being accessed.
 * partitions: The partitions used (if any). In this case, it is NULL, indicating that there are no partitions, even though the query includes a GROUP BY clause. This is because the table is not partitioned, and the GROUP BY operation is performed on the entire dataset. This may be confusing, as one might expect that the GROUP BY clause would utilize partitions if they were available. However, since the table is not partitioned, the value remains NULL. A "partitioin" should not be confused with the "group by" clause, which is used to group rows based on a specified column or expression.   
 * type: The type of access method used (ALL, index, range, etc.). ALL indicates a full table scan, which is not efficient for large datasets.
 * possible_keys: The indexes that could be used to optimize the query. In this case, it is NULL, indicating that there are no indexes that can be used for this query.
 * key: The index actually used by the query. Since possible_keys is NULL, this is also NULL.
 * key_len: The length of the key used. Since no index is used, this is NULL.
 * ref: The columns or constants used to compare with the index. Since no index is used, this is NULL. This should not be confused with the foreign key constraint, which is a database constraint that establishes a relationship between two tables. The "ref" column in the EXPLAIN output indicates the columns or constants used to compare with the index, while a foreign key constraint is a rule that ensures referential integrity between tables by enforcing that values in one table correspond to values in another table.
 * rows: The estimated number of rows that will be examined. In this case, it is 5, which is the total number of rows in the Students table.
 * filtered: The percentage of rows that will be filtered by the WHERE clause. In this case, it is 100.00, meaning that all rows will be processed since there is no WHERE clause to filter them.
 * Extra: Additional information about the query execution. "Using temporary" indicates that a temporary table is being used to hold intermediate results during the GROUP BY operation, which can impact performance, especially for larger datasets.
 */

EXPLAIN SELECT s.student_name, g.course_name, g.score
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
WHERE g.score > 90;

/**
Example output:

mysql> EXPLAIN SELECT s.student_name, g.course_name, g.score
    -> FROM Students s
    -> JOIN Grades g ON s.student_id = g.student_id
    -> WHERE g.score > 90;
+----+-------------+-------+------------+--------+---------------+---------+---------+---------------------------+------+----------+-------------+
| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref                       | rows | filtered | Extra       |
+----+-------------+-------+------------+--------+---------------+---------+---------+---------------------------+------+----------+-------------+
|  1 | SIMPLE      | g     | NULL       | ALL    | student_id    | NULL    | NULL    | NULL                      |    5 |    33.33 | Using where |
|  1 | SIMPLE      | s     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | UniversityDB.g.student_id |    1 |   100.00 | NULL        |
+----+-------------+-------+------------+--------+---------------+---------+---------+---------------------------+------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

 * id: The identifier for the query execution step. In this case, both steps have the same id (1) because they are part of the same query execution plan.
 * select_type: The type of SELECT statement (SIMPLE, PRIMARY, etc.).
 * table: The name of the table being accessed. In this case, the first step accesses the Grades table (g), and the second step accesses the Students table (s).
 * partitions: The partitions used (if any). In this case, it is NULL for both steps, indicating that there are no partitions.
 * type: The type of access method used (ALL, index, range, etc.). The first step uses ALL, indicating a full table scan on the Grades table, while the second step uses eq_ref, which is an efficient access method for joining tables based on a primary key.
 * possible_keys: The indexes that could be used to optimize the query. For the Grades table, the possible key is student_id, while for the Students table, the possible key is PRIMARY.
 * key: The index actually used by the query. In this case, no index is used for the Grades table (NULL), while the PRIMARY index is used for the Students table.
 * key_len: The length of the key used. Since no index is used for the Grades table, this is NULL, while for the Students table, it is 4 bytes (the size of an INT).
 * ref: The columns or constants used to compare with the index. For the Grades table, this is NULL since no index is used, while for the Students table, it references the student_id from the Grades table.
 * rows: The estimated number of rows that will be examined. For the Grades table, it is 5, which is the total number of rows in the Grades table, while for the Students table, it is 1, which is the estimated number of rows that will be accessed based on the join condition. This is because the eq_ref access method indicates that for each row in the Grades table, there will be at most one matching row in the Students table based on the primary key.
 * filtered: The percentage of rows that will be filtered by the WHERE clause. For the Grades table, it is 33.33, meaning that approximately one-third of the rows will match the condition g.score > 90, while for the Students table, it is 100.00, meaning that all rows accessed will be processed since there is no additional WHERE clause to filter them.
 * Extra: Additional information about the query execution. "Using where" indicates that the WHERE clause is being used to filter rows after the join operation for the Grades table, while for the Students table, there is no additional information provided (NULL).
 */