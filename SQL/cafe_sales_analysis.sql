/*
Analüüsimiseks:
- tooted koguse järgi (kõ5ige populaarsemad tooted)
- tooted müügisumma järgi
- asukoha järgi müügisummad
- müügisumma aasta ja kuu lõikes 
*/

SELECT item_cleaned, SUM(quantity) AS total_quantity 
FROM cafe_sales_cleaned 
GROUP BY item_cleaned
ORDER BY total_quantity DESC;

SELECT item_cleaned, SUM(total_spent_calc) AS SaleSum
FROM cafe_sales_cleaned 
GROUP BY item_cleaned
ORDER BY saleSum DESC;

SELECT location_cleaned, SUM(total_spent_calc) AS SaleSum
FROM cafe_sales_cleaned 
GROUP BY location_cleaned
ORDER BY saleSum DESC;

SELECT
	SUBSTR(transaction_date, 1, 4) AS Year
    ,SUBSTR(transaction_date, 6, 2) AS Month
    ,SUM(total_spent_calc) AS SaleSum
FROM cafe_sales_cleaned
GROUP BY Year, Month
ORDER BY Year, Month;