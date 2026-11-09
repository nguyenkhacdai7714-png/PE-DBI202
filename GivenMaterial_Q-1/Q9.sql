CREATE TRIGGER tr_no_delete ON order_items INSTEAD OF DELETE AS
BEGIN 
SELECT 'no delete' AS [the result];
END;