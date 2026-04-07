/*
Taust:
transaction_id - unikaalne, primary key 
item - müüdud tooted, kõik mittevaliidsed tooted on UNKNOWN 
quantity - täisarv, kui ei ole täisarv, siis on vigased read ja tuleb eemaldada 
unit_price - komakohaga arv, kui on puudu, tekst vms, siis tuleb read eemaldada 
total_spent - komakohaga arv, quantity * unit_price, kui total_spent ei võrdu arvutusega, siis tuleb luua uus arvutatud veerg 
payment_method - tekst, mittevaliidsed read UNKNOWN 
location - tekst, mittevaliidsed read UNKNOWN 
transaction_date - kuupäev, kui ei ole kuupäev, siis read eemaldada
*/

-- This is cafe sales data from sales management system. This query checks data quality and fixes errors. In the end, cleaned table is selected as an output.
-- 1. Check transaction_id column
-- 1.1 Check uniqueness of transaction ID 
SELECT COUNT(transaction_id) - COUNT(DISTINCT transaction_id) AS difference
FROM cafe_sales;

-- Find the rows which are not unique
SELECT transaction_id, COUNT(*) as transaction_count
FROM cafe_sales
GROUP BY transaction_ID
HAVING transaction_count > 1;

-- 1.2. Check the length of transaction_id column
SELECT DISTINCT LENGTH(transaction_id)
FROM cafe_sales;

-- 2. Check item column
-- 2.1. Check the values in the column 
SELECT DISTINCT item 
FROM cafe_sales;

-- Count rows by products to find rows with typing errors etc
SELECT item, COUNT(*) as item_count
FROM cafe_sales
GROUP BY item
ORDER BY item_count;

-- 2.2. Create a new column in output called item_cleaned where NULL and ERROR for item column are replaced with UNKNOWN, select distinct values from item and the new column
SELECT DISTINCT item, 
    CASE
    	WHEN UPPER(item) = 'ERROR' OR item IS NULL THEN 'UNKNOWN'
        ELSE item
    END AS item_cleaned
FROM cafe_sales;

-- 3. Check quantity column
-- 3.1 Check if quantity is a whole number
SELECT *
FROM cafe_sales
WHERE quantity % 1 <> 0;

-- 3.2 Check quantity column values
SELECT quantity, COUNT(*) as quantity_count
FROM cafe_sales
GROUP BY quantity
ORDER BY quantity_count;

-- 4. Check the unit price column
-- 4.1. Check the values in the column 
SELECT DISTINCT unit_price 
FROM cafe_sales;

-- 4.2 Check MIN and MAX prices
SELECT MIN(unit_price), MAX(unit_price)
FROM cafe_sales;

-- 4.3 Check price data types
SELECT DISTINCT unit_price, typeof(unit_price)
FROM cafe_sales
WHERE typeof(unit_price) != 'real';

SELECT distinct unit_price, cast(unit_price as decimal)
from cafe_sales
where unit_price != cast(unit_price as decimal) OR unit_price is null;

-- 4.4 Select rows where unit_price is decimal number
SELECT * 
FROM cafe_sales
WHERE typeof(unit_price) = 'real';

-- 4.5. Create a new column unit_price_clean and select only rows where unit price is a valid number
SELECT transaction_id, 
    CASE
    	WHEN UPPER(item) = 'ERROR' OR item IS NULL THEN 'UNKNOWN'
        ELSE item
    END AS item_cleaned
    ,quantity
FROM cafe_sales
WHERE typeof(unit_price) = 'real';

-- 5. Check the total_spent column
-- 5.1. Check the values in the column, if they are a decimal number
SELECT distinct total_spent 
from cafe_sales;

SELECT DISTINCT total_spent, typeof(total_spent)
FROM cafe_sales
WHERE typeof(total_spent) != 'real';

-- 5.2 Calculate new column total_spent_calc based on quantity and unit_price
SELECT
	transaction_id
    ,item
    ,quantity * unit_price AS total_spent_calc
FROM cafe_sales
WHERE TYPEOF(unit_price) = 'real';

SELECT transaction_id, 
    CASE
    	WHEN UPPER(item) = 'ERROR' OR item IS NULL THEN 'UNKNOWN'
        ELSE item
    END AS item_cleaned
    ,quantity
    ,unit_price
    ,quantity * unit_price AS total_spent_calc
FROM cafe_sales
WHERE typeof(unit_price) = 'real';

-- 6. Check the payment_method column
-- 6.1. Check the values in the column 
SELECT DISTINCT payment_method
FROM cafe_sales;

-- Count rows by payment_method to find rows with typing errors etc
SELECT payment_method, COUNT(*) AS nr_of_rows
FROM cafe_sales
GROUP BY payment_method
ORDER BY nr_of_rows;

-- 6.2. Create a new column in output called payment_method_clean where NULL and ERROR for payment_method column are replaced with UNKNOWN, select distinct values from the new column
SELECT DISTINCT payment_method, 
    CASE
    	WHEN UPPER(payment_method) = 'ERROR' OR payment_method IS NULL THEN 'UNKNOWN'
        ELSE payment_method
    END AS payment_method_cleaned
