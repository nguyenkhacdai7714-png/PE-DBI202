SELECT TOP 1 WITH TIES
    L.LocationID,
    L.Name AS LocationName,
    COUNT(DISTINCT PI.ProductID) AS NumberOfProducts
FROM Location L
INNER JOIN ProductInventory PI ON L.LocationID = PI.LocationID
GROUP BY L.LocationID, L.Name
ORDER BY NumberOfProducts ASC;

