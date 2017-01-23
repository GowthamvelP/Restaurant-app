

DELIMITER $$
CREATE PROCEDURE pr_order(order_id_par INT,seat_no_par INT,food VARCHAR(20),order_time TIME,quantity INT,OUT message VARCHAR(200))
BEGIN 
 

DECLARE session_id_par INT;
DECLARE seat_id INT;
DECLARE item_id_par INT;
SET session_id_par=(SELECT session_id FROM sessions WHERE order_time BETWEEN from_time AND to_time);
SET item_id_par=(SELECT item_id FROM items_list WHERE items=food AND session_id=session_id_par);
    IF session_id_par=(SELECT session_id FROM items_list WHERE item_id=item_id_par)
    THEN
        IF fn_check_items_limit(order_id_par)=1
        THEN
             IF fn_check_seat(seat_no_par)=1
             THEN
                UPDATE seat_details
		SET seat_status='SEAT_TAKEN'
		WHERE seat_no=seat_no_par;
		    IF fn_check_remaining(item_id_par,quantity)=1
                    THEN			
                      SELECT 'Item got over' INTO message;
		ELSE 
			CALL pr_to_update_remiaining(item_id_par,quantity);
			INSERT INTO order_transaction(order_id,item_id,seat_no,food_ordered,quantity,order_time,order_status) VALUES(order_id_par,item_id_par,seat_no_par,food,quantity,order_time,'OrderPlaced');
                SELECT 'Order Placed' INTO message;		
		END IF;
	ELSE 
		SELECT 'There is no such seatno' INTO message;
		END IF;
       ELSE
       UPDATE seat_details
               SET seat_status='AVAILABLE',seat_active=0
               WHERE seat_no=seat_no_par;	
       SELECT 'Your items limit exceeded' INTO message;
               END IF ;
       ELSE 
       SELECT 'Item is wrongly ordered' INTO message;
       END IF;

END $$
DELIMITER ;







