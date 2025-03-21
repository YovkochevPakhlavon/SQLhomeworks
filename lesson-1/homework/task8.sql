DROP TABLE IF EXISTS books
CREATE TABLE books
(
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) CONSTRAINT check_title CHECK (title <> ''),
    price FLOAT CONSTRAINT check_price CHECK (price > 0),
    genre VARCHAR(255) CONSTRAINT df_genre DEFAULT 'Unknown'
);

INSERT INTO books (title, price)
VALUES ('1984',25.5);
