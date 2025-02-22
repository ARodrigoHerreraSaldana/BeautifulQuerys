USE SampleDB;
DROP PROCEDURE IF EXISTS registerUser;
DELIMITER //

CREATE PROCEDURE registerUser(
    IN in_first_name VARCHAR(50),
    IN in_last_name VARCHAR(50),
    IN in_occupation VARCHAR(50),
    IN in_email VARCHAR(100),
    IN in_password TEXT
)
BEGIN
    DECLARE virtual_salt VARCHAR(128);

    IF in_first_name IS NULL OR in_last_name IS NULL OR in_occupation IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Your first name, last name or occupation can not be null';
    END IF;

    IF EXISTS (SELECT 1 FROM users WHERE email = in_email) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sorry =(. The email is already registered';
    END IF;

    SET virtual_salt = UUID();
    INSERT INTO users(firstName, lastName, occupation, email, hashPassword, salt, isActive, createdAt, updatedAt)
    VALUES (in_first_name,
            in_last_name,
            in_occupation,
            in_email,
            hashedPassword(in_password, virtual_salt),
            virtual_salt,
            TRUE,
            NOW(),
            NOW()
    );
END;
//
DELIMITER ;

-- How to use it
caLL registerUser('Max','Power','dev','testmail@gmail.com','dog');
SHOW FIELDS FROM users;
drop table users;
SELECT * FROM users;