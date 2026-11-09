SELECT 
    PS.SubcategoryID,
    PS.Name AS SubCategoryName,
    PS.Category,
    COUNT(DISTINCT P.ProductID) AS NumberOfProducts
    --ĐẾM KHÔNG TRÙNG LẶP
FROM ProductSubcategory PS
LEFT JOIN Product P ON PS.SubcategoryID = P.SubcategoryID
GROUP BY PS.SubcategoryID, PS.Name, PS.Category
ORDER BY PS.Category ASC, NumberOfProducts DESC, SubCategoryName ASC;