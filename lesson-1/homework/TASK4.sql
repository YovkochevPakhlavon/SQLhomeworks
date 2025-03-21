CREATE TABLE category
(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE item
(
    item_id INT PRIMARY KEY,
    item_name VARCHAR(50),
    category_id INT CONSTRAINT fk_category_id FOREIGN KEY REFERENCES category(category_id)
);

--Droping constraint:
ALTER TABLE item
DROP CONSTRAINT fk_category_id;

--Adding constraint again:
ALTER TABLE item
ADD CONSTRAINT fk_category_id FOREIGN KEY(category_id) REFERENCES category(category_id);
