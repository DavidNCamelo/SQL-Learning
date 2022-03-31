/* Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
The STATION table is described as follows */

(select city, length(city) from station order by length(city) desc, city asc limit 1)
union
(select city, length(city) from station order by length(city) asc, city asc limit 1);

/* Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.*/

SELECT DISTINCT(CITY) FROM STATION WHERE (ID%2)=0 ; MySQL and SQL server



/* Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

Input Format */
--MySQL  
SELECT DISTINCT city FROM station WHERE city RLIKE '^[aeiou]';

SQL Server SELECT DISTINCT city FROM station 
		WHERE city LIKE '[aeiou]%';

/*Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

Input Format*/
--MySQL
SELECT DISTINCT city FROM station 
WHERE city RLIKE '[aeiou]$';

--SQL Server
SELECT DISTINCT city FROM station 
        WHERE city LIKE '%[aeiou]';


/*Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.*/

--MySQL
SELECT DISTINCT city FROM station 
WHERE city RLIKE '^[aeiou]' AND city RLIKE '[aeiou]$'


--SQL Server
SELECT DISTINCT city FROM station 
        WHERE city LIKE '%[aeiou]' AND city LIKE '[aeiou]%'

/*Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.*/
--mySQL
SELECT DISTINCT city FROM station 
WHERE city NOT  RLIKE '^[aeiou]';

--SQL Server
SELECT DISTINCT city FROM station 
WHERE city NOT LIKE '[aeiou]%';

/*Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.*/

--MySQL
SELECT DISTINCT city FROM station 
WHERE city NOT  RLIKE '[aeiou]$';

--SQL Server
SELECT DISTINCT city FROM station 
WHERE city NOT LIKE '%[aeiou]';

/*Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.*/

--MySQL
SELECT DISTINCT city FROM station 
WHERE city NOT RLIKE '^[aeiou]' OR city NOT RLIKE '[aeiou]$'

--SQL Server
SELECT DISTINCT city FROM station 
        WHERE city NOT LIKE '%[aeiou]' OR city NOT LIKE '[aeiou]%'


/*Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates*/

--MySQL
SELECT DISTINCT city FROM station 
WHERE city NOT RLIKE '^[aeiou]' AND city NOT RLIKE '[aeiou]$'

--SQL Server
SELECT DISTINCT city FROM station 
        WHERE city NOT LIKE '%[aeiou]' AND city NOT LIKE '[aeiou]%'

/*Query the Name of any student in STUDENTS who scored higher than  Marks. 
Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID*/
--MySQL and SQL Server
SELECT Name FROM STUDENTS
WHERE Marks > '75'
ORDER BY RIGHT(Name, 3), ID ASC