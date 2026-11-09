SELECT
    customer_id,
    first_name,
    last_name,
    city,
    state
FROM customers
WHERE (last_name LIKE 'A%' OR last_name LIKE 'O%') 
AND (state = 'CA' OR state = 'NY')
ORDER BY
state ASC, 
customer_id ASC;