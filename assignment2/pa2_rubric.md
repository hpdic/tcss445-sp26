# TCSS 445/545 Database System Design
## Programming Assignment 2: Basic Data Manipulation

### Overview
In this assignment you will write a program that allows a database user to insert, delete, modify, and query their data on basic tables. Note that no table joins are required for this task. It is assumed that the functionalities of database and table structures (metadata) are already implemented from the first assignment.

### System Design
If you follow the directory and file mapping from the first assignment, one possible physical layout for a table file involves using the first line for metadata and subsequent lines for tuples. You must consider how the four core table operations (insert, modify, query, and delete) will interact with your chosen storage design.

### Implementation
* The program must not use any external database library or application.
* You may use programming languages such as Python, Java, C++, Rust, or C#.
* You can develop and test your program on Linux, Windows, or MacOS.

### Functionalities
* Your program must support SQL commands to insert tuples, delete tuples, modify tuples, and perform basic select queries.

### Interface
* Similar to the first assignment, the program will use a file input and standard output (i.e., on the terminal).

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
`<your_UWID>_pa2`
* E.g., my UW email address is dzhao@uw.edu; so my submission would be a compressed file called `dzhao_pa2`