-- Saime juhatuselt uued eelarvenumbrid ja loome uue eelarve tabeli nende numbritega
create table budget_table_new (
	budget_id serial not null primary key,
	budget_date date,
	sales_rep_name varchar(255),
	budget_sum numeric(50,2)
)

insert into budget_table_new
(budget_date, sales_rep_name, budget_sum)
values ('2026-01-31', 'Jane Smith', 2000),
('2026-01-31', 'John Doe', 2000)

select * from budget_table_new btn 

-- Lisa müügiesindaja ID tulp
alter table budget_table_new 
add sales_rep_id varchar(50)

update budget_table_new 
set sales_rep_id = 'SR001' where sales_rep_name = 'Jane Smith'

update budget_table_new 
set sales_rep_id = 'SR002' where budget_id = (select budget_id from budget_table_new btn where sales_rep_name = 'John Doe')

-- Eemalda müügiesindaja nime tulp
alter table budget_table_new 
drop sales_rep_name

-- Kustuta tabel
drop table budget_table_new 