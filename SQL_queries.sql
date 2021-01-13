#1-3 create databases and import data.

#4. Select all the data from table house_price_data to check if the data was imported correctly

select * from house_price_regression.house_price_data; #check data
select COUNT(id) from house_price_regression.house_price_data; #check if count matches
select bedrooms from house_price_regression.house_price_data; #check random column 

#5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
#Select all the data from the table to verify if the command worked. 
#Limit your returned results to 10.

ALTER TABLE house_price_regression.house_price_data DROP column `date`;
select * from house_price_regression.house_price_data 
LIMIT 10;

#6. Use sql query to find how many rows of data you have.
select COUNT(id) from house_price_regression.house_price_data; 

#7. Now we will try to find the unique values in some of the categorical columns:

#What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms from house_price_regression.house_price_data;

#What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms from house_price_regression.house_price_data;

#What are the unique values in the column floors?
SELECT DISTINCT floors from house_price_regression.house_price_data;


#What are the unique values in the column condition?
SELECT DISTINCT house_condition from house_price_regression.house_price_data;


#What are the unique values in the column grade?
SELECT DISTINCT grade from house_price_regression.house_price_data;


#8.Arrange the data in a decreasing order by the price of the house. 
#Return only the IDs of the top 10 most expensive houses in your data.
Select id from house_price_regression.house_price_data
order by price DESC 
limit 10;

#9.What is the average price of all the properties in your data?
Select AVG(price) from house_price_regression.house_price_data;

#10.In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

#What is the average price of the houses grouped by bedrooms?
#The returned result should have only two columns, bedrooms and Average of the prices. 
#Use an alias to change the name of the second column.
Select bedrooms, AVG(price) as avg_price 
from house_price_regression.house_price_data
group by bedrooms;

#What is the average sqft_living of the houses grouped by bedrooms? 
#The returned result should have only two columns, bedrooms and Average of the sqft_living. 
#Use an alias to change the name of the second column.
Select bedrooms, AVG(sqft_living) as avg_living_space
from house_price_regression.house_price_data
group by bedrooms
order by bedrooms asc;


select sqft_living from house_price_regression.house_price_data 
order by sqft_living desc; #further exploring data column (not part of question)

select * from house_price_regression.house_price_data
where bedrooms = 33; #whole living space is 6,000 #checking in on the house with the most rooms to determine if its bad data.

#What is the average price of the houses with a waterfront and without a waterfront?
#The returned result should have only two columns, waterfront and Average of the prices. 
#Use an alias to change the name of the second column.

select AVG(price) as avg_price, waterfront from house_price_regression.house_price_data hpd house_price_data

#Is there any correlation between the columns condition and grade?
#You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column.
#Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select house_condition, SUM(grade) as sum_grade from house_price_regression.house_price_data
group by house_condition
order by SUM(grade) desc;


#11.One of the customers is only interested in the following houses:

#Number of bedrooms either 3 or 4
#Bathrooms more than 3
#One Floor
#No waterfront
#Condition should be 3 at least
#Grade should be 5 at least
#Price less than 300000
#For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

select id from house_price_regression.house_price_data where bedrooms in (3,4)
and bathrooms > 3 
and floors = 1
and waterfront = 0
and house_condition >= 3
and grade >= 5
and price in (select price from house_price_regression.house_price_data where price >= 300000);



#12.Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
#Write a query to show them the list of such properties. You might need to use a sub query for this problem.


select id, price from house_price_regression.house_price_data
where price >=
(select avg(price) * 2 from
house_price_regression.house_price_data)
order by price asc;


#13.Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW doule_price AS 
select id, price from house_price_regression.house_price_data
where price >=
(select avg(price) * 2 from
house_price_regression.house_price_data)
order by price asc;

#14.Most customers are interested in properties with three or four bedrooms. 
#What is the difference in average prices of the properties with three and four bedrooms?

select bedrooms, avg(price) as avg_price
from house_price_regression.house_price_data
where bedrooms in (3, 4)
group by bedrooms;

#15.What are the different locations where properties are available in your database? (distinct zip codes)
select DISTINCT zipcode from house_price_regression.house_price_data;

#16.Show the list of all the properties that were renovated.
select id from house_price_regression.house_price_data
where yr_renovated > 0;

#17.Provide the details of the property that is the 11th most expensive property in your database.

with cte_expensive_properties as (
select *
from house_price_regression.house_price_data
order by price DESC
LIMIT 11
)
select *
from cte_expensive_properties
order by price ASC
LIMIT 1;


#extra queries to help with visualisation/binning for model
select * from house_price_regression.house_price_data 
where floors = 4;

Select AVG(bedrooms) from house_price_regression.house_price_data;
