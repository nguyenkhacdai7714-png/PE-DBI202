CREATE PROCEDURE proc_product_model
    @modelID int,
    @numberOfProducts int OUTPUT
AS
BEGIN
    SELECT @numberOfProducts = COUNT (DISTINCT ProductID)
    FROM Product
    WHERE ModelID = @modelID

END;



