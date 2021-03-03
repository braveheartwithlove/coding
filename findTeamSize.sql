1303. Find the Team Size
Easy

Table: Employee

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| employee_id   | int     |
| team_id       | int     |
+---------------+---------+
employee_id is the primary key for this table.
Each row of this table contains the ID of each employee and their respective team.
Write an SQL query to find the team size of each of the employees.

Return result table in any order.

The query result format is in the following example:

Employee Table:
+-------------+------------+
| employee_id | team_id    |
+-------------+------------+
|     1       |     8      |
|     2       |     8      |
|     3       |     8      |
|     4       |     7      |
|     5       |     9      |
|     6       |     9      |
+-------------+------------+
Result table:
+-------------+------------+
| employee_id | team_size  |
+-------------+------------+
|     1       |     3      |
|     2       |     3      |
|     3       |     3      |
|     4       |     1      |
|     5       |     2      |
|     6       |     2      |
+-------------+------------+
Employees with Id 1,2,3 are part of a team with team_id = 8.
Employees with Id 4 is part of a team with team_id = 7.
Employees with Id 5,6 are part of a team with team_id = 9.

Method 1: with Window funciton
select employee_id, 
    count(employee_id) over(partition by team_id) as team_size
from employee

MEthod 2:
select e.employee_id, tb1.size as team_size
FROM Employee e, (
SELECT team_id,count(*) as size
FROM Employee
GROUP BY team_id) tb1
where e.team_id=tb1.team_id


MEthod 3:
This solution uses a subquery in FROM clauses

First, calculate the team size for every team using GROUP BY

# Subquery standalone

SELECT team_id, COUNT(DISTINCT employee_id) AS team_size
FROM Employee
GROUP BY team_id

Then use the original table left join the team size table on team_id


SELECT employee_id, team_size
FROM Employee AS e
LEFT JOIN (
      SELECT team_id, COUNT(DISTINCT employee_id) AS team_size
      FROM Employee
      GROUP BY team_id
) AS teams
ON e.team_id = teams.team_id

This is a very intuitive solution with an intermediate table of team size. 
Maybe redundant comparing to self-join solutions, but is more straightforward to understand.
