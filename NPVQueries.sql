1421. NPV Queries
Medium


Table: NPV

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| year          | int     |
| npv           | int     |
+---------------+---------+
(id, year) is the primary key of this table.
The table has information about the id and the year of each inventory and the corresponding net present value.
 

Table: Queries

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| year          | int     |
+---------------+---------+
(id, year) is the primary key of this table.
The table has information about the id and the year of each inventory query.
 

Write an SQL query to find the npv of all each query of queries table.

Return the result table in any order.

The query result format is in the following example:

NPV table:
+------+--------+--------+
| id   | year   | npv    |
+------+--------+--------+
| 1    | 2018   | 100    |
| 7    | 2020   | 30     |
| 13   | 2019   | 40     |
| 1    | 2019   | 113    |
| 2    | 2008   | 121    |
| 3    | 2009   | 12     |
| 11   | 2020   | 99     |
| 7    | 2019   | 0      |
+------+--------+--------+

Queries table:
+------+--------+
| id   | year   |
+------+--------+
| 1    | 2019   |
| 2    | 2008   |
| 3    | 2009   |
| 7    | 2018   |
| 7    | 2019   |
| 7    | 2020   |
| 13   | 2019   |
+------+--------+

Result table:
+------+--------+--------+
| id   | year   | npv    |
+------+--------+--------+
| 1    | 2019   | 113    |
| 2    | 2008   | 121    |
| 3    | 2009   | 12     |
| 7    | 2018   | 0      |
| 7    | 2019   | 0      |
| 7    | 2020   | 30     |
| 13   | 2019   | 40     |
+------+--------+--------+

The npv value of (7, 2018) is not present in the NPV table, we consider it 0.
The npv values of all other queries can be found in the NPV table.

select q.id, q.year, coalesce(n.npv, 0) as npv
from npv n right join queries q
on n.id = q.id and n.year = q.year

yes, just right join is all good, we can write the condition like this, and we need order by

select q.id,q.year,ifnull(n.npv,0) as npv
from NPV n right join Queries q
on (n.id, n.year) = (q.id,q.year)
order by q.id,q.year;



select t1.id, t1.year, ifnull(npv, 0) as npv
from queries as t1
left join NPV as t2
on t1.id = t2.id and t1.year = t2.year;


select
q.id,
q.year,
IFNULL(NPV.npv, 0) as npv
from
Queries as q
LEFT Outer Join NPV ON q.id = NPV.id
AND q.year = NPV.year

