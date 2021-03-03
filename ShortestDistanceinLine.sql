613. Shortest Distance in a Line
Easy

Table point holds the x coordinate of some points on x-axis in a plane, which are all integers.
 

Write a query to find the shortest distance between two points in these points.
 

| x   |
|-----|
| -1  |
| 0   |
| 2   |
 

The shortest distance is '1' obviously, which is from point '-1' to '0'. So the output is as below:
 

| shortest|
|---------|
| 1       |
 
 
SELECT MIN(a.x - b.x) AS shortest
FROM point a, point b
WHERE a.x > b.x;


SELECT MIN(p2.x-p1.x) AS shortest
  FROM point AS p1
  JOIN point AS p2
    ON p1.x < p2.x;
	
select top 1 abs(p2.x - p1.x) as shortest
from point p1
join point p2
on p1.x != p2.x
order by shortest

SelfJoin
SELECT MIN(ABS(P1.x - P2.x)) AS shortest 
FROM point AS P1
JOIN point AS P2 
ON P1.x <> P2.x

	
Window

SELECT min(distance) as shortest 
from
(
SELECT x, abs(x- LEAD(x) OVER(order by x asc)) as distance 
from point
) x