512. Game Play Analysis II
Easy

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 

Write a SQL query that reports the device that is first logged in for each player.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+


select player_id, device_id 
from activity 
where (player_id, event_date) in (
                                select player_id, min(event_date)
                                from activity 
                                group by player_id
                                 ) 
								 
SELECT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN
      (SELECT player_id, MIN(event_date)
       FROM Activity
       GROUP BY 1)


SELECT a.player_id, a.device_id FROM Activity a JOIN
(SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY player_id) f
ON a.player_id = f.player_id and a.event_date = f.first_login
ORDER BY a.player_id


select distinct c.title from Content c left join TVProgram t
on c.content_id=t.content_id where c.Kids_content='Y' and content_type='Movies'
and FORMAT(t.program_date,'yyyy-MM')='2020-06'


	   
								 