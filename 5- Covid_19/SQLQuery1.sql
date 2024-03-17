--SELECT continent, location, SUM(new_deaths) as total_death
--FROM deaths
--WHERE continent = 'Asia' 
--GROUP BY continent, location
--ORDER BY continent, total_death DESC;

---------   Statistics based on countries   ---------

--which country has max_deaths and min_deaths?

--SELECT location, SUM(new_deaths)/1e06 AS tot_deaths_in_millions
--FROM COVID_19.dbo.deaths
--GROUP BY location
--HAVING SUM(new_deaths) IS NOT NULL
--ORDER BY tot_deaths_in_millions DESC;
-- the country with max_deaths is US with around 1 million, the whole world has around 7 millions , and the ones with zero are several like Saint Helena, Vatican, Falkland Islands, and North Korea


--total cases VS total deaths

--Select location, Round((Sum(new_deaths)/Sum(new_cases))*100, 2) As death_percentage, Sum(new_cases) AS cases, Sum(new_deaths) AS deaths, AVG(population)/1e06 as populationn
--From COVID_19..deaths
--Where new_cases IS NOT NULL AND new_deaths IS NOT NULL AND new_cases <> 0 AND new_deaths <> 0 AND continent IS NOT NULL
--Group By location
--Order By 2 DESC;

--Looking at countries with the highest infection rate compared to population

--Select location, (SUM(CAST(new_cases AS FLOAT)) / AVG(population))*100 As max_cases_population_percentage, 
--SUM(new_cases)/1e03 max_cases_in_countries, avg(population)/1e06 as populationn
--From COVID_19..deaths
--Where continent IS NOT NULL
--Group By location
--Order By 2 DESC;


--which country has max_death and min_deaths compared to its population (percentage)?

--SELECT location, Sum(new_deaths) AS tot_deaths, AVG(population)/1e06 AS population_in_millions, ROUND( (SUM(new_deaths)/AVG(population))*100, 2) AS tot_deaths_population_percentage
--FROM COVID_19.dbo.deaths
--WHERE location IS NOT NULL
--GROUP BY location
--ORDER BY tot_deaths_population_percentage DESC;




---------------				Continent Based Queries			-----------------------


--which continent has max_deaths and min_deaths compared to its population (percentage)?

--SELECT continent, (SUM(new_deaths)/SUM(population))*100 AS tot_continent_deaths_percentage
--FROM COVID_19.dbo.deaths
--WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY tot_continent_deaths_percentage DESC;



--which continent has max_deaths and min_deaths?

--SELECT continent, SUM(new_deaths)/1e06 AS tot_deaths_in_millions
--FROM COVID_19.dbo.deaths
----WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY tot_deaths_in_millions DESC;








-----------			Time Based Queries			------------

-- which month/s has/ve the highst and lowest peak/s in infections?

--SELECT YEAR(date) AS year, MONTH(date) AS month, SUM(new_cases)/1e06 as sum_new_cases
--FROM COVID_19.dbo.deaths
--WHERE continent IS NOT NULL
--GROUP BY YEAR(date), MONTH(date)
--ORDER BY year, month;


-- Highest months

--WITH RankedMonths AS (
--  SELECT
--    YEAR(date) AS year,
--    MONTH(date) AS month,
--    SUM(new_cases)/1e06 AS sum_new_cases,
--    ROW_NUMBER() OVER (PARTITION BY YEAR(date) ORDER BY SUM(new_cases) DESC) AS MonthRank
--  FROM
--    COVID_19.dbo.deaths
--	WHERE 
--	  continent IS NOT NULL

--  GROUP BY
--    YEAR(date),
--    MONTH(date)
--)

--SELECT
--  year,
--  month,
--  sum_new_cases
--FROM
--  RankedMonths
--WHERE
--  MonthRank = 1
--ORDER BY
--  year, month;

-- Lowest months

--WITH RankedMonths AS (
--  SELECT
--    YEAR(date) AS year,
--    MONTH(date) AS month,
--    SUM(new_cases)/1e06 AS sum_new_cases,
--    ROW_NUMBER() OVER (PARTITION BY YEAR(date) ORDER BY SUM(new_cases) ASC) AS MonthRank
--  FROM
--    COVID_19.dbo.deaths
--  GROUP BY
--    YEAR(date),
--    MONTH(date)
--)
--SELECT
--  year,
--  month,
--  sum_new_cases
--FROM
--  RankedMonths
--WHERE
--  MonthRank = 1
--ORDER BY
--  year, month;
