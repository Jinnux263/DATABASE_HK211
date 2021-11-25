USE ASSIGNMENT2

-- DROP TABLE IF EXISTS USERTB;

SELECT * FROM USERTB

GO
CREATE PROCEDURE uspProductList
AS
BEGIN
    SELECT 
        product_name, 
        list_price
    FROM 
        production.products
    ORDER BY 
        product_name;
END;

GO
