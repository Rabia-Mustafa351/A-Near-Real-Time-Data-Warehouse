SELECT * FROM metro_dwh.transactions;
-- Q1
SELECT  l.StoreName,t.StoreId,SUM(t.Sales) FROM metro_dwh.transactions t  
INNER JOIN location l
Where t.timeId in( SElect idTime FROM metro_dwh.time where t_month=9 and year=2017 )
and t.StoreId=l.id_Store
 GROUP BY StoreId
ORDER BY  SUM(t.Sales) DESC LIMIT 3;

-- Q2. Find Top 10 suppliers that generated most revenue over the weekends. Just Explain how 
-- can we forecast the top suppliers for the next weekend?
SELECT s.supplierName ,sum(Sales) AS revenue  FROM metro_dwh.transactions ts, time t,supplier s
where ts.timeId in (Select idTime FROM metro_dwh.time where day=6 or day=7)
and  ts.supplierID=s.idSupplier
and  t.idTime=ts.timeId
group by  supplierID 
ORDER BY  revenue DESC LIMIT 10;

-- Q3. Present total sales of all products supplied by each supplier with respect to t_Quarter and t_month
select s.supplierName, t.t_Quarter as Quaters, t.t_month as Months, sum(ts.sales) as TotalSales 
from metro_dwh.transactions ts, supplier s, time t 
where ts.supplierID = s.idSupplier 
and ts.timeId = t.idTime  
group by s.supplierName, t.t_Quarter, t.t_month 
order by s.supplierName, t.t_Quarter;

--  Q4. Present total sales of each product sold by each store. The output should be organised 
-- store wise and then product wise under each store
SELECT StoreId,productId, sum(Sales) FROM metro_dwh.transactions GROUP BY StoreId,productId
ORDER BY  StoreId ASC;
-- Q5. Present the t_Quarterly sales analysis for all stores using drill down query concepts.
SELECT  l.StoreName,SUM(ts.Sales) as sales ,t.t_Quarter FROM metro_dwh.transactions ts,  time t,location l
-- where ts.timeid in(Select idTime FROM metro_dwh.time where t_Quarter=1 )
where ts.StoreId=l.id_Store
 GROUP BY ts.StoreId,t.t_Quarter;
--  Q6. Find the 5 most popular products sold over the weekends.
SELECT  p.Product_Name,SUM(ts.Quantity) FROM metro_dwh.transactions ts  ,product p, time t
Where ts.timeId in( SElect idTime FROM metro_dwh.time where day=6 or day=7 )
and p.idProduct=ts.productId
group by p.Product_Name
ORDER BY  SUM(ts.Quantity) DESC LIMIT 10 ; 

-- Q7. Preform ROLLUP operation to store, supplier, and product. Explain your query results in 
-- a few lines
SELECT l.StoreName,pr.Product_Name ,s.supplierName
FROM location l, product pr ,transactions t, supplier s
where l.id_Store = t.StoreId
AND pr.idProduct = t.productId
AND s.idSupplier= t.supplierID
GROUP BY l.StoreName,pr.Product_Name ,s.supplierName ;
-- Q9. Find an anomaly in the data warehouse dataset. Write a query to show that anomaly 
-- and explain the anomaly in your project report

SELECT Product_Name, Unit_Price
FROM metro_dwh.product
GROUP BY Product_Name
HAVING COUNT(Product_Name) > 1;

SELECT Product_Name, Unit_Price
FROM metro_dwh.product
where Product_Name='Tomatoes';

-- Q10 Create a materialised view with name “STORE_PRODUCT_ANALYSIS” that presents store 
-- and product wise sales. The results should be ordered by store name and then product 
-- name. How the materialized view helps in OLAP query optimisation?
 CREATE VIEW STORE_PRODUCT_ANALYSIS as
SELECT  l.StoreName,p.Product_Name,SUM(ts.sales)
FROM metro_dwh.transactions ts  ,product p,  location l
where ts.StoreId=l.id_Store
AND ts.productId =p.idProduct 
group by l.StoreName,p.Product_Name ;
SELECT * FROM STORE_PRODUCT_ANALYSIS;
    
DROP VIEW STORE_PRODUCT_ANALYSIS;
-- Q8. Extract total sales of each product for the first and second half of year 2017 along with 
-- its total yearly sales.
 




