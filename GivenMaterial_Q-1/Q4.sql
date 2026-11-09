SELECT
    p.product_id,
    p.product_name,
    p.model_year,
    p.Brand,
    p.Category,
    SUM(
        (1 - oi.discount) * oi.quantity * oi.price
    ) AS TotalAmount
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE
    p.Category = 'Mountain Bikes' AND p.Brand = 'Surly'
GROUP BY
    p.product_id,
    p.product_name,
    p.model_year,
    p.Brand,
    p.Category
ORDER BY
    TotalAmount DESC,
    p.product_name ASC;