# TCSS 445/545 Database System Design
## Programming Assignment 3: Table Joins

### Overview
In this assignment you will write a program that allows a database user to make queries over multiple tables. That is, you will implement table joins using techniques we discussed in the class. This assignment assumes the metadata and data manipulations on singular tables are already available, which should have been provided and implemented in the first two programming assignments.

### System Design
You will decide how to implement the join operations. In lectures we discussed nested loop (we will discuss more possible techniques like index, hash, and sort).
The pseudocode for a join could be iterating through each line of the first table file, then each line of the second table file, and checking the condition parsed from the given query.

### Implementation
* The program should not use external database libraries or applications.
* The following programming languages are acceptable, e.g., Python, Java, C/C++, C#, Rust.

### Functionalities
* Your program must support SQL commands to perform table joins, specifically inner join and left outer join.

### Interface
* Similar to the first two assignments, the program will use a file input and standard output (i.e., on the terminal).

### Testing
* A full test script will be provided for verification.
* Your should test your program like this (e.g. in Java): `java <your_java_program> pa2_test.sql`
* You do not need to parse comment lines in the test script (starting with `--`).

### Grading (15 points)
This is an individual assignment

* Documentation (4 points)
    * Document the testing result, i.e., something like the comments in the testfile
    * Document the persistent directories and files after running the test script
    * Document the AI prompt (if applicable)

* Source code (11 points)
    * Coding style and clarity (2 points)
        * Appropriate parenthesis locations, indention, etc.
        * Always write comments at the beginning of any files, such as author, date, history, etc.
        * Always write comments at the beginning of any nontrivial class/function, e.g., what this class/function does, input/output, high-level algorithm if needed
        * Write in-line comments for nontrivial blocks of code
    * Functionality (9 points)

### Submission
* Canvas
* Compress all your source code and documentation into one package in this format:
`<your_UWID>_pa3`
* E.g., my UW email address is dzhao@uw.edu; so my submission would be a compressed file called `dzhao_pa3`