CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
    IN in_market VARCHAR(45),
    IN in_fiscal_year YEAR,
    OUT out_level VARCHAR(45)
)
BEGIN
    DECLARE quantity INT DEFAULT 0;
    
    -- Set market 
    IF in_market = "" THEN
        SET in_market = "India";
    END IF;

    -- Retrieve total sold quantity for a given market in a given year
    SELECT SUM(fs.sold_quantity) INTO quantity
    FROM fact_sales_monthly fs
    JOIN dim_customer c ON fs.customer_code=c.customer_code
    WHERE get_fiscal_year(fs.date) = in_fiscal_year AND c.market = in_market;

    -- Determine Gold vs Silver status
    IF quantity > 5000000 THEN
        SET out_level = 'Gold';
    ELSE
        SET out_level = 'Silver';
    END IF;
END