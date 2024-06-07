#Generate a yearly report for Croma India where there are two columns
#1. Fiscal Year
#2. Total Gross Sales amount In that year from Croma
#3. Yearly total sales

SELECT 
		get_fiscal_year(date) AS fiscal_year,
        ROUND(SUM(sold_quantity),2) AS yearly_sold_qnty,
        ROUND(SUM(sold_quantity*g.gross_price), 2) AS yearly_sales
FROM fact_sales_monthly fs
JOIN fact_gross_price g
ON 
	 g.fiscal_year = get_fiscal_year(fs.date)  AND
     g.product_code = fs.product_code
WHERE 
	customer_code  = 90002002
GROUP BY get_fiscal_year(date)
ORDER BY fiscal_year;
