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



DELIMITER $$

CREATE  FUNCTION fn_check_items_limit(order_id_par INT) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF (SELECT COUNT(DISTINCT(Food_ordered)) FROM order_transaction WHERE order_id=order_id_par) <= (SELECT max_quantity FROM maximum_quantity WHERE day_name='week_day')THEN
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
IF EXISTS(SELECT seat_no FROM order_transaction WHERE seat_no=seat_no_par)
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;




DELIMITER $$

CREATE  PROCEDURE pr_to_update_remiaining(item_id_par VARCHAR(20),quantity INT)
BEGIN
DECLARE remaining_items INT;
SELECT remaining INTO Remaining_items FROM remaining_details WHERE Item_Id=item_id_par;
UPDATE remaining_details
			SET remaining=Remaining_items-Quantity
			WHERE Item_Id=item_id_par;
END$$

DELIMITER ;




DELIMITER $$

CREATE  PROCEDURE pr_to_update_remaining(item_id_par VARCHAR(20),cancel_quantity INT)
BEGIN
DECLARE remaining_items INT;
SELECT remaining INTO remaining_items FROM remaining_details WHERE Item_Id=item_id_par;
UPDATE remaining_details
SET remaining=remaining+cancel_quantity
WHERE item_id=item_Id_par;
END$$

DELIMITER ;


