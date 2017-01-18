

DELIMITER $$

CREATE PROCEDURE pr_cancelorder(seatnopar VARCHAR(20),item VARCHAR(20),cancelQuantity  INT)
BEGIN
DECLARE itemIdpar INT;
DECLARE f_orderedTime VARCHAR(20);
DECLARE quantityleft INT;
DECLARE transquantity INT;
DECLARE sid INT;
DECLARE f_ordereditem VARCHAR(20);

SET f_ordereditem=(SELECT food_ordered FROM order_transaction WHERE seat_no=seatnopar AND food_ordered=item
		ORDER BY order_time DESC LIMIT 0,1);
SET f_orderedTime=(SELECT  order_time FROM order_transaction WHERE seat_no=seatnopar AND Food_ordered=f_ordereditem
		ORDER BY order_time DESC LIMIT 0,1);
SET transquantity=(SELECT quantity FROM order_transaction WHERE seat_no=seatnopar AND food_ordered=item ORDER BY order_time DESC LIMIT 0,1);
SET itemIdpar = (SELECT item_id FROM items_list WHERE items=item);
SET sid=(SELECT session_id FROM items_list WHERE item_id=itemIdpar);
		 
SET quantityleft=(SELECT remaining FROM remaining_details WHERE item_id=itemIdpar );
IF fn_check_seatno_for_cancel(seatnopar)=1
THEN
IF EXISTS (SELECT items FROM items_list WHERE item_id=itemidpar AND session_id=sid)
THEN
IF (SELECT quantity FROM order_transaction WHERE seat_no=seatnopar AND Food_ordered=f_ordereditem AND order_time=f_orderedTime)>=cancelquantity AND  cancelquantity!=0
THEN
IF(quantityleft<(SELECT quantity FROM sessions WHERE Session_id=sid))
THEN
UPDATE order_transaction
SET quantity=quantity-cancelquantity,order_status='OrderCancelled'
WHERE seat_no=seatnopar AND food_ordered=f_ordereditem AND order_time=f_orderedTime;
CALL pr_to_update_remaining(itemidpar,cancelquantity);
SELECT 'Order cancelled' AS message;
END IF;
ELSE 
SELECT 'Quantity mismatch' AS statement;
END IF;
ELSE 
SELECT 'Item doesnt exist' AS statement;
END IF;
ELSE
SELECT 'Invalid seat no' AS statement;
END IF;
END $$
DELIMITER ;

DROP PROCEDURE pr_cancelorder
CALL pr_cancelorder('109','idly',7) 









