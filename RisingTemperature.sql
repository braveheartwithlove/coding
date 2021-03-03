197. Rising Temperature
Easy

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature in a certain day.
 

Write an SQL query to find all dates id with higher temperature compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example:

Weather
+----+------------+-------------+
| id | recordDate | Temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Result table:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
In 2015-01-02, temperature was higher than the previous day (10 -> 25).
In 2015-01-04, temperature was higher than the previous day (20 -> 30).


Approach: Using JOIN and DATEDIFF() clause [Accepted]
Algorithm

MySQL uses DATEDIFF to compare two date type values.

So, we can get the result by joining this table weather with itself and use this DATEDIFF() function.

MySQL

SELECT weather.id AS 'Id'
FROM weather
JOIN weather w 
ON DATEDIFF(weather.recordDate, w.recordDate) = 1 AND weather.Temperature > w.Temperature;


SELECT wt1.Id 
FROM Weather wt1, Weather wt2
WHERE wt1.Temperature > wt2.Temperature AND 
      TO_DAYS(wt1.DATE)-TO_DAYS(wt2.DATE)=1;
	  
	  
SELECT w1.Id FROM Weather w1, Weather w2
WHERE subdate(w1.Date, 1)=w2.Date AND w1.Temperature>w2.Temperature	  

select cur.Id
from Weather cur
join Weather prev
on prev.Date + interval 1 day = cur.Date
where cur.Temperature > prev.Temperature