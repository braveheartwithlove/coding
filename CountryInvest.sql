1501. Countries You Can Safely Invest In
Medium

Table Person:

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| id             | int     |
| name           | varchar |
| phone_number   | varchar |
+----------------+---------+
id is the primary key for this table.
Each row of this table contains the name of a person and their phone number.
Phone number will be in the form 'xxx-yyyyyyy' where xxx is the country code (3 characters) and yyyyyyy is the phone number (7 characters) where x and y are digits. Both can contain leading zeros.
Table Country:

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| name           | varchar |
| country_code   | varchar |
+----------------+---------+
country_code is the primary key for this table.
Each row of this table contains the country name and its code. country_code will be in the form 'xxx' where x is digits.
 

Table Calls:

+-------------+------+
| Column Name | Type |
+-------------+------+
| caller_id   | int  |
| callee_id   | int  |
| duration    | int  |
+-------------+------+
There is no primary key for this table, it may contain duplicates.
Each row of this table contains the caller id, callee id and the duration of the call in minutes. caller_id != callee_id
A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the 
average call duration of the calls in this country is strictly greater than the global average call duration.

Write an SQL query to find the countries where this company can invest.

Return the result table in any order.

The query result format is in the following example.

Person table:
+----+----------+--------------+
| id | name     | phone_number |
+----+----------+--------------+
| 3  | Jonathan | 051-1234567  |
| 12 | Elvis    | 051-7654321  |
| 1  | Moncef   | 212-1234567  |
| 2  | Maroua   | 212-6523651  |
| 7  | Meir     | 972-1234567  |
| 9  | Rachel   | 972-0011100  |
+----+----------+--------------+

Country table:
+----------+--------------+
| name     | country_code |
+----------+--------------+
| Peru     | 051          |
| Israel   | 972          |
| Morocco  | 212          |
| Germany  | 049          |
| Ethiopia | 251          |
+----------+--------------+

Calls table:
+-----------+-----------+----------+
| caller_id | callee_id | duration |
+-----------+-----------+----------+
| 1         | 9         | 33       |
| 2         | 9         | 4        |
| 1         | 2         | 59       |
| 3         | 12        | 102      |
| 3         | 12        | 330      |
| 12        | 3         | 5        |
| 7         | 9         | 13       |
| 7         | 1         | 3        |
| 9         | 7         | 1        |
| 1         | 7         | 7        |
+-----------+-----------+----------+

Result table:
+----------+
| country  |
+----------+
| Peru     |
+----------+
The average call duration for Peru is (102 + 102 + 330 + 330 + 5 + 5) / 6 = 145.666667
The average call duration for Israel is (33 + 4 + 13 + 13 + 3 + 1 + 1 + 7) / 8 = 9.37500
The average call duration for Morocco is (33 + 4 + 59 + 59 + 3 + 7) / 6 = 27.5000 
Global call duration average = (2 * (33 + 3 + 59 + 102 + 330 + 5 + 13 + 3 + 1 + 7)) / 20 = 55.70000
Since Peru is the only country where average call duration is greater than the global average,
 its the only recommended country.
 
 SELECT Country.name AS country
FROM Person JOIN Calls ON Calls.caller_id = Person.id OR Calls.callee_id = Person.id
JOIN Country ON Country.country_code = LEFT(Person.phone_number, 3)
GROUP BY Country.name
HAVING AVG(duration) > (SELECT AVG(duration) FROM Calls)


Straightforward GROUP BY/HAVING : faster than 100.00% online submissions


Following solution works in MySQL, MS SQL Server. For Oracle, replace SUBSTRING with SUBSTR

SELECT
 co.name AS country
FROM
 person p
 JOIN
     country co
     ON SUBSTRING(phone_number,1,3) = country_code
 JOIN
     calls c
     ON p.id IN (c.caller_id, c.callee_id)
GROUP BY
 co.name
HAVING
 AVG(duration) > (SELECT AVG(duration) FROM calls)
 
 
 With tmp AS (
SELECT b.name, SUM(c.duration) AS p_sum,  COUNT(c.caller_id) AS counts
FROM Person a
INNER JOIN Country b
ON substr(a.phone_number, 1, 3) = b.country_code
INNER JOIN Calls c
ON c.caller_id = a.id OR c.callee_id = a.id
GROUP BY b.name
)

SELECT name AS country
FROM tmp 
GROUP BY name
HAVING SUM(p_sum) / SUM(counts) > (
SELECT AVG(duration) 
FROM Calls
)
 
 
 
 
 with country_person as (select p.id,c.name
from person p join country c on (left(p.phone_number,3) = c.country_code)
),
all_calls as (
select caller_id as cid, duration
from calls
union
select callee_id as cid,duration
from calls)

select name as country from country_person join all_calls on (id = cid) group by name
having avg(duration) > (select avg(duration) from all_calls)

 
 