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
The chart is built based on Andy Kriebel's video: [LINK](https://www.youtube.com/watch?v=6_oMj9sKILQ)  
This diagram divides the view into a "matrix", based on the column and row numbers provided in the formula.  
Andy's formula creates the number of colummns and rows based on our available data/view and here is how these 2 calculations are structured:

```
// Column
(INDEX()-1)%(ROUND(SQRT(SIZE())))
```
```
// Row
INT((INDEX()-1)/(ROUND(SQRT(SIZE()))))
```

**Immitating area charts with lines, bars and a shared Y-axis**  
Area charts are great in Tableau, but you cannot apply date-based coloring to the view, meaning, that you can only use 1 color to the whole area.  
Thankfully, there is a workaround to this: using a bar chart with a line chart (or just using its markers).  
Here is how my Columns and Rows Shelf looks like:  
![image](https://user-images.githubusercontent.com/96722899/156333484-496f8207-b026-4106-8814-b16284982569.png)

Steps:
- Use put the same measure twice on the Rows shelf
- Set Dual Axis, by right-clicking the second measure
- Do not forget to synchronize the axes!

Now you are able to apply date-based coloring separately to the bar and the line chart which imitates the original area chart idea.

**Adding Small Multiple titles aka a workaround with layering**  
As I played the double axis card with the area chart immitation, I was not able to add the Country Names in the "standard', Trellis way. (Which is using the same dual axis logic as above, but instead using a constant line for which the Country Name is put on the Text mark.)  

My idea here was to duplicate the original worksheet and clear the original "area chart" and instead add the constant line on a dual axis like described above in brackets.  
Then this clear worksheet containing the only the Country Names can be **layered** under the original worksheet.

To check how it works, feel free to download the workbook and check how the dashboard is built up.

**Annotations**  
Titles, text etc., as usually in my recent visualizations, are created in [Figma](https://figma.com/).  
Although, for the in-chart annotations in this visualization were created by Tableau's Point Annotation functionality.  

I would like to mention here the podcast by Alli Torban, Data Viz Today, where an episode was devoted to how to annotate efficiently.  
Here you can find the Show Notes for this episode: [LINK](https://dataviztoday.com/shownotes/07)  

Learning from this podcast, I decided to highlight few of the largest growths in YOY unemployment rate changes which highlight how the pandemic put an end to a trend of 10-years decrease or constant low level of unemployment rates.

Examples include USA and Canada as seen in this snippet:  
![image](https://user-images.githubusercontent.com/96722899/156344883-969ab7ef-1b35-4e36-a5c7-4fd15c2bf3d2.png)

*Thank you for reading!*
