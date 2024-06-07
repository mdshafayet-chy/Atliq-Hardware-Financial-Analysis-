SELECT 
		fs.date,
        ROUND(SUM(g.gross_price * sold_quantity),2) as gross_monthly_sales
FROM fact_sales_monthly fs
JOIN fact_gross_price g
ON 
	 g.product_code = fs.product_code AND
     g.fiscal_year = get_fiscal_year(fs.date)
WHERE customer_code = 90002002
GROUP BY fs.date
ORDER BY fs.date asc;
