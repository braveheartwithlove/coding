1270. All People Report to the Given Manager
Medium

Table: Employees

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| employee_id   | int     |
| employee_name | varchar |
| manager_id    | int     |
+---------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates that the employee with ID employee_id and name employee_name reports his work to his/her direct manager with manager_id
The head of the company is the employee with employee_id = 1.
 

Write an SQL query to find employee_id of all employees that directly or indirectly 
report their work to the head of the company.

The indirect relation between managers will not exceed 3 managers as the company is small.

Return result table in any order without duplicates.

The query result format is in the following example:

Employees table:
+-------------+---------------+------------+
| employee_id | employee_name | manager_id |
+-------------+---------------+------------+
| 1           | Boss          | 1          |
| 3           | Alice         | 3          |
| 2           | Bob           | 1          |
| 4           | Daniel        | 2          |
| 7           | Luis          | 4          |
| 8           | Jhon          | 3          |
| 9           | Angela        | 8          |
| 77          | Robert        | 1          |
+-------------+---------------+------------+

Result table:
+-------------+
| employee_id |
+-------------+
| 2           |
| 77          |
| 4           |
| 7           |
+-------------+

The head of the company is the employee with employee_id 1.
The employees with employee_id 2 and 77 report their work directly to the head of the company.
The employee with employee_id 4 report his work indirectly to the head of the company 4 --> 2 --> 1. 
The employee with employee_id 7 report his work indirectly to the head of the company 7 --> 4 --> 2 --> 1.
The employees with employee_id 3, 8 and 9 dont report their work to head of company directly 
or indirectly. 



SELECT e1.employee_id
FROM Employees e1
JOIN Employees e2
ON e1.manager_id = e2.employee_id
JOIN Employees e3
ON e2.manager_id = e3.employee_id
WHERE e3.manager_id = 1 AND e1.employee_id != 1
even cleaner

SELECT e1.employee_id
FROM Employees e1,
     Employees e2,
     Employees e3
WHERE e1.manager_id = e2.employee_id
  AND e2.manager_id = e3.employee_id
  AND e3.manager_id = 1 
  AND e1.employee_id != 1
  
select m.employee_id
from Employees m join Employees e  on m.manager_id = e.employee_id
                 join Employees f on e.manager_id = f.employee_id
where f.manager_id = 1 and m.employee_id !=1  
  
recursive CTE  
WITH CTE AS (
    SELECT employee_id
    FROM Employees
    WHERE manager_id = 1 AND employee_id != 1
    UNION ALL
    SELECT e.employee_id
    FROM CTE c INNER JOIN Employees e ON c.employee_id = e.manager_id
)
SELECT employee_id
FROM CTE
ORDER BY employee_id
OPTION (MAXRECURSION 3);
I set MAXRECURSION to 3 as it is restricted in the task, depending on the real case it can be updated.

select a.employee_id
from Employees a,Employees b, Employees c
where a.manager_id=b.employee_id and b.manager_id=c.employee_id 
and a.employee_id<>1 and (a.manager_id = 1 or b.manager_id=1 or c.manager_id=1)



Simple MySQL union solution beats 100% with comment
8
eminem18753's avatar
eminem18753
540
Last Edit: November 26, 2019 8:01 PM

2.0K VIEWS

# Write your MySQL query statement below
SELECT a.employee_id as EMPLOYEE_ID FROM Employees as a # those whose boss is 1
WHERE a.employee_id!=1 AND a.manager_id=1
UNION
SELECT b.employee_id FROM Employees as b #those whose boss' boss is 1
WHERE b.manager_id IN
(
    SELECT a.employee_id FROM Employees as a
    WHERE a.employee_id!=1 AND a.manager_id=1    
)
UNION
SELECT c.employee_id FROM Employees as c #those whose boss' boss' boss is 1
WHERE c.manager_id IN
(
    SELECT b.employee_id FROM Employees as b
    WHERE b.manager_id IN
    (
        SELECT a.employee_id FROM Employees as a
        WHERE a.employee_id!=1 AND a.manager_id=1    
    )
)
ORDER BY EMPLOYEE_ID;
