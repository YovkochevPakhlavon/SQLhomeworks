CREATE TABLE account
(
    account_id INT PRIMARY KEY,
    balance FLOAT CONSTRAINT check_balance CHECK (balance>0),
    account_type VARCHAR(50) CONSTRAINT check_account_type CHECK (account_type = 'Saving' OR account_type = 'Checking')
);

--Droping constraint:
ALTER TABLE account
DROP CONSTRAINT check_balance,check_account_type;

--Adding constraint again:
ALTER TABLE account
ADD CONSTRAINT check_balance CHECK (balance>0);

ALTER TABLE account
ADD CONSTRAINT check_account_type CHECK (account_type = 'Saving' OR account_type = 'Checking');