CREATE DATABASE  IF NOT EXISTS `mahendra` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mahendra`;

-- KPIs
	-- 1. TOTAL INVENTORY
SELECT SUM(`Quantity on Hand`) AS TOTAL_INVENTORY
FROM f_inventory_adjusted; 
	-- 2. TOTAL SALES
SELECT SUM(`Sales Amount`) AS TOTAL_SALES
FROM point_of_sale;
	-- 3. INVENTORY VALUE
SELECT 
	ROUND(
    SUM((`Cost Amount`)*(`Sales Quantity`))*100
    , 2 ) AS INVENTORY_VALUE
FROM point_of_sale;
	-- 4. Average Order Value [AOV]
SELECT 
    ROUND(SUM(`Sales Amount`) / COUNT(DISTINCT `Order Number`), 2) AS Average_Order_Value
FROM point_of_sale;




	-- 5. Inventory TurnOver
SELECT 
	CONCAT(
		ROUND(
			(SUM(pos.`Cost Amount`) / AVG(i.`Quantity on Hand`)) / 1000000, 2), ' M'
		) AS Inventory_Turnover
FROM point_of_sale pos
JOIN f_inventory_adjusted i ON pos.`Product Key` = i.`Product Key`;
	-- 6. PROFIT MARGIN
SELECT 
	ROUND(
    (SUM(`Sales Amount` - `Cost Amount`) / SUM(`Sales Amount`)) * 100 
    ,2) AS PROFIT_MARGIN
FROM point_of_sale;
	-- 7. Product Type Sales Share (%)
SELECT 
    p.`Product Type`, 
    ROUND(
        (SUM(pos.`Sales Amount`) / 
        (SELECT SUM(`Sales Amount`) FROM point_of_sale)) * 100, 2
    ) AS Percentage_Contribution
FROM 
    point_of_sale pos
JOIN 
    product p ON pos.`Product Key` = p.`Product Key`
GROUP BY 
    p.`Product Type`
ORDER BY 
    Percentage_Contribution DESC;
	-- 8. Total Employess on each region
SELECT 
    s.`Store Region`, 
    SUM(s.`Number of Employees`) AS Total_Employees
FROM d_store s
GROUP BY 
    s.`Store Region`
ORDER BY Total_Employees DESC;
