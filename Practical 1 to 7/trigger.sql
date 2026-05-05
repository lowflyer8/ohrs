DROP DATABASE IF EXISTS LibraryDB1;
CREATE DATABASE LibraryDB1;
USE LibraryDB1;

CREATE TABLE Library (
    Book_ID INT PRIMARY KEY,
    Book_Name VARCHAR(100),
    Author VARCHAR(50),
    Price DECIMAL(8,2)
);

CREATE TABLE Library_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Book_ID INT,
    Book_Name VARCHAR(100),
    Author VARCHAR(50),
    Price DECIMAL(8,2),
    Operation_Type VARCHAR(20),
    Operation_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Library VALUES
(1, 'C Programming', 'Dennis Ritchie', 450.00),
(2, 'Database Systems', 'Elmasri', 520.00),
(3, 'Digital Logic', 'Morris Mano', 400.00);

-- Q1. Trigger to store old values of updated or deleted records into Library_Audit

DELIMITER $$

CREATE TRIGGER before_library_update
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Book_Name, Author, Price, Operation_Type)
    VALUES (OLD.Book_ID, OLD.Book_Name, OLD.Author, OLD.Price, 'UPDATE');
END$$

CREATE TRIGGER before_library_delete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Book_Name, Author, Price, Operation_Type)
    VALUES (OLD.Book_ID, OLD.Book_Name, OLD.Author, OLD.Price, 'DELETE');
END$$

DELIMITER ;

-- Q2. Perform Update and Delete operations
UPDATE Library SET Price = 600.00 WHERE Book_ID = 2;
DELETE FROM Library WHERE Book_ID = 3;

-- Q3. Display results
SELECT * FROM Library;
SELECT * FROM Library_Audit;
