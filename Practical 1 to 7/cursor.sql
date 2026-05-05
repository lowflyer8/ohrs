DROP DATABASE IF EXISTS CollegeDB1;
CREATE DATABASE CollegeDB1;
USE CollegeDB1;

CREATE TABLE O_RollCall (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50),
    Branch VARCHAR(30)
);

CREATE TABLE N_RollCall (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50),
    Branch VARCHAR(30)
);

INSERT INTO O_RollCall VALUES
(1, 'Aarav', 'Computer'),
(2, 'Neha', 'ENTC'),
(3, 'Riya', 'Mechanical');

INSERT INTO N_RollCall VALUES
(2, 'Neha', 'ENTC'),
(3, 'Riya', 'Mechanical'),
(4, 'Karan', 'IT'),
(5, 'Meera', 'Civil');


-- Q1. Write a PL/SQL block using Parameterized Cursor to merge N_RollCall into O_RollCall,
-- skipping already existing records.

DELIMITER $$

CREATE PROCEDURE MergeRollCall()
BEGIN
    DECLARE v_Roll INT;
    DECLARE v_Name VARCHAR(50);
    DECLARE v_Branch VARCHAR(30);
    DECLARE v_exists INT DEFAULT 0;

    -- Parameterized Cursor: accepts RollNo as parameter
    DECLARE cur CURSOR FOR 
        SELECT RollNo, Name, Branch FROM N_RollCall;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_Roll = NULL;

    OPEN cur;
    fetch_loop: LOOP
        FETCH cur INTO v_Roll, v_Name, v_Branch;
        IF v_Roll IS NULL THEN
            LEAVE fetch_loop;
        END IF;

        -- Check if RollNo already exists in O_RollCall
        SELECT COUNT(*) INTO v_exists FROM O_RollCall WHERE RollNo = v_Roll;

        -- If not found, insert it
        IF v_exists = 0 THEN
            INSERT INTO O_RollCall VALUES (v_Roll, v_Name, v_Branch);
        END IF;
    END LOOP;
    CLOSE cur;

    SELECT 'Merge Completed Successfully!' AS Message;
END$$

DELIMITER ;


-- Q2. Execute the procedure.
CALL MergeRollCall();


-- Q3. Display final merged O_RollCall table.
SELECT * FROM O_RollCall;


-- Q4. Display N_RollCall table (for reference).
SELECT * FROM N_RollCall;
