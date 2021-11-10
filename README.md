<h1 align="center">
  <br>
  <a href="https://spikeage.com/wp-content/uploads/community_xe_512.png"><img src="https://spikeage.com/wp-content/uploads/community_xe_512.png" alt="Markdownify" width="200"></a>
   <a href="https://download.logo.wine/logo/MySQL/MySQL-Logo.wine.png"><img src="https://download.logo.wine/logo/MySQL/MySQL-Logo.wine.png" alt="Markdownify" width="400"></a>
 <a href="https://hotsechu.files.wordpress.com/2021/03/mysqlworkbench_2.png"><img src="https://hotsechu.files.wordpress.com/2021/03/mysqlworkbench_2.png" alt="Markdownify" width="200"></a>  <br>
 
 
 <br>
  Reviewing SQL with Oracle University, Oracle Database Express, and MySQL
  <br>
</h1>
<h4 align="center"> Using Oracle and MySQL to review the basics of SQL and perform: multiple DDL and DML operations, creation of users, permissions, PK, FK, CK, and other basics/complex queries to handle the data.
Additionally, I took this course to review the basics of SQL: https://learn.oracle.com/ols/learning-path/mysql-explorer/51871/79674.
</h4>

<p align="center">
  •<a href="#installation">Installation</a> •
  <a href="#structure">Structure</a> •
    <a href="#run-it">Run it</a> •
  <a href="#credits">Credits</a>
</p>


## Installation
1. Download and Configure Oracle Database Express depending on your operative system: https://www.oracle.com/database/technologies/xe-downloads.html.
2. Download and Configure MySQL depending on your operative system: https://dev.mysql.com/downloads/mysql/
3. Clone the repository
```bash
# Clone this repository
$ git clone https://github.com/luisfelipe7/SQL-Review-With-Oracle-MySQL/
```
4. Go into the repository
```bash
# Go into the repository
$ cd SQL-Review-With-Oracle-MySQL
```

## Structure
We have simple scripts in charge of creating tables and performing multiple DML and DDL operations. Both of them perform the same things, but they have some differences because of the syntax on each database:
1. SQL-Basics-Review-With-Oracle.sql : Script for Oracle Database Express Edition, designed to work with Oracle.
2. SQL-Basics-Review-With-MySQL.sql : Script for MySQL, designed to work with MySQL.
<br>
Here is an image of the simple model that I am using on the database to perform the operations:
<br>
<br>
<img src="https://github.com/luisfelipe7/SQL-Review-With-Oracle-MySQL/blob/master/SQL-Basics-Structure.png" alt="Models" width="500" height="420">

## Run it

To execute the Oracle Script just follow these steps:
1. Open the terminal.
2. Locate in the path of the script:
```bash
# Move to the path
$ cd pathOfTheScript
```
3. Then, execute this command to enter the Oracle Database:
```bash
# Initialize the Oracle Database
$ sqlplus
```
4. Enter the user and password.
5. After that execute the script using:
```bash
# Executing the script
$ @SQL-Basics-Review-With-Oracle.sql
```
You are going to see all the errors and outputs.

To execute the MySQL Script just follow these steps:
1. Open MySQL Worbench.
2. Then, open the script using MySQL Workbench: File->Open SQL Script.
3. Using the lightning bolt located on the interface execute the script.

## Credits

Thanks to UNA (Universidad Nacional de Costa Rica) for teaching everything about SQL and Oracle University for the free course to review the basics of SQL.

---

> GitHub [@luisfelipe7](https://github.com/luisfelipe7) &nbsp;&middot;&nbsp;
