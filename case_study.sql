-- 1. QUESTION: WHAT ARE THE AVERAGE UNEMPLOYMENT RATES EACH YEAR BY COUNTRY (FOCUSING ON LAST 10 YEARS)?
-- Yearly average unemployment rate by country
SELECT country_name,
       YEAR(STR_TO_DATE(date,'%m/%d/%Y')) AS year,
       ROUND(AVG(rate),2) AS avg_rate
FROM unemp_rate
WHERE gender = "ALL" AND
      YEAR(STR_TO_DATE(date,'%m/%d/%Y')) BETWEEN "2011-09-01" AND "2021-09-01"
GROUP BY country_name,
         year;



-- 2. QUESTION? WHAT ARE THESE AVERAGES BY ADDING GENDER? WHICH IS HIGHER?
-- With Common Table Expressions, retrieving ALL, MALE and FEMALE yearly average unemployment rates
WITH all_unemp AS
  (SELECT country_name,
          YEAR(STR_TO_DATE(date,'%m/%d/%Y')) AS year,
          ROUND(AVG(rate),2) AS all_avg_rate
FROM unemp_rate
WHERE gender = "ALL" AND
      YEAR(STR_TO_DATE(date,'%m/%d/%Y')) BETWEEN "2011-09-01" AND "2021-09-01"
GROUP BY country_name,
         year),
         
male_unemp AS
	(SELECT country_name,
          YEAR(STR_TO_DATE(date,'%m/%d/%Y')) AS year,
          ROUND(AVG(rate),2) AS male_avg_rate
FROM unemp_rate
WHERE gender = "MEN" AND
      YEAR(STR_TO_DATE(date,'%m/%d/%Y')) BETWEEN "2011-09-01" AND "2021-09-01"
GROUP BY country_name,
         year),
         
female_unemp AS
	(SELECT country_name,
          YEAR(STR_TO_DATE(date,'%m/%d/%Y')) AS year,
          ROUND(AVG(rate),2) AS female_avg_rate
FROM unemp_rate
WHERE gender = "WOMEN" AND
      YEAR(STR_TO_DATE(date,'%m/%d/%Y')) BETWEEN "2011-09-01" AND "2021-09-01"
GROUP BY country_name,
         year)

SELECT all_unemp.country_name,
       all_unemp.year,
       all_avg_rate,
       male_avg_rate,
       female_avg_rate,
       (male_avg_rate > female_avg_rate) AS is_male_higher,
       (male_avg_rate < female_avg_rate) AS is_female_higher
FROM all_unemp
LEFT JOIN male_unemp
  ON all_unemp.country_name = male_unemp.country_name AND all_unemp.year = male_unemp.year
LEFT JOIN female_unemp
  ON male_unemp.country_name = female_unemp.country_name  AND male_unemp.year = female_unemp.year;



-- 3. QUESTION: IS THE OVERALL UNEMPLOYMENT RATE (INCL. BOTH WOMEN AND MEN) INCREASED OR DECREASED COMPARED TO THE PREVIOUS MONTH?
WITH temp_table AS
  (SELECT country_name,
          gender,
          STR_TO_DATE(date,'%m/%d/%Y') AS month,
          ROUND(AVG(rate),2) AS avg_rate,
          LAG(ROUND(AVG(rate),2),1) OVER(PARTITION BY country_name, gender ORDER BY STR_TO_DATE(date,'%m/%d/%Y')) AS previous_avg_rate
  FROM unemp_rate
  GROUP BY country_name,
           gender,
           month)
         
SELECT country_name, month, avg_rate, previous_avg_rate,
       (avg_rate > previous_avg_rate) AS is_higher_than_prev_month
FROM temp_table
WHERE gender = "ALL" AND
      country_name = "United States of America" AND
      month BETWEEN "2011-09-01" AND "2021-09-01";
      
 
 
 -- 4. QUESTION: IS THE OVERALL UNEMPLOYMENT RATE (INCL. BOTH WOMEN AND MEN) INCREASED OR DECREASED COMPARED TO THE PREVIOUS PERIOD LAST YEAR?
WITH temp_table AS
  (SELECT country_name,
          gender,
          STR_TO_DATE(date,'%m/%d/%Y') AS month,
          ROUND(AVG(rate),2) AS avg_rate,
          LAG(ROUND(AVG(rate),2),12) OVER(PARTITION BY country_name, gender ORDER BY STR_TO_DATE(date,'%m/%d/%Y')) AS previous_year_avg_rate
  FROM unemp_rate
  GROUP BY country_name,
           gender,
           month)
         
SELECT country_name, month, avg_rate, previous_year_avg_rate,
       (avg_rate > previous_year_avg_rate) AS is_higher_than_prev_year
FROM temp_table
WHERE gender = "ALL" AND
      country_name = "United States of America" AND
      month BETWEEN "2011-09-01" AND "2021-09-01";
      
      
      
-- 5. QUESTION: WHAT IS THE YOY GROWTH PERCENTAGE OF THE UNEMPLOYMENT RATE IN THE USA DURING THE PANDEMIC PERIOD?
WITH temp_table AS 
  (SELECT country_name,
          gender,
          STR_TO_DATE(date,'%m/%d/%Y') AS month,
          ROUND(AVG(rate),2) AS avg_rate,
          LAG(ROUND(AVG(rate),2),12) OVER(PARTITION BY country_name, gender ORDER BY STR_TO_DATE(date,'%m/%d/%Y')) AS previous_year_avg_rate
FROM unemp_rate
GROUP BY country_name,
		 gender,
		 month)
         
SELECT country_name, month, avg_rate, previous_year_avg_rate,
       ROUND(((avg_rate / previous_year_avg_rate)-1)*100) AS yoy_pct_growth
FROM temp_table
WHERE gender = "ALL" AND
      country_name = "United States of America" AND
      month BETWEEN "2020-03-01" AND "2021-09-01"; 
