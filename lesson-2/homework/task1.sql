DROP TABLE IF EXISTS test_identity
CREATE TABLE test_identity
(
    id INT PRIMARY KEY IDENTITY(1,1),
    test VARCHAR(50)
);

INSERT INTO test_identity(test) --inserting values
VALUES
    ('test1'),
    ('test2'),
    ('test3'),
    ('test4'),
    ('test5');

DELETE FROM test_identity --Columns are remaining, only data from table was deleted and when we insert new data, IDENTITY number starts from where it stopped.
SELECT * FROM test_identity

INSERT INTO test_identity(test) --inserting values
VALUES
    ('test1'),
    ('test2'),
    ('test3'),
    ('test4'),
    ('test5');
TRUNCATE TABLE test_identity --Columns are remaining, only data from table was deleted. The difference from DELETE, when we insert new data, IDENTITY number starts from the beginning(1).
SELECT * FROM test_identity

INSERT INTO test_identity(test) --inserting values
VALUES
    ('test1'),
    ('test2'),
    ('test3'),
    ('test4'),
    ('test5'); 
DROP TABLE test_identity --Table was deleted from the server.
