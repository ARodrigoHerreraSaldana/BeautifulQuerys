--Query for MYSQL
DROP FUNCTION IF EXISTS hashedPassword;
DELIMITER //
CREATE FUNCTION hashedPassword(passwordtext VARCHAR(100), salt VARCHAR(50))
RETURNS VARCHAR(128)
DETERMINISTIC 
BEGIN 
    DECLARE hashedpassword VARCHAR(128);
    DECLARE passwordandSalt TEXT; 
    SET passwordandSalt = CONCAT(passwordtext,salt);
    SET hashedpassword = SHA2(passwordandSalt,512);
    RETURN hashedpassword;
END //
DELIMITER ;

--Notes: 
-- Run this to get a random uuid
SELECT UUID() AS UUID_Value ;
-- then call it like 
select hashedPassword('userpassword','b4621d4d-e8a3-11ef-a610-0245757bf85f')
-- that output will be your hashed password
--for example
--0368577ed6ee90228538e7872ae11da7156474e96f1e1f5df985ab4fafea6f86c04c21c32750f68de218f983752e57d9965eb2cb8d3ba2e12096986b1e02213a
