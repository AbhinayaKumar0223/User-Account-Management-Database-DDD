use ddd;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);
CREATE TABLE Admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    subrole VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

    INSERT INTO Users (username, password) VALUES
('Nevin', 'pass123'),
('Sandali', 'pass123'),
('Lafry', 'pass123'),
('Induwara', 'pass123'),
('Abhinaya', 'pass123'),
('Ahamed', 'pass123');

INSERT INTO Admin (user_id, subrole) VALUES
(1, 'SuperAdmin'),
(2, 'PolicyAdmin'),
(3, 'HelpdeskAdmin'),
(4, 'ClaimsAdmin'),
(5, 'GeneralAdmin'),
(6, 'ITAdmin');
-- ===============================
CREATE TABLE Customer (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    address VARCHAR(200),
    occupation VARCHAR(100),
    birth_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE General_Admin (
    general_admin_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    department VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Customer (user_id, full_name, address, occupation, birth_date) VALUES
(1, 'John Silva', 'Colombo', 'Engineer', '1990-05-12'),
(2, 'Mary Fernando', 'Kandy', 'Teacher', '1992-08-22'),
(3, 'Sahan Perera', 'Galle', 'Doctor', '1988-12-01'),
(4, 'Nimali Jayasuriya', 'Negombo', 'Nurse', '1995-03-18'),
(5, 'Kasun Dias', 'Matara', 'Lawyer', '1991-07-30');

INSERT INTO General_Admin (user_id, department) VALUES
(5, 'Customer Support'),
(5, 'Policy Review'),
(5, 'Finance'),
(5, 'IT Coordination'),
(5, 'Quality Control');

select * from Customer

select full_name, address, occupation, birth_date
FROM Customer
WHERE address = 'Colombo';


select * from General_Admin

-- Show user info along with their general admin departments
SELECT u.user_id, c.full_name, g.department
FROM Users u
JOIN General_Admin g ON u.user_id = g.user_id
JOIN Customer c ON u.user_id = c.user_id;

-- Count how many departments each admin is assigned to
SELECT user_id, COUNT(*) AS total_departments
FROM General_Admin
GROUP BY user_id;


-- Only show admins assigned to more than 3 departments
SELECT user_id, COUNT(*) AS dept_count
FROM General_Admin
GROUP BY user_id
HAVING COUNT(*) > 3;

-- Find customers whose user_id exists in General_Admin
SELECT *
FROM Customer
WHERE user_id IN (SELECT user_id FROM General_Admin);


-- STORED PROCEDURE (MySQL Version)
-- ======================================
DELIMITER $$

CREATE PROCEDURE UpdateCustomerAddress(IN p_user_id INT, IN p_new_address VARCHAR(200))
BEGIN
    UPDATE Customer
    SET address = p_new_address
    WHERE user_id = p_user_id;

    SELECT 'Customer address updated successfully.' AS message;
END$$

DELIMITER ;

-- Run / Test the procedure
CALL UpdateCustomerAddress(2, 'Gampaha');

-- TRIGGER (MySQL Version)
-- ======================================
DELIMITER $$

CREATE TRIGGER trg_CustomerOccupationChange
AFTER UPDATE ON Customer
FOR EACH ROW
BEGIN
    IF OLD.occupation <> NEW.occupation THEN
        INSERT INTO General_Admin (user_id, department)
        VALUES (NEW.user_id, CONCAT('Occupation changed from ', OLD.occupation, ' to ', NEW.occupation));
    END IF;
END$$

DELIMITER ;

-- Test the trigger
UPDATE Customer
SET occupation = 'Senior Teacher'
WHERE user_id = 2;

-- See results
SELECT * FROM General_Admin
WHERE user_id = 2;


