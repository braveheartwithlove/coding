1517. Find Users With Valid E-Mails
Easy

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
user_id is the primary key for this table.
This table contains information of the users signed up in a website. Some e-mails are invalid.
 

Write an SQL query to find the users who have valid emails.

A valid e-mail has a prefix name and a domain where: 

The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.' and/or dash '-'. The prefix name must start with a letter.
The domain is '@leetcode.com'.
Return the result table in any order.

The query result format is in the following example.

 

Users
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |
+---------+-----------+-------------------------+

Result table:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
+---------+-----------+-------------------------+
The mail of user 2 doesnt have a domain.
The mail of user 5 has # sign which is not allowed.
The mail of user 6 doesnt have leetcode domain.
The mail of user 7 starts with a period.


^[a-zA-Z] the first character should be only alphanumeric
[a-zA-Z0-9_.-]* the middle can contain any of these and multiple times (* is for multiple times)
leetcode.com$ ending should be leetcode.com ($ is for the ending)
SELECT * 
FROM Users 
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode.com$'


SELECT *
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9\_\.\-]*@leetcode\.com$'

* Match zero, one, or many of the preceding expression.



^[A-Za-z] the first character must be a letter. after that...
[A-Za-z0-9_.-]* match any number of letters, numbers, underscore, periods, dashes (the * sign indicating "any number of, including zero"). after that...
@leetcode.com$ the email must end with exactly "@leetcode.com" (the $ sign indicating "ending with")
Match zero, one, or many of the preceding expression.

