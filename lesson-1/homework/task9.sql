CREATE TABLE Book --Stores information about books
(
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255),
    author VARCHAR(255),
    published_year INT
);

CREATE TABLE Member --Stores information about library members
(
    member_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(255)
);

CREATE TABLE Loan --Tracks which members borrow which books
(
    loan_id INT PRIMARY KEY IDENTITY(1,1),
    book_id INT FOREIGN KEY REFERENCES Book(book_id),
    member_id INT FOREIGN KEY REFERENCES Member(member_id),
    loan_date DATE,
    return_date DATE 
);

-- Insert sample data into Book table
INSERT INTO Book (title, author, published_year)
VALUES 
    ('To Kill a Mockingbird', 'Harper Lee', 1960),
    ('1984', 'George Orwell', 1949),
    ('The Great Gatsby', 'F. Scott Fitzgerald', 1925);

-- Insert sample data into Member table
INSERT INTO Member (name, email, phone_number)
VALUES 
    ('Alice Johnson', 'alice@example.com', '123-456-7890'),
    ('Bob Smith', 'bob@example.com', '987-654-3210'),
    ('Charlie Brown', 'charlie@example.com', '555-777-8888');

-- Insert sample data into Loan table
INSERT INTO Loan (book_id, member_id, loan_date, return_date)
VALUES
    (1, 1, '2025-03-01', '2025-03-15'),
    (2, 1, '2025-03-16', NULL), -- not returned yet
    (3, 2, '2025-03-05', '2025-03-10');

SELECT * FROM Loan