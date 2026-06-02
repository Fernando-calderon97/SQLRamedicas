SELECT 
CASE
 WHEN DAYOFWEEK(order_date) = 7 THEN 'weekend'
 WHEN DAYOFWEEK(order_date) = 1 THEN 'weekend'
 ELSE 'weekday' END AS 'tipday',
COUNT(order_id)
FROM orders
WHERE order_date BETWEEN '2022-09-04' AND '2022-09-10'
GROUP BY tipday;


SELECT 
D.driver_id,
COUNT(O.order_id)
FROM orders O
INNER JOIN drivers D ON O.driver_id = D.driver_id
WHERE order_date BETWEEN '2022-07-01' AND '2022-07-31' AND D.driver_id = 10 AND O.total_price > 50
GROUP BY D.driver_id;


SELECT 
cuisine,
COUNT(restaurant_id)
FROM restaurants 
GROUP BY cuisine;

SELECT 
order_date,
COUNT(order_id)
FROM orders
WHERE order_date BETWEEN '2022-09-01' AND '2022-09-30' AND DAYOFWEEK(order_date) = 2
GROUP BY order_date;

SELECT 
COUNT(order_id)
FROM orders
WHERE order_date = '2022-07-01' AND final_price < 35;


SELECT
CASE
    WHEN TIME(delivered_time) < 30 THEN 'rapido'
    WHEN MINUTE(delivered_time) BETWEEN 30 AND 60 THEN 'medio'
    ELSE 'lento' END AS 'timeent',
    COUNT(order_id)
FROM orders
GROUP BY timeent

SELECT
 TIMESTAMPDIFF(MINUTE, delivered_time),
 delivered_time
FROM orders
LIMIT 25;
