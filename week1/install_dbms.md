Our examples will run on a Linux environment. If you want to try these examples on a Windows/MacOS machine, please install WSL/Homebrew.
* WSL: https://learn.microsoft.com/en-us/windows/wsl/install
* Homebrew: https://brew.sh/

From now on, we assume you have a Ubuntu environment. For other Linux distributions (e.g., Fedora), there are similar commands; please check their documentation. We'll primarily work in a terminal (not with graphic interface).

### For SQLite Users

In your terminal, type `sqlite3 school.db`; if you see a prompt, then you can skip the following and read the next paragraph. Otherwise, run the following:
```bash
sudo apt install sqlite3
sqlite3 school.db
```

Now you should see the SQLite prompt, try the following code:
```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    birthday DATE,
    gpa DECIMAL(3, 2)
);

INSERT INTO students (id, name, birthday, gpa) VALUES (1, 'Alice', '20000101', 3.80);
INSERT INTO students (id, name, birthday, gpa) VALUES (2, 'Bob', '20010520', 3.50);

SELECT * FROM students;

DELETE FROM students WHERE id = 2;

SELECT * FROM students;

UPDATE students SET gpa = 3.95 WHERE id = 1;

SELECT * FROM students;
```

To exit SQLite, type `.exit`.

### For MySQL Users

SQLite is a tiny DBMS and has limited features. If you want to try an industry-grade DBMS system, MySQL is one of the most popular open-source DBMSs. 

To install:
```bash
sudo apt install mysql-server libmysqlclient-dev -y
sudo mysql_secure_installation
# Answer the interactive questions above (just enter for all of them)
```

To setup the default database user, you need to download the `setup_mysql.sh` script and run it like this:
```bash
chmod +x setup_mysql.sh
./setup_mysql.sh
```

Then, launch your MySQL instance by typing the following
```bash
mysql -uroot -proot
```

After you see the prompt, try the following command:
```sql
CREATE DATABASE school;
USE school;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    birthday DATE,
    gpa DECIMAL(3, 2)
);

INSERT INTO students (id, name, birthday, gpa) VALUES (1, 'Alice', '20000101', 3.80);
INSERT INTO students (id, name, birthday, gpa) VALUES (2, 'Bob', '20010520', 3.50);

SELECT * FROM students;

DELETE FROM students WHERE id = 2;

SELECT * FROM students;

UPDATE students SET gpa = 3.95 WHERE id = 1;

SELECT * FROM students;
```

To exit MySQL, type `exit`.

