# Visualizing OECD Unemployment Rates with #B2VB Community Project

Credit for data collection goes fully to the founders of the #B2VB Tableau Community Project.
Thank you for this amazing dataset (reach it [here](https://data.world/back2vizbasics/2022week-2-dates-line-charts), or in the repo files)!  

## The visualization

The main solution for this challenge in the Tableau Community was using Small Multiples / Trellis Chart.  
With this chart type, one can easily visualize many-many different dimension values in small, stand-on-its-own values.  
For example, instead of a "spaghetti-looking" line chart, the Small Multiples breaks down data to an elegant and digestible format.

This is my attempt to visualize the country-level unemployment data: 
![OECD](https://user-images.githubusercontent.com/96722899/156019399-9efb80c8-4504-46e7-a115-a5ffdb306fbb.png)

Find the interactive on my [Tableau Public profile](https://public.tableau.com/app/profile/norbert.borb.s/viz/UnemploymentinOECDCountries/OECD) with a downloadable workbook.


## A short exploration with SQL

Following a case study logic, I proposed some questions that I wanted the answers for from the data provided.  
>SQL codes to be found under file: **codes.sql**


The dataset has a monthly granularity, thus I wanted to see the big picture first on a yearly level.  
### Question 1: What are the average unemployment rates each year by country (focusing on last 10 years)?
(limited to first 5 record)  
| country_name  | year | avg_rate |
| ------------- | ------------- | ------------- |
| Australia  | 2011 | 5.08 |
| Australia  | 2012  | 5.23  |
| Australia  | 2013 | 5.67  |
| Australia  | 2014  | 6.06  |
| Australia  | 2015  | 6.06 |
...


### Question 2: What are these averages by adding gender? Which is higher?
(limited to first 5 record)  
| country_name  | year | all_avg_rate | male_avg_rate | female_avg_rate | is_male_higher |is_female_higher |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Australia  | 2011 | 5.08 |4.09 |5.3|0|1 |
| Australia  | 2012  | 5.23  |5.17  |5.3  |0  |1 |
| Australia  | 2013 | 5.67  |5.71  |5.62  |1  |0 |
| Australia  | 2014  | 6.06  |5.98 |6.14  |0 |1 |
| Australia  | 2015  | 6.06 |6.03 |6.08 |0 |1 |
...


Now, going back to monthly granularity. We have a bunch of countries, so let's focus only on the USA.  
### Question 3: Is the overall unemployment rate (incl. both women and men) increased or decreased compared to the previous month?
(limited to first 5 record)  
| country_name  | month | avg_rate | previous_avg_rate | is_higher_than_prev_month | 
| ------------- | ------------- | ------------- | ------------- | ------------- | 
| United States of America  | 2011-09-01 | 9 | 9 |0|
| United States of America  | 2011-10-01  | 8.8  |9 |0  |
| United States of America  | 2011-11-01 | 8.6  |8.8  |0  |
| United States of America  | 2011-12-01  | 8.5  |8.6 |0 |
| United States of America  | 2012-01-01  | 8.3 |8.5 |0 |
...

Unemployment rate looks volatile, so let's examine a wider, year-over-year period.  
### Question 4: Is the overall unemployment rate (incl. both women and men) increased or decreased compared to the previous period last year?
(limited to first 5 record)  
| country_name  | month | avg_rate | previous_year_avg_rate | is_higher_than_prev_year | 
| ------------- | ------------- | ------------- | ------------- | ------------- | 
| United States of America  | 2011-09-01 | 9 | 9.5 |0|
| United States of America  | 2011-10-01  | 8.8  | 9.4 |0  |
| United States of America  | 2011-11-01 | 8.6  |9.8  |0  |
| United States of America  | 2011-12-01  | 8.5  |9.3 |0 |
| United States of America  | 2012-01-01  | 8.3 |9.1 |0 |
...

Zooming into the pandemic period. This seems interesting.  
### Question 5: What is the YOY growth percentage of the unemployment rate in the USA during the pandemic period?
(limited to first 5 record)  
| country_name  | month | avg_rate | previous_year_avg_rate | yoy_pct_growth | 
| ------------- | ------------- | ------------- | ------------- | ------------- | 
| United States of America  | 2020-03-01 | 4.4 | 3.8 |16|
| United States of America  | 2020-04-01  | 14.7  | 3.6 |308  |
| United States of America  | 2020-05-01 | 13.2  |3.6  |267 |
| United States of America  | 2020-06-01  | 11  |3.6|206 |
| United States of America  | 2020-07-01  | 10.2 |3.7 |176 |
...


I love SQL, but let's see this data for all of the countries in our dataset.  
I have recreated the above logic to Tableau calculation which is shared below, under "The building process" section.  

## The visualization building process

**Building the Small Multiples**  
- XX
- XX

**Immitating area charts with lines, bars and a shared Y-axis**  
- XX
- XX

**Adding Small Multiple titles aka a workaround with layering**  
- Country Names with layered worksheet 

**Annotations**
- Figma
- Annotation (Alli Torban blog)  

**Colors**
- Color choices
