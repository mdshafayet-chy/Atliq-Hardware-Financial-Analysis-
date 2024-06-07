#SELECT customer_code FROM dim_customer WHERE customer LIKE "%croma" ; #90002002

SELECT 
		date,fs.product_code, p.product AS product_name , p.variant , fs.sold_quantity, 
        ROUND(g.gross_price,2) AS gross_price, 
        ROUND(g.gross_price*fs.sold_quantity,2) AS gross_price_totall
FROM  fact_sales_monthly fs
JOIN dim_product p 
ON fs.product_code = p.product_code
JOIN fact_gross_price g
ON fs.product_code = g.product_code AND 
   g.fiscal_year = get_fiscal_year(fs.date)
WHERE 
	customer_code = 90002002 AND
    get_fiscal_year(date) = 2021
ORDER BY date DESC