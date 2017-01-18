DELIMITER $$

CREATE  FUNCTION fn_check_seat(seat_no_par VARCHAR(20)) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF EXISTS(SELECT seat_no FROM seat_details WHERE Seat_No=seat_no_par)
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;

DROP FUNCTION  fn_check_seatno_for_cancel


DELIMITER $$

CREATE  FUNCTION fn_check_itemslimit(orderidpar INT) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF (SELECT COUNT(DISTINCT(Food_ordered)) FROM order_transaction WHERE order_id=orderidpar) <= (SELECT max_quantity FROM maximum_quantity WHERE day_name='week_day')THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;



DELIMITER $$

CREATE  FUNCTION fn_check_seatno_for_cancel(seatnopar VARCHAR(20)) RETURNS INT(11)
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




DELIMITER $$

CREATE  PROCEDURE pr_to_update_remiaining(itemidpar VARCHAR(20),quantity INT)
BEGIN
DECLARE remainingitems INT;
SELECT remaining INTO RemainingItems FROM remaining_details WHERE Item_Id=itemidpar;
UPDATE remaining_details
			SET remaining=RemainingItems-Quantity
			WHERE Item_Id=itemidpar;
END$$

DELIMITER ;




DELIMITER $$

CREATE  PROCEDURE pr_to_update_remaining(itemidpar VARCHAR(20),cancelquantity INT)
BEGIN
DECLARE remainingitems INT;
SELECT remaining INTO RemainingItems FROM remaining_details WHERE Item_Id=itemidpar;
UPDATE remaining_details
SET remaining=remaining+cancelquantity
WHERE item_id=itemIdpar;
END$$

DELIMITER ;

DROP PROCEDURE pr_to_update_remaining

