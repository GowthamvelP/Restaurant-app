DELIMITER $$
CREATE
   
    PROCEDURE pr_multi_menu(seat_no INT,IN order_list MEDIUMTEXT,order_time TIME,IN quantity_list MEDIUMTEXT)
    
    BEGIN
          DECLARE order_id_par INT;
          DECLARE one_order TEXT DEFAULT NULL ;
          DECLARE length_one_order INT DEFAULT NULL;
          DECLARE trimmed_order TEXT DEFAULT NULL;
          DECLARE one_quantity TEXT DEFAULT NULL ;
          DECLARE length_one_quantity INT DEFAULT NULL;
          DECLARE trimmed_quantity TEXT DEFAULT NULL;
          SET order_id_par=(FLOOR(100+RAND()*(900)));

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
                 
                 CALL pr_order(order_id_par,seat_no,one_order,order_time,one_quantity);
                 
                   SET order_list = INSERT(order_list,1,length_one_order + 1,'');
                   SET quantity_list = INSERT(quantity_list,1,length_one_quantity + 1,'');

         END LOOP;       
    END$$
DELIMITER ;
CALL pr_multi_menu(109,'northindianthali',CURRENT_TIME,'10')



SELECT * FROM order_transaction
