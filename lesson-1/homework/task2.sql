DROP TABLE IF EXISTS product
CREATE TABLE product
(
    product_id INT CONSTRAINT Un_product_id UNIQUE,
    product_name VARCHAR(50),
    price FLOAT
);

--Droping constraint 
ALTER TABLE product DROP CONSTRAINT Un_product_id

--Adding it again:
ALTER TABLE product
ADD CONSTRAINT Un_product_id UNIQUE(product_id);

--Extend the constraint so that the combination of `product_id` and `product_name` must be unique:

--First, we need to drop constraint on product_id: 
ALTER TABLE product DROP CONSTRAINT Un_product_id

--Now, we can extend the constraint as required:
ALTER TABLE product ADD CONSTRAINT Un_product_id_name UNIQUE (product_id, product_name);
