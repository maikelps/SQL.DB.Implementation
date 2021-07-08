DROP VIEW head_totals;

Create view head_totals as
Select *, f.subtotal*f.tax_rate as tax, f.subtotal*(1+f.tax_rate) as total
From (Select inv.invoice_id, inv.date_issue, sum(s.quantity_sold*i.item_price) as subtotal, inv.discount, inv.tax_rate, cus.customer_name, cus.customer_adress, ci.city_name, co.country_name
From invoice inv
Join customers cus on inv.client_id = cus.customer_id
Join city ci on cus.customer_city = ci.city_id
Join country co on ci.country_key = co.country_id
Join sales s on inv.invoice_id = s.invoice_number
Join item i on s.sold_item_id = i.item_id
Group by inv.invoice_id) as f;

select * from head_totals;



Create view head_totals as
	Select 
		f.invoice_id, 
        (f.subtotal*f.tax_rate) as tax, 
		f.subtotal*(1+f.tax_rate) as total
	From 
		(Select 
			inv.invoice_id, 
            inv.date_issue, 
			sum(s.quantity_sold*i.item_price) as subtotal, 
			inv.discount, 
			inv.tax_rate, 
			cus.customer_name, 
			cus.customer_adress, 
			ci.city_name, 
			co.country_name
		From invoice inv
		Join customers cus 
			on inv.client_id = cus.customer_id
		Join city ci 
			on cus.customer_city = ci.city_id
		Join country co 
			on ci.country_key = co.country_id
		Join sales s 
			on inv.invoice_id = s.invoice_number
		Join item i 
			on s.sold_item_id = i.item_id
		Group by inv.invoice_id) as f;

# DROP VIEW DETAILS;

Create view details as
	Select 
		inv.invoice_id,
        i.item_name, 
        i.item_price, 
        s.quantity_sold, 
        (i.item_price* s.quantity_sold) as amount
	From invoice inv
	Join sales s on inv.invoice_id = s.invoice_number
	Join item i on s.sold_item_id = i.item_id;

# head_totals
# details
select * from details;

SELECT *
FROM
	head_totals AS H, details AS D
WHERE
	H.invoice_id = D.invoice_id;
    
#-------------------