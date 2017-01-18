

DELIMITER $$

CREATE PROCEDURE pr_cancel_order(seat_no_par VARCHAR(20),item VARCHAR(20),cancel_quantity  INT)
BEGIN
DECLARE item_id_par INT;
DECLARE f_ordered_time VARCHAR(20);
DECLARE quantity_left INT;
DECLARE trans_quantity INT;
DECLARE s_id INT;
DECLARE f_ordered_item VARCHAR(20);

SET f_ordered_item=(SELECT food_ordered FROM order_transaction WHERE seat_no=seat_no_par AND food_ordered=item
		ORDER BY order_time DESC LIMIT 0,1);
SET f_ordered_time=(SELECT  order_time FROM order_transaction WHERE seat_no=seat_no_par AND Food_ordered=f_ordered_item
		ORDER BY order_time DESC LIMIT 0,1);
SET trans_quantity=(SELECT quantity FROM order_transaction WHERE seat_no=seat_no_par AND food_ordered=item ORDER BY order_time DESC LIMIT 0,1);
SET item_id_par = (SELECT item_id FROM items_list WHERE items=item);
SET s_id=(SELECT session_id FROM items_list WHERE item_id=item_id_par);
		 
SET quantity_left=(SELECT remaining FROM remaining_details WHERE item_id=item_id_par );
IF fn_check_seatno_for_cancel(seat_no_par)=1
THEN
IF EXISTS (SELECT items FROM items_list WHERE item_id=item_id_par AND session_id=s_id)
THEN
IF (SELECT quantity FROM order_transaction WHERE seat_no=seat_no_par AND Food_ordered=f_ordered_item AND order_time=f_ordered_Time)>=cancel_quantity AND  cancel_quantity!=0
THEN
IF(quantity_left<(SELECT quantity FROM sessions WHERE Session_id=s_id))
THEN
UPDATE order_transaction
SET quantity=quantity-cancel_quantity,order_status='OrderCancelled'
WHERE seat_no=seat_no_par AND food_ordered=f_ordered_item AND order_time=f_ordered_Time;
CALL pr_to_update_remaining(item_id_par,cancel_quantity);
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

DROP PROCEDURE pr_cancel_order
CALL pr_cancel_order('109','idly',7) 









