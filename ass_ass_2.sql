

DELIMITER $$
CREATE PROCEDURE pr_order(orderidpar INT,seatnopar INT,food VARCHAR(20),ordertime TIME,Quantity INT)
BEGIN 
 

DECLARE remainingitems INT; 
DECLARE sessionidpar INT;s
DECLARE seatid INT;
DECLARE itemidpar INT;
SET sessionidpar=(SELECT session_id FROM sessions WHERE ordertime BETWEEN from_time AND to_time);
SET itemidpar=(SELECT item_id FROM items_list WHERE items=food AND ession_id=sessionidpar);
    IF sessionidpar=(SELECT session_id FROM items_list WHERE item_id=itemidpar)
    THEN
        IF fn_check_itemslimit(orderidpar)=1
        THEN
             IF fn_check_seat(seatnopar)=1
             THEN
                UPDATE seat_details
		SET seat_status='seattaken'
		WHERE seat_no=seatnopar;
		IF remainingitems<quantity 
		THEN 
			SELECT 'Item got over' AS message;
		ELSE 
			CALL pr_to_update_remiaining(itemidpar,quantity);
			INSERT INTO order_transaction(order_id,item_id,seat_no,food_ordered,quantity,order_time,order_status) VALUES(orderidpar,itemidpar,seatnopar,food,quantity,ordertime,'OrderPlaced');
                SELECT 'Order Placed' AS statement;		
		END IF;
	ELSE 
		SELECT 'There is no such seatno' AS message;
		END IF;
       ELSE
       UPDATE seat_details
               SET seat_status='available'
               WHERE seat_no=seatnopar;	
       SELECT 'Your items limit exceeded' AS statement;
               END IF ;
       ELSE 
       SELECT 'Item is wrongly ordered' AS statement;
       END IF;

END $$
DELIMITER ;




DROP PROCEDURE  pr_order







