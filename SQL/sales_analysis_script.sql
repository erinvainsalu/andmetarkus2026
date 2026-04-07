
-- Lisame uue veeru sales tabelisse, mis sisaldab müügisummat
ALTER TABLE sales_table 
ADD sales_sum NUMERIC;

update sales_table st set sales_sum = st.quantity * st.unit_price * (1 - st.discount)

select * from sales_table st 

-- 1. Leia müügisummad toodete kaupa – toote ID ja müügisumma
select
	st.product_id 
	,round(sum(st.sales_sum),2) as sales_sum
from sales_table st
group by st.product_id 
order by st.product_id 

-- 2. Leia müügisummad klientide kaupa – kliendi ID ja müügisumma
select
	st.customer_id
	,round(sum(st.sales_sum),2) as sales_sum
from sales_table st
group by st.customer_id 
order by st.customer_id 

-- 3. Leia müügisummad müügiesindajate kaupa – kliendiesindaja ID ja müügisumma
select
	st.sales_rep_id 
	,round(sum(st.sales_sum),2) as sales_sum
from sales_table st
group by st.sales_rep_id 
order by st.sales_rep_id

-- 4. Leia müügisummad aastate kaupa – aasta ja müügisumma
select
	date_part('year',st."date") as year
	,round(sum(st.sales_sum),2) as sales_sum
from sales_table st
group by year
order by year

-- 5. Lisa müükidele müügisumma kategooriad
	-- Large Sale > 500
	-- Medium Sale <= 500 and >= 250
	-- Small Sale < 250
select *
	,case
		when st.sales_sum > 500 then 'Large Sale'
		when st.sales_sum <= 500 and st.sales_sum >= 250 then 'Medium Sale'
		when st.sales_sum < 250 then 'Small Sale'
		else 'ERROR'
	end as sale_category
from sales_table st 

select
	case
		when st.sales_sum > 500 then 'Large Sale'
		when st.sales_sum <= 500 and st.sales_sum >= 250 then 'Medium Sale'
		when st.sales_sum < 250 then 'Small Sale'
		else 'ERROR'
	end as sale_category
	,count(st.sale_id) as sales_count
	,sum(st.sales_sum) as sales_sum
from sales_table st 
group by sale_category

-- Alternatiivne lahendus ajutise päringu abil
with category as (
	select
	case
		when st.sales_sum > 500 then 'Large Sale'
		when st.sales_sum <= 500 and st.sales_sum >= 250 then 'Medium Sale'
		when st.sales_sum < 250 then 'Small Sale'
		else 'ERROR'
	end as sale_category_new
	,st.sale_id
	,st.sales_sum
	from sales_table st 	
)
select
	c.sale_category_new
	,count(c.sale_id) as sales_count
	,sum(c.sales_sum) as sales_sum
from category c
group by c.sale_category_new

-- Leia müükide arv ja müügisumma kategooriate kaupa - Müügisumma kategooria, müükide arv, müügisumma
-- Lisa kategooria tulp müükide tabelisse
ALTER TABLE sales_table 
ADD sales_category VARCHAR(50)

update sales_table st set sales_category =
case
	when st.sales_sum > 500 then 'Large Sale'
	when st.sales_sum <= 500 and st.sales_sum >= 250 then 'Medium Sale'
	when st.sales_sum < 250 then 'Small Sale'
	else 'ERROR'
end

select
	st.sales_category
	,count(st.sale_id) as sales_count
	,sum(st.sales_sum) as sales_sum
from sales_table st 
group by st.sales_category

-- Mida veel võiks leida?

-- Leia müügisummad aastate ja kuude kaupa – aasta ja müügisumma
select
	date_part('year',st."date") as year
	,date_part('month',st."date") as month
	,round(sum(st.sales_sum),2) as sales_sum
from sales_table st
group by year, month
order by year, month

-- Leian min, max, avg allahindlus müügiesindaja kaupa + keskmise üle ettevõtte
select 
	srt.sales_rep_id 
	,min(st.discount) as min_discount
	,max(st.discount) as max_discount
	,avg(st.discount) as avg_discount
	,(select avg(discount) as avg_discount_in_company from sales_table st2)
	,avg(st.discount) - (select avg(discount) as avg_discount_in_company from sales_table st2) as difference_from_company_average
from sales_rep_table srt 
	left join sales_table st on srt.sales_rep_id = st.sales_rep_id 
group by srt.sales_rep_id

-- Leian müügisumma ja eelarve müügiesindaja kaupa
select 
	srt.sales_rep_id
	,sum(st.sales_sum) as sales_sum
	,(select bt.budget from budget_table bt where srt.sales_rep_id = bt.sales_rep_id )
from sales_rep_table srt 
	left join sales_table st on srt.sales_rep_id = st.sales_rep_id 
group by srt.sales_rep_id

-- versioon 2
with sales_rep_budget as (
	select 
		st.sales_rep_id
		,sum(st.sales_sum) as sales_sum
	from sales_table st  
	group by st.sales_rep_id
)
select 
	sales_rep_budget.sales_rep_id
	,sales_rep_budget.sales_sum
	,bt.budget 
from sales_rep_budget
	left join budget_table bt on sales_rep_budget.sales_rep_id = bt.sales_rep_id 

-- Leian quantity veeru andmete jaotuse
select
	st.quantity
	,count(st.sale_id) as count_qty
from sales_table st 
group by st.quantity
order by count_qty

-- Leian toote hinna min, max ja keskmise
select 
	st.product_id 
	,min(st.unit_price) as min_price
	,max(st.unit_price) as max_price
	,round(avg(st.unit_price), 2) as avg_price
from sales_table st
group by st.product_id