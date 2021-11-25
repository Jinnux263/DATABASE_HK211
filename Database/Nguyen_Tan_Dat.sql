USE ASSIGNMENT2

-- DROP TABLE IF EXISTS USERTB;

SELECT * FROM USERTB WHERE User_ID = '1000001'

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
