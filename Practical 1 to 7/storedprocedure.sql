DROP DATABASE IF EXISTS CollegeDB2;
CREATE DATABASE CollegeDB2;
USE CollegeDB2;

CREATE TABLE Stud_Marks (
    Roll INT PRIMARY KEY,
    Name VARCHAR(50),
    Total_marks INT
);

CREATE TABLE Result (
    Roll INT,
    Name VARCHAR(50),
    Class VARCHAR(30)
);

INSERT INTO Stud_Marks VALUES
(1, 'Aarav', 1200),
(2, 'Neha', 940),
(3, 'Riya', 860),
(4, 'Karan', 780),
(5, 'Meera', 1500);

-- Q1. Write a Stored Procedure namely proc_Grade for the categorization of students.

DELIMITER $$

CREATE PROCEDURE proc_Grade()
BEGIN
    DECLARE v_roll INT;
    DECLARE v_name VARCHAR(50);
    DECLARE v_marks INT;
    DECLARE v_class VARCHAR(30);
    
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT Roll, Name, Total_marks FROM Stud_Marks;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    grade_loop: LOOP
        FETCH cur INTO v_roll, v_name, v_marks;
        IF done = 1 THEN
            LEAVE grade_loop;
        END IF;
        
        -- Control structure for grade classification
        IF v_marks BETWEEN 990 AND 1500 THEN
            SET v_class = 'Distinction';
        ELSEIF v_marks BETWEEN 900 AND 989 THEN
            SET v_class = 'First Class';
        ELSEIF v_marks BETWEEN 825 AND 899 THEN
            SET v_class = 'Higher Second Class';
        ELSE
            SET v_class = 'Fail';
        END IF;
        
        -- Insert result
        INSERT INTO Result VALUES (v_roll, v_name, v_class);
    END LOOP;
    
    CLOSE cur;
    SELECT 'Student Categorization Completed!' AS Message;
END$$

DELIMITER ;

-- Q2. Execute the Stored Procedure.
CALL proc_Grade();

-- Q3. Display the Result table.
SELECT * FROM Result;
