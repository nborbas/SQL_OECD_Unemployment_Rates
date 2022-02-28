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


The dataset has a monthly granularity, thus I wanted to see the big picture first on a yearly level.  
**What are the average unemployment rates each year by country?**
```
XXX
```

**What are these averages by adding gender?**
```
XXX
```

Now, going back to monthly granularity. We have a bunch of countries, so let's focus only on the USA.  
**Is the overall unemployment rate (incl. both women and men) increased or decreased compared to the previous month?**
```
XXX
```

Unemployment rate looks volatile, so let's examine a wider, year-over-year period.  
**Is the overall unemployment rate (incl. both women and men) increased or decreased compared to the previous period last year?**
```
XXX
```

Zooming into the pandemic period. This seems interesting.  
**What is the YOY growth percentage of the unemployment rate in the USA during the pandemic period?**
```
XXX
```


I love SQL, but let's see this data for all of the countries in our dataset.  
I have recreated the above logic to Tableau calculation which is shared below, under "The building process" section.  

## The building process

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
