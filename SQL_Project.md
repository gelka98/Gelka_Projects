# Awesome Chocolates SQL Project

## Project Overview

This project involves comprehensive data analysis on the 'Awesome Chocolates' dataset using SQL. The project demonstrates various SQL techniques to extract valuable insights and answer key business questions.

## Project Structure

- `shipment_analysis.sql`: SQL queries to analyze shipment details.
- `sales_performance.sql`: SQL queries to evaluate sales performance.
- `monthly_sales_insights.sql`: SQL queries to analyze monthly sales patterns.
- `employee_data_management.sql`: SQL queries to manage and analyze employee data.

## Key SQL Techniques Demonstrated

- Complex `JOIN` operations to merge data across multiple tables.
- Use of aggregate functions (`SUM`, `COUNT`, `AVG`, `MIN`, `MAX`) to summarize data.
- Conditional statements to categorize and analyze data.
- Date formatting to extract and analyze data based on specific time frames.
- Efficient data updating techniques ensuring data integrity.

## SQL Queries

### Shipment Analysis
```SQL
SELECT * FROM `awesome chocolates`.sales
where amount > 2000 and boxes < 100 ;

**### Sales Performance**
SELECT people.salesperson , people.spid, Count(sales.Amount) as total_shipments from `awesome chocolates`.people
left join `awesome chocolates`.sales
on people.spid = sales.SPID and SaleDate >= '2022-01-01' and SaleDate < '2022-02-01'
group by people.salesperson, people.spid ;

### Product Sales Comparison
SELECT products.pid, products.Product, SUM(sales.boxes) AS total_boxes_sold
FROM `awesome chocolates`.products
INNER JOIN `awesome chocolates`.sales ON products.PID = sales.pid
WHERE sales.PID IN ('P01', 'P06')
GROUP BY products.pid, products.Product
ORDER BY total_boxes_sold DESC;

### Top-Selling Product in Early February
SELECT products.pid, products.Product, SUM(sales.boxes) AS total_boxes_sold
FROM `awesome chocolates`.products
INNER JOIN `awesome chocolates`.sales ON products.PID = sales.pid
WHERE SaleDate >= '2022-02-01' AND SaleDate < '2022-02-08'
GROUP BY products.pid, products.Product
ORDER BY total_boxes_sold DESC
LIMIT 1;

### Small Shipments Analysis
SELECT * FROM `awesome chocolates`.sales
WHERE Customers < 100 AND Boxes < 100;

### Active Salespersons in Early January
SELECT people.Salesperson, people.spid
FROM `awesome chocolates`.people
LEFT JOIN `awesome chocolates`.sales ON people.spid = sales.spid
AND SaleDate >= '2022-01-01' AND SaleDate < '2022-01-08'
WHERE Amount >= 1;

### Inactive Salespersons in Early January
SELECT people.Salesperson, people.spid, COUNT(sales.amount) AS total_shipments
FROM `awesome chocolates`.people
LEFT JOIN `awesome chocolates`.sales ON people.spid = sales.spid
AND SaleDate >= '2022-01-01' AND SaleDate < '2022-01-08'
WHERE sales.spid IS NULL;

### Monthly High Volume Shipments
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS shipment_month, COUNT(*) AS total_shipments_over_1000_boxes
FROM `awesome chocolates`.sales
WHERE Boxes > 1000
GROUP BY DATE_FORMAT(SaleDate, '%Y-%m');

### Shipments After 9 AM
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS sale_date,
SUM(CASE WHEN HOUR(SaleDate) >= 9 THEN 1 ELSE 0 END) AS shipments_after_nine
FROM `awesome chocolates`.sales
WHERE GeoID = 'G4' AND Boxes >= 1
GROUP BY DATE_FORMAT(SaleDate, '%Y-%m');

### Monthly Sales by Country
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS sale_date,
CASE
WHEN GeoID = 'G1' THEN 'India'
WHEN GeoID = 'G5' THEN 'Australia'
END AS country, SUM(boxes) AS total_chocolate_boxes
FROM `awesome chocolates`.sales
WHERE GeoID = 'G1' OR GeoID = 'G5'
GROUP BY DATE_FORMAT(SaleDate, '%Y-%m'), country;

### Employee Data Management
-- Adding a new column
ALTER TABLE employee
ADD COLUMN Job_Designation VARCHAR(20) NOT NULL;

-- Dropping an existing column
ALTER TABLE employee
DROP COLUMN EMPBOD;

-- Renaming columns
ALTER TABLE employee
RENAME COLUMN PrevExperience TO EXPERIENCE;
ALTER TABLE employee
RENAME COLUMN EmpJoiningDate TO HIREDATE;

-- Aggregate functions
SELECT COUNT(EmpName) AS Total_Employee, SUM(salary), AVG(salary), MIN(salary), MAX(salary)
FROM employee
WHERE EXPERIENCE = 10;

-- Updating Job Designations
SET sql_safe_updates = 0;

UPDATE employee
SET Job_Designation = CASE EXPERIENCE
WHEN 1 THEN 'IT'
WHEN 2 THEN 'EXECUTIVE_TRAINEE'
WHEN 3 THEN 'EXECUTIVE_OFFICER'
WHEN 4 THEN 'Snr_Exec_Officer'
WHEN 5 THEN 'Ass_Manager'
WHEN 6 THEN 'MANAGER'
WHEN 7 THEN 'Snr_Manger'
WHEN 8 THEN 'Princpal_Manager'
WHEN 9 THEN 'Ass_Director'
WHEN 10 THEN 'Director'
END;

SET sql_safe_updates = 1;
