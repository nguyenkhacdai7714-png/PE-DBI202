SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    s.store_id,
    s.store_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN stores s ON o.store_id = s.store_id
WHERE
s.store_name = 'Santa Cruz Bikes'
AND o.order_date>='2017-06-01' 
AND o.order_date<='2017-08-01'  ;