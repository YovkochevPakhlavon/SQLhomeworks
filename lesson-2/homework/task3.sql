DROP TABLE IF EXISTS photos
CREATE TABLE photos
(
    id INT PRIMARY KEY IDENTITY,
    photo VARBINARY(MAX)
);

INSERT INTO photos(photo)
SELECT * FROM OPENROWSET(
  BULK '/var/opt/mssql/data/lesson-2/homework/Macbook_Air_15_inch_-_2.jpg',
  SINGLE_BLOB
) AS img;

SELECT * FROM photos