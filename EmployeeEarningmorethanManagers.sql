181. Employees Earning More Than Their Managers
Easy

The Employee table holds all employees including their managers. 
Every employee has an Id, and there is also a column for the manager Id.

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
Given the Employee table, write a SQL query that finds out employees who earn more 
than their managers. For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+

SELECT
    a.Name AS 'Employee'
FROM
    Employee AS a,
    Employee AS b
WHERE
    a.ManagerId = b.Id
        AND a.Salary > b.Salary
;

select E1.Name 
from Employee as E1, Employee as E2 
where E1.ManagerId = E2.Id and E1.Salary > E2.Salary



Approach I: Using JOIN clause [Accepted]
Algorithm

Actually, JOIN is a more common and efficient way to link tables together, and we can use ON to specify some conditions.

SELECT a.NAME AS Employee
FROM Employee AS a 
JOIN Employee AS b
ON a.ManagerId = b.Id AND a.Salary > b.Salary
;

SELECT employer.Name
FROM  Employee employer 
JOIN Employee manager 
ON (employer.ManagerId = manager.Id )
WHERE employer.Salary > manager.Salary ;

Two Straightforward way, using 'where' and 'join'

By the way, 'where' method took about 180 ms less time than 'join' method.

Where:

select 
e1.Name
from Employee e1, Employee e2
where e1.ManagerId = e2.Id and e1.Salary > e2.Salary
Join:

select 
e1.Name
from Employee e1 join Employee e2
on e1.ManagerId = e2.Id and e1.Salary>e2.Salary

