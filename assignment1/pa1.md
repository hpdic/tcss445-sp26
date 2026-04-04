# TCSS 445/545 Database System Design
## Programming Assignment 1: Metadata Management

### Overview
In this assignment you will write a program that allows a database user to manage the metadata of their relational data.
By metadata, we mean the database's own information (e.g., database's name, creation time, owner) as well as the properties of the tables (e.g., table's names, attributes, constraints)

### System Design
While there are many possible designs, for this homework you are encouraged to use the following design:
* One Linux directory -> a database
* One regular file -> a table
    * You can use the first line to store the metadata of this table (i.e., schema)

### Implementation
* The program should not use external database library
* You can pick one of the following programming languages for implementation: Python, Java, C++

### Functionalities:
* Database creation, deletion
* Table creation, deletion, update, and query

### Interface
* Example: `python my_pa1.py pa1.sql`
* The output should respond whether a statement is successful or failed
* If successful, confirm that the <db_name> has been created
* If failed, explain why

### Testing
* A full test script will be provided
* The directories and regular files from the test script are expected to persist
* We will not to test your programs with other scripts or statements
* You can ask AI for help, but you are responsible for whatever you submit
    * This implies that if we ask you to explain a snippet of source code, you should be able to do it without asking AI
    * We also recommend you to include your AI prompts in your documentation, so that we can understand how you use AI to help you with this assignment

### Grading (10 points)
This is an individual assignment

* Documentation (3 points)
    * Document the testing result, i.e., something like the comments in the testfile
    * Document the persistent directories and files after running the test script
    * Document the AI prompt (if applicable)

* Source code (7 points)
    * Coding style and clarity (2 points)
        * Appropriate parenthesis locations, indention, etc.
        * Always write comments at the beginning of any files, such as author, date, history, etc.
        * Always write comments at the beginning of any nontrivial class/function, e.g., what this class/function does, input/output, high-level algorithm if needed
        * Write in-line comments for nontrivial blocks of code
    * Functionality (5 points)

### Submission
* Canvas
* Compress all your source code and documentation into one package in this format:
`<your_UWID>_pa1`
* E.g., my UW email address is dzhao@uw.edu; so my submission would be a compressed file called `dzhao_pa1`