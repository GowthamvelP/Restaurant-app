

DELIMITER $$
CREATE PROCEDURE pr_orderplease(orderidpar INT,seatnopar INT,food VARCHAR(20),ordertime TIME,Quantity INT)
BEGIN 
 

DECLARE RemainingItems INT; 
DECLARE SessionIdPar INT;
DECLARE seatid INT;
DECLARE itemidpar INT;
DECLARE maxlimit INT;
SET SessionIdPar=(SELECT Session_id FROM sessions WHERE ordertime BETWEEN From_time AND To_time);
SET itemidpar=(SELECT Item_Id FROM items_list WHERE Items=food AND Session_id=sessionidPar);
SET maxlimit=(SELECT COUNT(DISTINCT(Food_ordered)) FROM order_transaction WHERE Seat_No=seatnopar);
    IF SessionIdPar=(SELECT Session_id FROM items_list WHERE Item_Id=itemidpar)
    THEN
        IF fn_check_itemslimit(maxlimit)=1
        THEN
             IF fn_check_seat(seatnopar)=1
             THEN
                UPDATE seat_details
		SET Seat_Status='SeatTaken'
		WHERE Seat_No=seatnopar;
		SELECT remaining INTO RemainingItems FROM remaining_details WHERE Item_Id=itemidpar;
		IF RemainingItems<Quantity 
		THEN 
			SELECT 'Item got over' AS message;
		ELSE 
			UPDATE remaining_details
			SET remaining=RemainingItems-Quantity
			WHERE Item_Id=itemidpar;
			INSERT INTO order_transaction(order_id,Item_Id,Seat_No,Food_ordered,Quantity,Order_Time,Order_Status) VALUES(orderidpar,itemidpar,seatnopar,food,Quantity,ordertime,'OrderPlaced');
                SELECT 'Order Placed' AS statement;		
		END IF;
	ELSE 
		SELECT 'There is no such seatno' AS message;
		END IF;
       ELSE
       UPDATE seat_details
               SET Seat_Status='Available'
               WHERE Seat_No=seatnopar;	
       SELECT 'Your items limit exceeded' AS statement;
               END IF ;
       ELSE 
       SELECT 'Item is wrongly ordered' AS statement;
       END IF;

END $$
DELIMITER ;




DROP PROCEDURE  pr_orderplease







