# STRATEGIC 1
SELECT date_dim.month_name, SUM(purchase_fact.purchase_revenue)
FROM purchase_fact
JOIN date_dim
	ON purchase_fact.SALEDATE=date_dim.date
	WHERE date_dim.year = 2005 AND(date_dim.month_name='April' OR date_dim.month_name='May' OR date_dim.month_name ='June')
	GROUP BY date_dim.month_name;
        
# STRATEGIC 2
SELECT date_dim.month_name, SUM(purchase_fact.purchase_quantity)
FROM purchase_fact
JOIN date_dim
	ON purchase_fact.SALEDATE=date_dim.date
    WHERE date_dim.year = 2005 AND(date_dim.month_name='April' OR date_dim.month_name='May' OR date_dim.month_name ='June')
    GROUP BY date_dim.month_name;
    
# STRATEGIC 3
SELECT date_dim.month_name, SUM(purchase_fact.purchase_profit)
FROM purchase_fact
JOIN date_dim
	ON purchase_fact.SALEDATE=date_dim.date
	WHERE date_dim.year = 2005 AND(date_dim.month_name='April' OR date_dim.month_name='May' OR date_dim.month_name ='June')
    GROUP BY date_dim.month_name;
    
# OPERATIONAL 1
SELECT date_dim.date, AVG(purchase_fact.purchase_revenue)
FROM purchase_fact
JOIN date_dim
	ON purchase_fact.SALEDATE=date_dim.date
	JOIN stores_dim
		ON purchase_fact.STORE=stores_dim.STORE
		WHERE date_dim.year = 2005 AND stores_dim.STATE="TX" AND date_dim.date BETWEEN '2005-04-01' AND '2005-04-30'
		GROUP BY date_dim.date;
            
# OPERATIONAL 2
SELECT purchase_fact.SALEDATE, SUM(purchase_fact.purchase_quantity)
FROM purchase_fact
JOIN sku_dim
	ON sku_dim.SKU=purchase_fact.SKU
	WHERE purchase_fact.SALEDATE BETWEEN '2005-04-07' AND '2005-04-14' AND sku_dim.DEPTDESC = 'ESPRIT'
	GROUP BY purchase_fact.SALEDATE;

# OPERATIONAL 3
SELECT STORE, SUM(purchase_revenue)
FROM purchase_fact
WHERE SALEDATE BETWEEN '2005-04-01' AND '2005-04-30'
GROUP BY STORE
ORDER BY SUM(purchase_revenue) ASC
LIMIT 5;

# ANALYTICAL 1
SELECT SKU, SUM(purchase_quantity)
FROM purchase_fact
WHERE SALEDATE BETWEEN '2005-05-07' AND '2005-05-14'
GROUP BY SKU
ORDER BY SUM(purchase_quantity) DESC
LIMIT 10;

# ANALYTICAL 2
SELECT sku_dim.DEPT, stores_dim.CITY, SUM(purchase_fact.purchase_revenue)
FROM purchase_fact
JOIN sku_dim
	ON sku_dim.SKU=purchase_fact.SKU
    JOIN stores_dim
		ON stores_dim.STORE=purchase_fact.STORE
		WHERE purchase_fact.SALEDATE BETWEEN '2004-12-01' AND '2004-12-31'
		GROUP BY sku_dim.DEPT, stores_dim.CITY
		ORDER BY SUM(purchase_fact.purchase_revenue) DESC
		LIMIT 3; 

# ANALYTICAL 3
SELECT date_dim.day_of_week_name, SUM(returns_fact.return_quantity)
FROM returns_fact
JOIN date_dim
	ON date_dim.date=returns_fact.SALEDATE
    WHERE date_dim.month_name = 'June' AND date_dim.year='2005'
    GROUP BY date_dim.day_of_week_name
    ORDER BY date_dim.day_of_week;