DROP FUNCTION IF EXISTS checkuser;
DELIMITER //

CREATE FUNCTION checkuser(email_to_validate VARCHAR(50), password_to_validate TEXT)
RETURNS TINYINT
BEGIN
  DECLARE result TINYINT;
  DECLARE virtual_password VARCHAR(128);
  DECLARE virtual_salt TEXT;

  IF email_to_validate IS NULL OR password_to_validate IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EMAIL OR PASSWORD CANNOT BE NULL';
  END IF;

 IF NOT EXISTS (SELECT 1 FROM users WHERE email = email_to_validate) THEN
    SET @SPECIALERROR = concat ('No user found with your email, Please register');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @SPECIALERROR;
  END IF;
  
  SELECT salt, hashPassword
  INTO virtual_salt, virtual_password
  FROM users
  WHERE email = email_to_validate;  
  IF virtual_password = hashedpassword(password_to_validate, virtual_salt) THEN
    SET result = 1; 
  ELSE
    SET result = 0; 
  END IF;

  RETURN result;
END //