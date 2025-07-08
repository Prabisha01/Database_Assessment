-- =============================================
-- Assignment Part C: Sequential and distributed processing 
-- Module: Data Management Systems
-- Student Name: Abishek Bimali, Basanta Adhikari, Prabisha Khadka
-- =============================================





-- Create the SALES_DATA table
CREATE TABLE SALES_DATA(
  OrderNo INTEGER,
  ProductNo INTEGER,
  Price FLOAT,
  Quantity INTEGER,
  Sales FLOAT,
  QtrId INTEGER CHECK (QtrId BETWEEN 1 AND 4),
  MonthId INTEGER CHECK (MonthId BETWEEN 1 AND 12),
  YearId INTEGER
);


-- Insert sample data
INSERT INTO SALES_DATA VALUES (10107, 2, 85.7, 30, 2587, 1, 2, 2003);
INSERT INTO SALES_DATA VALUES (10107, 5, 95.8, 39, 3879.49, 1, 2, 2003);
INSERT INTO SALES_DATA VALUES (10121, 5, 71.5, 34, 2700, 1, 2, 2003);
INSERT INTO SALES_DATA VALUES (10134, 2, 94.74, 41, 3884.34, 3, 7, 2004);
INSERT INTO SALES_DATA VALUES (10134, 5, 100, 27, 3307.77, 3, 7, 2004);
INSERT INTO SALES_DATA VALUES (10159, 14, 100, 49, 5205.27, 4, 10, 2005);
INSERT INTO SALES_DATA VALUES (10168, 1, 96.66, 36, 3479.66, 4, 10, 2006);
INSERT INTO SALES_DATA VALUES (10180, 12, 100, 42, 4695.6, 4, 11, 2006);
COMMIT;

SELECT * 
FROM SALES_DATA;


SELECT 
    ProductNo,
    MonthId,
    YearId,
    SUM(Quantity) AS Products_Sold
FROM 
    SALES_DATA
GROUP BY 
    ProductNo,
    MonthId,
    YearId
ORDER BY 
    ProductNo,
    YearId,
    MonthId;

SELECT 
    column_name, 
    data_type, 
    data_length, 
    data_precision, 
    data_scale
FROM 
    user_tab_columns
WHERE 
    table_name = 'SALES_DATA';