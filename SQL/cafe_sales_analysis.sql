{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 /* \
Anal\'fc\'fcsimiseks: \
- tooted koguse j\'e4rgi (k\'f5ige populaarsemad tooted)\
- tooted m\'fc\'fcgisumma j\'e4rgi \
- asukoha j\'e4rgi m\'fc\'fcgisummad \
- m\'fc\'fcgisumma aasta ja kuu l\'f5ikes \
*/\
\
SELECT item_cleaned, SUM(quantity) AS total_quantity \
FROM cafe_sales_cleaned \
GROUP BY item_cleaned\
ORDER BY total_quantity DESC;\
\
SELECT item_cleaned, SUM(total_spent_calc) AS SaleSum\
FROM cafe_sales_cleaned \
GROUP BY item_cleaned\
ORDER BY saleSum DESC;\
\
SELECT location_cleaned, SUM(total_spent_calc) AS SaleSum\
FROM cafe_sales_cleaned \
GROUP BY location_cleaned\
ORDER BY saleSum DESC;\
\
SELECT\
	SUBSTR(transaction_date, 1, 4) AS Year\
    ,SUBSTR(transaction_date, 6, 2) AS Month\
    ,SUM(total_spent_calc) AS SaleSum\
FROM cafe_sales_cleaned\
GROUP BY Year, Month\
ORDER BY Year, Month;}