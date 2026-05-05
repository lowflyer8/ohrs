DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Borrower (
    Rollin INT PRIMARY KEY,
    Name VARCHAR(50),
    DateofIssue DATE,
    NameofBook VARCHAR(100),
    Status CHAR(1) -- 'I' for Issued, 'R' for Returned
);

CREATE TABLE Fine (
    Roll_no INT,
    Date DATE,
    Amt DECIMAL(10,2)
);

INSERT INTO Borrower VALUES
(1, 'Aarav', '2025-10-10', 'C Programming', 'I'),
(2, 'Neha', '2025-09-25', 'Database Systems', 'I'),
(3, 'Riya', '2025-11-01', 'Digital Logic', 'I');


-- Q1. Write a PL/SQL block of code that accepts Roll Number and Book Name,
-- checks the number of days from Date of Issue, calculates fine based on conditions,
-- updates Status from 'I' to 'R', and stores fine details if applicable.

DELIMITER $$

CREATE PROCEDURE ReturnBook(
    IN p_roll INT,
    IN p_book VARCHAR(100)
)
BEGIN
    DECLARE v_date_of_issue DATE;
    DECLARE v_days INT;
    DECLARE v_fine DECIMAL(10,2) DEFAULT 0;

    -- Exception handler for missing record
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
        SELECT 'Error: No record found for given Roll Number and Book Name!' AS Message;
    END;

    -- Retrieve Date of Issue
    SELECT DateofIssue 
    INTO v_date_of_issue
    FROM Borrower
    WHERE Rollin = p_roll AND NameofBook = p_book AND Status = 'I';

    -- Calculate number of days since issue
    SET v_days = DATEDIFF(CURDATE(), v_date_of_issue);

    -- Control structure for fine calculation
    IF v_days BETWEEN 15 AND 30 THEN
        SET v_fine = v_days * 5;
    ELSEIF v_days > 30 THEN
        SET v_fine = v_days * 50;
    ELSE
        SET v_fine = 0;
    END IF;

    -- Update status to Returned
    UPDATE Borrower
    SET Status = 'R'
    WHERE Rollin = p_roll AND NameofBook = p_book;

    -- Insert fine details if applicable
    IF v_fine > 0 THEN
        INSERT INTO Fine (Roll_no, Date, Amt)
        VALUES (p_roll, CURDATE(), v_fine);
    END IF;

    -- Display result
    SELECT CONCAT('Book Returned Successfully. Days Late: ', v_days, ', Fine: ₹', v_fine) AS Result;

END$$

DELIMITER ;

-- Q2. Execute the procedure for a given Roll Number and Book Name.
CALL ReturnBook(1, 'C Programming');


-- Q3. Display updated Borrower table.
SELECT * FROM Borrower;


-- Q4. Display Fine details table.
SELECT * FROM Fine;
