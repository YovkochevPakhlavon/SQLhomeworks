DROP TABLE IF EXISTS data_types_demo
CREATE TABLE data_types_demo
(
    id1 TINYINT,
    number3 INT,
    product VARCHAR(50),
    price_decimal DECIMAL(10,2),
    price_float FLOAT,
    created_date DATE,
    created_datetime DATETIME
);

INSERT INTO data_types_demo
VALUES
    (7,255,'apple',875.25,875.2489,'2010-11-22',GETDATE())

SELECT * FROM data_types_demo