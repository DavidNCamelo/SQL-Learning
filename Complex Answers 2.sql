--SQL COMPLEX COMMANDS 2

/*Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
but did not realize her keyboard's  key was broken until after completing the calculation. 
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), 
and the actual average salary.

Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.*/

--MySQL
SELECT CEIL(AVG(Salary)-AVG(REPLACE(Salary,'0',''))) FROM EMPLOYEES;

--SQL Server
select CEILING((avg(CONVERT(Decimal,salary))) - avg(CONVERT(DECIMAL,(REPLACE(salary,'0','')))))
from employees;


/*We define an employee's total earnings to be their monthly salary*month worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.*/
--MySQL
SELECT (salary*months) AS earnings, COUNT(salary * months) FROM employee 
GROUP BY earnings
ORDER BY COUNT(salary * months) DESC LIMIT 1

--SQL Server
SELECT TOP (1) salary * months AS earnings, COUNT(salary * months) FROM employee 
GROUP BY salary * months 
ORDER BY COUNT(salary * months) DESC



/*Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of  decimal places.*/

--MySQL
SELECT ROUND(SUM(LAT_N),2) AS lat, ROUND(SUM(LONG_W), 2) AS lon 
FROM STATION;

--SQL Server
SELECT cast(sum(lat_n) as decimal(15,2)),cast(sum(long_w) as decimal(15,2))
FROM STATION;


/*Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than . Truncate your answer to  decimal places. */
--MySQL
SELECT ROUND(sum(lat_n),4) FROM STATION
WHERE LAT_N > 38.7880 and LAT_N < 137.2345;  

--SQL Server
SELECT cast(sum(lat_n) as decimal(15,4)) FROM STATION
WHERE LAT_N > 38.7880 and LAT_N < 137.2345; 



/*Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to  decimal places*/
--MySQL
SELECT ROUND(MAX(LAT_N),4) FROM STATION
WHERE LAT_N < 137.2345

--SQL Server
SELECT CAST(MAX(LAT_N) AS DECIMAL (15,4)) FROM STATION
WHERE LAT_N < 137.2345


/*Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to  decimal places.*/

--MySQL
SELECT ROUND(LONG_W, 4) FROM STATION
    WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N<137.2345);


--SQL Server
SELECT CAST(MAX(LONG_W) AS DECIMAL (15,4)) FROM STATION
    WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N<137.2345);


/*Consider P(a, b) and P (c,d)  to be two points on a 2D plane.

 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.*/

--MySQL
SELECT ROUND( MAX(lat_n)-MIN(lat_n) + MAX(long_w)-MIN(long_w), 4) FROM Station;

--SQL Server
SELECT CAST( (MAX(lat_n)-MIN(lat_n) + MAX(long_w)-MIN(long_w)) AS DECIMAL (10,4)) FROM Station;


/*Consider P(a, b) and P (c,d)  to be two points on a 2D plane where (a, b) are the respective minimum and maximum values 
of Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.*/

--MySQL
SELECT
    ROUND(SQRT(POWER(MAX(LAT_N)  - MIN(LAT_N),  2)+ POWER(MAX(LONG_W) - MIN(LONG_W), 2)), 4)
FROM STATION;

--SQL Server
SELECT
    cast((SQRT(POWER(MAX(LAT_N)  - MIN(LAT_N),  2)+ POWER(MAX(LONG_W) - MIN(LONG_W), 2))) 
         AS DECIMAL (10,4))
FROM STATION;

/*A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.*/
--MySQL
Select round(S.LAT_N,4) mediaN from station S 
where (select count(Lat_N) from station where Lat_N < S.LAT_N ) = (select count(Lat_N) from station where Lat_N > S.LAT_N)

--SQL Server
Select CAST(S.LAT_N AS DECIMAL (10,4)) median from station S 
where (select count(Lat_N) from station where Lat_N < S.LAT_N ) = (select count(Lat_N) from station where Lat_N > S.LAT_N)



/*You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.

Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
The report must be in descending order by grade -- i.e. higher grades are entered first. 
If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

Write a query to help Eve.*/

--MySQL
SELECT IF(GRADE < 8, NULL, NAME), Grade, Marks FROM Students
JOIN Grades
WHERE MARKS BETWEEN MIN_MARK AND MAX_MARK
ORDER BY GRADE DESC, NAME

--SQL Server
SELECT IIF(GRADE < 8, NULL, NAME), Grade, Marks FROM Students
JOIN Grades ON MARKS>= MIN_MARK AND MARKS<=MAX_MARK
ORDER BY GRADE DESC, NAME


/*Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession 
as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation]
is the lowercase occupation name. If more than one Occupation has the same [occupation_count], 
they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation. */

--MySQL
SELECT CONCAT(Name, '(', substr(occupation,1,1), ')') FROM OCCUPATIONS
ORDER BY Name ASC;

