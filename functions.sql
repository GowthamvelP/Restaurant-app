DELIMITER $$

CREATE  FUNCTION fn_check_seat(seat_no_par VARCHAR(20)) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF EXISTS(SELECT seat_no FROM seat_details WHERE Seat_No=seat_no_par) THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;




DELIMITER $$

CREATE  FUNCTION fn_check_itemslimit(total_no_of_items INT) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF total_no_of_items <= (SELECT max_quantity FROM maximum_quantity WHERE sno=1)THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;



DELIMITER $$

CREATE  FUNCTION fn_check_seatno_for_cancel(seat_no_par VARCHAR(20)) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF EXISTS(SELECT seat_no FROM order_transaction WHERE seat_no=seatnopar)
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;


