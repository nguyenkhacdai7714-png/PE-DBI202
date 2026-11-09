
CREATE TRIGGER T2 ON order_items AFTER DELETE AS
BEGIN
SELECT 
deleted.order_id,
o.order_date,
o.status,
deleted.product_id,
products.product_name,
deleted.quantity
FROM deleted
INNER JOIN orders o ON deleted.order_id = o.order_id
INNER JOIN products ON deleted.product_id =  products.product_id;
END;