SELECT concat('There are a total of ', COUNT(1), ' ' , LOWER(occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY count(1) ASC, occupation ASC;

--SQL Server
SELECT CONCAT(Name, '(', substring(occupation,1,1), ')') FROM OCCUPATIONS
ORDER BY Name ASC

SELECT CONCAT('There are a total of ', COUNT(1), ' ' , LOWER(occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY count(1) ASC, occupation ASC
 
/*Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed 
underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.*/

--SQL Server
SELECT [Doctor], [Professor], [Singer], [Actor]
FROM
    (
    SELECT ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY NAME) [RowNumber], * FROM                OCCUPATIONS
    ) AS tempTable
PIVOT
    (
    MAX(NAME) FOR OCCUPATION IN ([Doctor], [Professor], [Singer], [Actor])
    ) AS pivotTable


/*Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, 
total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, 
then the ascending company_codes will be C_1, C_10, and C_2. */
--MySQL and SQL Server
SELECT c.company_code, c.founder, 
    count(distinct l.lead_manager_code), count(distinct s.senior_manager_code), 
    count(distinct m.manager_code),count(distinct e.employee_code)
    
FROM Company c, Lead_Manager l, Senior_Manager s, Manager m, Employee e     
WHERE c.company_code = l.company_code
    AND l.lead_manager_code = s.lead_manager_code 
    AND s.senior_manager_code = m.senior_manager_code 
    AND m.manager_code=e.manager_code 
GROUP BY c.company_code, c.founder 
ORDER BY c.company_code;

/*Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student.
Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id.
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result. */
--MySQL
SELECT h.hacker_id, h.name, COUNT(DISTINCT(c.challenge_id)) AS countr
FROM Hackers as h
INNER JOIN Challenges as c ON c.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name

HAVING countr = (SELECT MAX(templ.cont) FROM (SELECT COUNT(hacker_id) as cont
                                            from Challenges
                                            group by hacker_id
                                            order by hacker_id) 
                 templ)
                 OR countr in (SELECT t.conta FROM (SELECT COUNT(*) AS conta
                                                   FROM Challenges
                                                   GROUP BY hacker_id) t
                                GROUP BY t.conta
                               HAVING COUNT(t.conta) = 1)
ORDER BY countr DESC, c.hacker_id  


/* Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.*/

--MySQL and SQL Server
SELECT SUM(CITY.POPULATION)
FROM CITY, COUNTRY
WHERE CITY.COUNTRYCODE = COUNTRY.CODE AND COUNTRY.CONTINENT = 'Asia'; 

SELECT SUM(CITY.POPULATION)
FROM CITY
INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE 
WHERE COUNTRY.CONTINENT = 'Asia'

/*Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.*/

--MySQL and SQL Server
SELECT CITY.NAME
FROM CITY
INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE 
WHERE COUNTRY.CONTINENT = 'Africa'


/*Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) 
and their respective average city populations (CITY.Population) rounded down to the nearest integer.*/
--MySQL and SQL Server
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.POPULATION))
FROM COUNTRY
INNER JOIN CITY ON CITY.COUNTRYCODE = COUNTRY.CODE
GROUP BY COUNTRY.Continent

/*Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard!
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge.
Order your output in descending order by the total number of challenges in which the hacker earned a full score.
If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.*/

--MySQL
SELECT h.hacker_id, h.name FROM Submissions AS s
INNER JOIN Challenges c ON s.challenge_id = c.challenge_id
INNER JOIN Difficulty d ON d.difficulty_level = c.difficulty_level
INNER JOIN Hackers h ON h.hacker_id = s.hacker_id
WHERE s.score = d.score AND d.difficulty_level = c.difficulty_level
GROUP BY h.hacker_id, h.name
HAVING COUNT(s.hacker_id)>1
order by count(s.hacker_id) desc, s.hacker_id asc

--SQL Server
SELECT h.hacker_id, h.name FROM Submissions AS s
INNER JOIN Challenges c ON s.challenge_id = c.challenge_id
INNER JOIN Difficulty d ON d.difficulty_level = c.difficulty_level
INNER JOIN Hackers h ON h.hacker_id = s.hacker_id
WHERE s.score = d.score AND d.difficulty_level = c.difficulty_level
GROUP BY h.hacker_id, h.name
HAVING COUNT(s.hacker_id)>1
ORDER BY COUNT(h.hacker_id) DESC, h.hacker_id ASC


/*Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 
Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power.
If more than one wand has same power, sort the result in order of descending age.*/
--MySQL and SQL Server

SELECT w.id, p.age, w.coins_needed, w.power FROM Wands as w
INNER JOIN Wands_Property AS p ON w.code = p.code
WHERE p.is_evil = 0 
    AND w.coins_needed = (SELECT MIN(w1.coins_needed) FROM Wands AS w1
                        INNER JOIN Wands_Property AS p1 ON w1.code = p1.code
                        WHERE w1.power = w.power AND p1.age = p.age)
ORDER BY w.power DESC, p.age DESC


/*You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.


If the End_Date of the tasks are consecutive, then they are part of the same project. 
Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
If there is more than one project that have the same number of completion days, then order by the start date of the project.*/
--MySQL
SELECT Start_Date, MIN(End_Date)
FROM 
/* Choose start dates that are not end dates of other projects (if a start date is an end date, it is part of the samee project) */
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
/* Choose end dates that are not end dates of other projects */
    (SELECT end_date FROM PROJECTS WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)) b
