--show total sales for every subcategory and cumulative total of subcategory in its category.
--add column % of subcategory sales in relation to a whole category sales total.

select 
*, 
sum(sub_sum) over (partition by category ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT row) as cumulative_sum,
round(sub_sum / sum(sub_sum) over (partition by category) * 100, 1) as "sales % in category"
from (
	select distinct on (subcategory)
	category,
	subcategory,
	sum(sales) as sub_sum
	from orders
	group by category, subcategory, sales
) as new_t
group by new_t.category, new_t.subcategory, new_t.sub_sum



--show total sales for every product and cumulative total of products in its category.
--add column % of product sales in relation to a whole category sales total.

select 
*, 
sum(sub_sum) over (partition by category ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT row) as cumulative_sum,
round(sub_sum / sum(sub_sum) over (partition by category) * 100, 2) as "sales % in category"
from (
	select distinct on (product_name)
	category,
	subcategory,
	product_name,
	sum(sales) as sub_sum
	from orders
	group by category, subcategory, sales, product_name 
) as new_t
group by new_t.category, new_t.subcategory, new_t.sub_sum, new_t.product_name 


