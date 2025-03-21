DROP TABLE IF EXISTS invoice
CREATE TABLE invoice
(
    invoice_id INT PRIMARY KEY IDENTITY(1,1),
    amount FLOAT
);

INSERT INTO invoice
VALUES 
    (20.5),
    (21),
    (37.5),
    (13.2),
    (21.8);

SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice(invoice_id,amount)
VALUES (100,26.7);

SET IDENTITY_INSERT invoice OFF;
