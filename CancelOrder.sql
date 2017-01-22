

DELIMITER $$

CREATE PROCEDURE pr_cancel_order(seat_no_par VARCHAR(20),item VARCHAR(20),cancel_quantity  INT,OUT statement VARCHAR(200))
BEGIN
DECLARE item_id_par INT;
DECLARE f_ordered_time VARCHAR(20);
DECLARE quantity_left INT;
DECLARE trans_quantity INT;
DECLARE s_id INT;
DECLARE f_ordered_item VARCHAR(20);
DECLARE existing_seat_no INT;
DECLARE c_order_time TIME;

SET existing_seat_no=(SELECT seat_no FROM order_transaction WHERE seat_no=seat_no_par AND Food_ordered=item LIMIT 0,1);
SET f_ordered_item=(SELECT food_ordered FROM order_transaction WHERE seat_no=seat_no_par AND food_ordered=item
		ORDER BY order_time DESC LIMIT 0,1);
SET f_ordered_time=(SELECT  order_time FROM order_transaction WHERE seat_no=seat_no_par AND Food_ordered=f_ordered_item
		ORDER BY order_time DESC LIMIT 0,1);
SET trans_quantity=(SELECT quantity FROM order_transaction WHERE seat_no=seat_no_par AND food_ordered=item ORDER BY order_time DESC LIMIT 0,1);
SET item_id_par = (SELECT item_id FROM items_list WHERE items=item LIMIT 0,1);
SET s_id=(SELECT session_id FROM items_list WHERE item_id=item_id_par);
SET quantity_left=(SELECT remaining FROM remaining_details WHERE item_id=item_id_par );

IF (existing_seat_no IS NOT NULL)
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
SELECT 'Order cancelled' INTO statement;
END IF;
ELSE 
SELECT 'Quantity mismatch' INTO statement;
END IF;
ELSE 
SELECT 'Item doesnt exist' INTO statement;
END IF;
ELSE
SELECT 'Invalid seat no' INTO statement;
END IF;

END $$
DELIMITER ;





SELECT @statement;
CALL pr_cancel_order('109','northindianthali',100,@statement); 








