DELIMITER $$

CREATE EVENT ev_from_first
 ON SCHEDULE EVERY 24 HOUR
 DO BEGIN
        UPDATE remaining_details
        SET remaining=(SELECT quantity FROM sessions WHERE session_id=1)
        WHERE se_Id=1;
                UPDATE remaining_details
        SET remaining=(SELECT quantity FROM sessions WHERE session_id=2)
        WHERE se_id=2;
                      UPDATE remaining_details
        SET remaining=(SELECT quantity FROM sessions WHERE session_id=3)
        WHERE se_id=3;
                      UPDATE remaining_details
        SET remaining=(SELECT quantity FROM sessions WHERE session_id=4)
        WHERE se_id=4;
        TRUNCATE TABLE order_transaction;
END$$

DELIMITER ;