/* At this point, we should have a list of start dates and end dates that don't necessarily correspond with each other */
/* This makes sure we only choose end dates that fall after the start date, and choosing the MIN means for the particular start_date, 
we get the closest end date that does not coincide with the start of another task */
where start_date < end_date
GROUP BY start_date
ORDER BY datediff(start_date, MIN(end_date)) DESC, start_date


--SQL Server
SELECT T1.Start_Date,T2.End_Date 
FROM ( SELECT Start_Date,ROW_NUMBER() OVER (ORDER BY Start_Date) 
      RN FROM Projects WHERE Start_Date NOT IN (SELECT END_Date FROM Projects) ) AS T1 
      INNER JOIN (SELECT End_Date,ROW_NUMBER() OVER (ORDER BY End_Date) RN FROM Projects
                  WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) AS T2 ON T1.RN = T2.RN ORDER BY DATEDIFF(Day,T1.Start_Date,T2.End_Date),T1.Start_Date


/*You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
Exclude all hackers with a total score of  from your result.*/

--MySQL and SQL Server
SELECT h.hacker_id, h.name, SUM(score) FROM Hackers AS h
INNER JOIN (SELECT hacker_id,  max(score) AS score from submissions 
            group by challenge_id, hacker_id) AS max_score
            ON h.hacker_id=max_score.hacker_id
            GROUP BY h.hacker_id, H.name 
HAVING SUM(score) > 0
ORDER BY SUM(score) DESC, h.hacker_id


/*You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: 
ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

Write a query to output the names of those students whose best friends got offered a higher salary than them. 
Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.*/
--MySQL




/*Prime Numbers*/
--MySQL
SELECT GROUP_CONCAT(NUMB SEPARATOR '&')
FROM (
    SELECT @num:=@num+1 as NUMB FROM
    information_schema.tables t1,
    information_schema.tables t2,
    (SELECT @num:=1) tmp
) tempNum
WHERE NUMB<=1000 AND NOT EXISTS(
		SELECT * FROM (
			SELECT @nu:=@nu+1 as NUMA FROM
			    information_schema.tables t1,
			    information_schema.tables t2,
			    (SELECT @nu:=1) tmp1
			    LIMIT 1000
			) tatata
		WHERE FLOOR(NUMB/NUMA)=(NUMB/NUMA) AND NUMA<NUMB AND NUMA>1
	)

/*Julia conducted a  days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest), 
and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.*/

select 
submission_date ,

( SELECT COUNT(distinct hacker_id)  
 FROM Submissions s2  
 WHERE s2.submission_date = s1.submission_date AND    (SELECT COUNT(distinct s3.submission_date) FROM      Submissions s3 WHERE s3.hacker_id = s2.hacker_id AND s3.submission_date < s1.submission_date) = dateDIFF(s1.submission_date , '2016-03-01')) ,

(select hacker_id  from submissions s2 where s2.submission_date = s1.submission_date 
group by hacker_id order by count(submission_id) desc , hacker_id limit 1) as shit,
(select name from hackers where hacker_id = shit)
from 
(select distinct submission_date from submissions) s1
group by submission_date






select con.contest_id,
        con.hacker_id, 
        con.name, 
        sum(total_submissions), 
        sum(total_accepted_submissions), 
        sum(total_views), sum(total_unique_views)
from contests con 
join colleges col on con.contest_id = col.contest_id 
join challenges cha on  col.college_id = cha.college_id 
left join
(select challenge_id, sum(total_views) as total_views, sum(total_unique_views) as total_unique_views
from view_stats group by challenge_id) vs on cha.challenge_id = vs.challenge_id 
left join
(select challenge_id, sum(total_submissions) as total_submissions, sum(total_accepted_submissions) as total_accepted_submissions from submission_stats group by challenge_id) ss on cha.challenge_id = ss.challenge_id
    group by con.contest_id, con.hacker_id, con.name
        having sum(total_submissions)!=0 or 
                sum(total_accepted_submissions)!=0 or
                sum(total_views)!=0 or
                sum(total_unique_views)!=0
            order by contest_id;