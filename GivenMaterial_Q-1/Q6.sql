CREATE PROCEDURE p2
    @customer_id INT,
    @NumberOfOrders INT OUTPUT AS
BEGIN
    SELECT
    @NumberOfOrders = COUNT(*) FROM orders
    WHERE customer_id = @customer_id;
END;


