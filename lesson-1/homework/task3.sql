CREATE TABLE orders
(
    order_id INT CONSTRAINT pk_order_id PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE
);

--we can drop constraint by its name:
ALTER TABLE orders
DROP CONSTRAINT pk_order_id;

--NOW, WE CAN ADD IT AGAIN:
ALTER TABLE orders
ADD CONSTRAINT pk_order_id PRIMARY KEY(order_id);