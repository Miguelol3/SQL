-- For this project, I was exploring a database containing 11 tables with information on invoices, customers, employees and music.
-- The database is titled chinook, and it is part of the 'Break Into Tech Data Analytics Certificate'.

-- #1. Let's look at the quantity of invoices and total amount spent by country
SELECT billingcountry, COUNT(*), ROUND(SUM(total), 2) AS 'Total' FROM chinook.invoices 
GROUP BY 1
ORDER BY 3 DESC;


-- #2. Which year was the most successful in terms of revenue?
SELECT STRFTIME('%Y', invoicedate), COUNT(*), ROUND(SUM(total), 2) AS 'Total' from chinook.invoices
GROUP BY 1
ORDER BY 3 DESC;


-- #3. Which genre was the most sold in 2010?
SELECT
g.name
,SUM(ii.quantity) AS 'Quantity'
,ROUND(SUM(ii.quantity * ii.unitprice), 2) AS 'Total'
FROM chinook.invoice_items AS ii
LEFT JOIN chinook.tracks AS t ON ii.trackid = t.trackid
LEFT JOIN chinook.genres AS g ON t.genreid = g.genreid
WHERE ii.invoiceid IN (SELECT invoiceid FROM chinook.invoices WHERE STRFTIME('%Y', invoicedate) = '2010')
GROUP BY 1
ORDER BY 3 DESC;


-- #4. Which sales agent sold the most in 2011?
SELECT
e.firstname || ' ' || e.lastname AS 'Name'
,COUNT(invoiceid) AS 'Total Invoices'
,ROUND(SUM(i.total), 2) AS 'Total Sales'
FROM chinook.invoices AS i
LEFT JOIN chinook.customers AS c ON i.customerid = c.customerid
LEFT JOIN chinook.employees AS e ON c.supportrepid = e.employeeid
WHERE invoiceid IN (SELECT invoiceid FROM chinook.invoices WHERE STRFTIME('%Y', invoicedate) = '2011')
GROUP BY 1
ORDER BY 3 DESC;
