/* I perfomed the following analysis on the 'NASA Astronauts, 1959-Present' dataset from Kaggle.
Link to Dataset in Kaggle: https://www.kaggle.com/nasa/astronaut-yearbook
Table source: https://gist.github.com/pamelafox/b98e03caca7d1ec14394a90ec1512cff */

-- Let's look at the gender distribution
SELECT gender, COUNT(*) FROM astronauts
GROUP BY gender;

-- In terms of education and military rank, what does it 'take' to be an Astronaut?
SELECT 
CASE
    WHEN military_rank is NOT NULL AND (undergraduate_major IS NOT NULL OR graduate_major IS NOT NULL) then "Ranked Officer, Degree Obtained"
    WHEN military_rank is NOT NULL AND (undergraduate_major IS NULL AND graduate_major IS NULL) then "Ranked Officer, No Degree"
    WHEN military_rank is NULL AND (undergraduate_major IS NOT NULL OR graduate_major IS NOT NULL) then "Not an Officer, Degree Obtained"
    ELSE "Not an Officer, No Degree"
END AS rank_and_education,
COUNT(*)
FROM astronauts
GROUP BY rank_and_education
ORDER BY 2 desc;

-- I want to know which Astronauts were part of the series of Apollo missions...
SELECT name FROM astronauts
WHERE missions LIKE '%Apollo%';

-- Which institutions can claim to be the Alma Mater for at least 4 Astronauts?
SELECT alma_mater, COUNT(*) FROM astronauts
GROUP BY alma_mater
HAVING count(*) >= 4
ORDER BY 2 DESC

-- What was the average number of hours spent doing spacewalks for those Astronauts who managed to do it at least once?
SELECT AVG(space_walks_hr) FROM astronauts
WHERE space_walks > 0;
