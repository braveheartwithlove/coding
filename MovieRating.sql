1341. Movie Rating
Medium

Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key for this table.
title is the name of the movie.
Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key for this table.
Table: Movie_Rating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key for this table.
This table contains the rating of a movie by a user in their review.
created_at is the users review date. 
 

Write the following SQL query:

Find the name of the user who has rated the greatest number of movies.
In case of a tie, return lexicographically smaller user name.

Find the movie name with the highest average rating in February 2020.
In case of a tie, return lexicographically smaller movie name.



The query is returned in 2 rows, the query result format is in the following example:

Movies table:
+-------------+--------------+
| movie_id    |  title       |
+-------------+--------------+
| 1           | Avengers     |
| 2           | Frozen 2     |
| 3           | Joker        |
+-------------+--------------+

Users table:
+-------------+--------------+
| user_id     |  name        |
+-------------+--------------+
| 1           | Daniel       |
| 2           | Monica       |
| 3           | Maria        |
| 4           | James        |
+-------------+--------------+

Movie_Rating table:
+-------------+--------------+--------------+-------------+
| movie_id    | user_id      | rating       | created_at  |
+-------------+--------------+--------------+-------------+
| 1           | 1            | 3            | 2020-01-12  |
| 1           | 2            | 4            | 2020-02-11  |
| 1           | 3            | 2            | 2020-02-12  |
| 1           | 4            | 1            | 2020-01-01  |
| 2           | 1            | 5            | 2020-02-17  | 
| 2           | 2            | 2            | 2020-02-01  | 
| 2           | 3            | 2            | 2020-03-01  |
| 3           | 1            | 3            | 2020-02-22  | 
| 3           | 2            | 4            | 2020-02-25  | 
+-------------+--------------+--------------+-------------+

Result table:
+--------------+
| results      |
+--------------+
| Daniel       |
| Frozen 2     |
+--------------+

Daniel and Monica have rated 3 movies ("Avengers", "Frozen 2" and "Joker") but Daniel is smaller lexicographically.
Frozen 2 and Joker have a rating average of 3.5 in February but Frozen 2 is smaller lexicographically.




SELECT user_name as results FROM
(
    SELECT b.name as user_name,COUNT(*) as counts FROM Movie_rating as a
    JOIN Users as b
    ON a.user_id=b.user_id
    GROUP BY a.user_id
    ORDER BY counts DESC,user_name ASC LIMIT 1
) first_query #query for the person who rates the greatest number of movies
UNION
SELECT movie_name as results FROM
(
    SELECT d.title as movie_name,AVG(c.rating) as grade FROM Movie_rating as c
    JOIN Movies as d
    ON c.movie_id=d.movie_id
    WHERE SUBSTR(c.created_at,1,7)="2020-02"
    GROUP BY c.movie_id
    ORDER BY grade DESC,movie_name ASC LIMIT 1
) second_query; #query for the movie with the highest average rating in February


with q1 as(
select top 1 u.name as Results
from Movie_Rating mr join Users u
on mr.user_id = u.user_id
group by u.name
order by count(mr.rating) desc, u.name),

q2 as(
select top 1 m.title as Results
from Movie_Rating mr join Movies m
on mr.movie_id = m.movie_id
where left(created_at,7) = '2020-02'
group by m.title
order by avg(cast(rating as float)) desc, title)

select * from q1
union
select * from q2


select name as results 
from (
    select user_id, name, count(rating) rating_num
    from Movie_Rating left join Users using(user_id)
    group by user_id, name
    order by rating_num desc, name asc limit 1) a         
union
select title as results 
from (
  select movie_id, title, avg(rating) avg_rating
  from Movie_Rating left join Movies using(movie_id)
  where created_at like '2020-02-%'
  group by movie_id, title
  order by avg_rating desc, title asc limit 1) b
  
  

