DELIMITER $$
CREATE
   
    PROCEDURE pr_multimenu(seatno INT,IN orderlist MEDIUMTEXT,order_time TIME,IN quantitylist MEDIUMTEXT)
    
    BEGIN
          DECLARE order_id_par INT;
          DECLARE oneorder TEXT DEFAULT NULL ;
          DECLARE length_oneorder INT DEFAULT NULL;
          DECLARE trimmedorder TEXT DEFAULT NULL;
          DECLARE onequantity TEXT DEFAULT NULL ;
          DECLARE length_onequantity INT DEFAULT NULL;
          DECLARE trimmedquantity TEXT DEFAULT NULL;
          SET order_id_par=(FLOOR(100+RAND()*(900)));

         iterator :
         LOOP    
            IF LENGTH(TRIM(orderlist)) = 0 OR orderlist IS NULL OR LENGTH(TRIM(quantitylist)) = 0 OR quantitylist IS NULL THEN
              LEAVE iterator;
              END IF;
  
   
                 SET oneorder = SUBSTRING_INDEX(orderlist,',',1);
                 SET length_oneorder = LENGTH(oneorder);
                 SET trimmedorder = TRIM(oneorder);
                 
                 SET onequantity = SUBSTRING_INDEX(quantitylist,',',1);
                 SET length_onequantity = LENGTH(onequantity);
                 SET trimmedquantity = TRIM(onequantity);
                 
                 CALL pr_orderplease(order_id_par,seatno,oneorder,order_time,onequantity);
                 
                   SET orderlist = INSERT(orderlist,1,length_oneorder + 1,'');
                   SET quantitylist = INSERT(quantitylist,1,length_onequantity + 1,'');

         END LOOP;       
    END$$
DELIMITER ;
DROP PROCEDURE pr_multimenu
CALL pr_multimenu(106,'idly,vada,poori,pongal,coffee,tea','09:00','10,10,10,10,10,10')



SELECT * FROM order_transaction
TRUNCATE TABLE order_transaction