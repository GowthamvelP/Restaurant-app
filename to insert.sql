DELIMITER $$
CREATE
   
    PROCEDURE pr_multi_menu(seat_no INT,IN order_list VARCHAR(100),order_time TIME,IN quantity_list VARCHAR(50),OUT message_status VARCHAR(200))
    
    BEGIN
          DECLARE order_id_par INT;
          DECLARE one_order TEXT DEFAULT NULL ;
          DECLARE length_one_order INT DEFAULT NULL;
          DECLARE trimmed_order TEXT DEFAULT NULL;
          DECLARE one_quantity TEXT DEFAULT NULL ;
          DECLARE length_one_quantity INT DEFAULT NULL;
          DECLARE trimmed_quantity TEXT DEFAULT NULL;
          			SET order_id_par=(SELECT IFNULL(MAX(order_id),0)+1 FROM order_transaction);

      SET message_status='';
         iterator :
         LOOP    
            IF LENGTH(TRIM(order_list)) = 0 OR order_list IS NULL OR LENGTH(TRIM(quantity_list)) = 0 OR quantity_list IS NULL THEN
              LEAVE iterator;
              END IF;
  
   
                 SET one_order = SUBSTRING_INDEX(order_list,',',1);
                 SET length_one_order = LENGTH(one_order);
                 SET trimmed_order = TRIM(one_order);
                 
                 SET one_quantity = SUBSTRING_INDEX(quantity_list,',',1);
                 SET length_one_quantity = LENGTH(one_quantity);
                 SET trimmed_quantity = TRIM(one_quantity);
                 
                 CALL pr_order(order_id_par,seat_no,one_order,order_time,one_quantity,@message);
                       SET message_status=CONCAT(message_status,'  ',@message); 
			SELECT message_status;
                   SET order_list = INSERT(order_list,1,length_one_order + 1,'');
                   SET quantity_list = INSERT(quantity_list,1,length_one_quantity + 1,'');

         END LOOP; 
         
    
     
    END$$
DELIMITER ;
CALL pr_multi_menu(101,'idly','09:00','2,2,2,2,2,2',@message);


SELECT * FROM order_transaction;

