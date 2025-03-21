CREATE TABLE customer
(
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(50) CONSTRAINT default_city DEFAULT 'Unknown'
);

--Droping constraint:
ALTER TABLE customer
DROP CONSTRAINT default_city;

--Adding constraint again:
ALTER TABLE customer
ADD CONSTRAINT default_city DEFAULT 'Unknown' for city;