FROM cafe_sales;

SELECT transaction_id, 
    CASE
    	WHEN UPPER(item) = 'ERROR' OR item IS NULL THEN 'UNKNOWN'
        ELSE item
    END AS item_cleaned
    ,quantity
    ,unit_price
    ,quantity * unit_price AS total_spent_calc
    ,CASE
    	WHEN UPPER(payment_method) = 'ERROR' OR payment_method IS NULL THEN 'UNKNOWN'
        ELSE payment_method
    END AS payment_method_cleaned
FROM cafe_sales
WHERE typeof(unit_price) = 'real';

-- 7. Check the location column
-- 7.1. Check the values in the column 
SELECT DISTINCT location 
FROM cafe_sales;

-- Count rows by location to find rows with typing errors etc
SELECT location, COUNT(*) AS nr_of_rows
FROM cafe_sales
GROUP BY location
ORDER BY nr_of_rows;

-- 7.2. Create a new column in output called location_clean where NULL and ERROR for location column are replaced with UNKNOWN, select distinct values from the new column
SELECT DISTINCT location, 
    CASE
    	WHEN UPPER(location) = 'ERROR' OR location IS NULL THEN 'UNKNOWN'
        ELSE location
    END AS location_cleaned
FROM cafe_sales;

SELECT transaction_id, 
    CASE
    	WHEN UPPER(item) = 'ERROR' OR item IS NULL THEN 'UNKNOWN'
        ELSE item
    END AS item_cleaned
    ,quantity
    ,unit_price
    ,quantity * unit_price AS total_spent_calc
    ,CASE
    	WHEN UPPER(payment_method) = 'ERROR' OR payment_method IS NULL THEN 'UNKNOWN'
        ELSE payment_method
    END AS payment_method_cleaned
    ,CASE
    	WHEN UPPER(location) = 'ERROR' OR location IS NULL THEN 'UNKNOWN'
        ELSE location
    END AS location_cleaned
FROM cafe_sales
WHERE typeof(unit_price) = 'real';

-- 8. Check the transaction_date column
-- 8.1 Check for min and max values 
SELECT MIN(transaction_date), MAX(transaction_date) 
FROM cafe_sales;

-- 8.1. Check the values in the column 
SELECT transaction_date, COUNT(*) AS nr_of_rows
FROM cafe_sales
GROUP BY transaction_date
ORDER BY nr_of_rows;

SELECT DISTINCT transaction_date 
FROM cafe_sales 
ORDER BY transaction_date DESC;

-- 8.2. Check for values that are not valid dates
SELECT DISTINCT transaction_date, DATE(transaction_date) 
FROM cafe_sales 
WHERE DATE(transaction_date) IS NULL
	OR transaction_date != DATE(transaction_date);

-- 8.3. Select only rows with valid dates 
SELECT * 
FROM cafe_sales
WHERE DATE(transaction_date) IS NOT NULL AND transaction_date = DATE(transaction_date);

-- 9. Put all the steps together and create a cleaned output 
SELECT transaction_id 
    ,CASE
    	WHEN UPPER(item) = 'ERROR' OR item IS NULL THEN 'UNKNOWN'
        ELSE item
    END AS item_cleaned
    ,quantity
    ,unit_price
    ,quantity * unit_price AS total_spent_calc
    ,CASE
    	WHEN UPPER(payment_method) = 'ERROR' OR payment_method IS NULL THEN 'UNKNOWN'
        ELSE payment_method
    END AS payment_method_cleaned
    ,CASE
    	WHEN UPPER(location) = 'ERROR' OR location IS NULL THEN 'UNKNOWN'
        ELSE location
    END AS location_cleaned
    ,transaction_date
FROM cafe_sales
WHERE typeof(unit_price) = 'real'
	AND DATE(transaction_date) IS NOT NULL 
    AND transaction_date = DATE(transaction_date);
\
-- Create table
CREATE TABLE cafe_sales_cleaned AS
SELECT transaction_id 
    ,CASE
    	WHEN UPPER(item) = 'ERROR' OR item IS NULL THEN 'UNKNOWN'
        ELSE item
    END AS item_cleaned
    ,quantity
    ,unit_price
    ,quantity * unit_price AS total_spent_calc
    ,CASE
    	WHEN UPPER(payment_method) = 'ERROR' OR payment_method IS NULL THEN 'UNKNOWN'
        ELSE payment_method
    END AS payment_method_cleaned
    ,CASE
    	WHEN UPPER(location) = 'ERROR' OR location IS NULL THEN 'UNKNOWN'
        ELSE location
    END AS location_cleaned
    ,transaction_date
FROM cafe_sales
WHERE typeof(unit_price) = 'real'
	AND DATE(transaction_date) IS NOT NULL 
    AND transaction_date = DATE(transaction_date);