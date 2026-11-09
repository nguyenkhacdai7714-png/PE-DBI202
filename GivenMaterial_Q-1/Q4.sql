SELECT 
    P.ProductID,
    P.Name AS ProductName,
    P.Color,
    P.Cost,
    P.Price,
    L.LocationID,
    L.Name AS LocationName,
    PI.Shelf,
    PI.Bin,
    PI.Quantity
FROM Product P
LEFT JOIN ProductInventory PI ON P.ProductID = PI.ProductID
LEFT JOIN Location L ON PI.LocationID = L.LocationID
WHERE P.Color = 'Yellow' AND P.Cost < 400;