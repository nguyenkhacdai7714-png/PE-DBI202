SELECT 
    L.LocationID,
    L.Name AS LocationName,
    P.ProductID,
    P.Name AS ProductName,
    PI.Quantity
FROM ProductInventory PI
INNER JOIN Location L ON PI.LocationID = L.LocationID
INNER JOIN Product P ON PI.ProductID = P.ProductID

WHERE PI.Quantity = (
SELECT MAX (PI2.Quantity) FROM ProductInventory PI2 
WHERE PI2.LocationID = PI.LocationID
)

ORDER BY LocationName ASC, ProductName DESC;

