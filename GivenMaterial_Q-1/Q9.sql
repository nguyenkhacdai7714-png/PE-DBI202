CREATE TRIGGER tr_insert_Product
ON Product AFTER INSERT 
AS
BEGIN
    SELECT 
        i.ProductID,
        i.Name AS ProductName,
        i.ModelID,
        PM.Name AS ModelName
    FROM inserted i
    LEFT JOIN ProductModel PM ON i.ModelID = PM.ModelID;
   



END;



