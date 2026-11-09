DELETE FROM ProductInventory
WHERE EXISTS (
    SELECT * 
    FROM Product 
    WHERE Product.ProductID = ProductInventory.ProductID 
      AND Product.ModelID = 33
);