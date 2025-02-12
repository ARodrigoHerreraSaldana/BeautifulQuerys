DELIMITER //
CREATE FUNCTION calculate_square2(num INT)
RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE result INT;
    SET result = num * num;
    RETURN result;
END //
DELIMITER ;