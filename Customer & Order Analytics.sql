-- For this project, I queried a database that contains 6 tables with information on (1) customers and (2-6) monthly sales from January to May.
-- The tables contained blank/incorrect/messy data for some columns, and for this reason most queries filter them out.

#1 - How many orders were placed in January? 
SELECT COUNT(orderID) FROM bit_db.JanSales
WHERE LENGTH(orderID) = 6 
AND orderID <> 'Order ID';

#2 - How many of those orders were for an iPhone?
SELECT COUNT(*) FROM bit_db.JanSales
WHERE product = 'iPhone'
AND LENGTH(orderID) = 6
AND orderID <> 'Order ID';

#3 - Select the customer account numbers for all the orders that were placed in February.
SELECT distinct (c.acctnum)
FROM bit_db.customers AS c
INNER JOIN bit_db.FebSales AS fs ON c.order_id = fs.orderID
WHERE LENGTH(fs.orderid) = 6
AND fs.orderid <> 'Order ID';

#4 - Which product was the cheapest one sold in January, and what was the price?
SELECT distinct (product), price
FROM bit_db.JanSales
WHERE price IN (SELECT MIN(price) FROM bit_db.JanSales WHERE price <> 'Price Each' AND price <> '');

#5 - What is the total revenue for each product sold in January?
SELECT product, ROUND((SUM(quantity)*price), 2) AS 'Product Revenue'
FROM bit_db.JanSales
WHERE price <> 'Price Each' AND price <> '' AND product <> 'Product'
GROUP BY 1
ORDER BY 2 DESC;

#6 - Which products were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, and what was the total revenue?
SELECT 
  product
  ,SUM(quantity) AS 'Quantity Sold'
  ,ROUND((SUM(quantity)*price), 2) AS 'Revenue'
FROM bit_db.FebSales 
WHERE location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY 1;

#7 - How many customers ordered more than 2 products at a time in February, and what was the average amount spent for those customers?
SELECT
  COUNT(distinct acctnum)
  ,AVG(fs.quantity * fs.price) AS 'AVG Amount Spent'
FROM bit_db.customers AS c
INNER JOIN bit_db.FebSales AS fs ON c.order_id = fs.orderID
WHERE fs.quantity > 2
AND LENGTH(fs.orderID) = 6
AND fs.orderID <> 'Order ID';
