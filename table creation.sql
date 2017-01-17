

CREATE TABLE sessions (
  session_id INT PRIMARY KEY NOT NULL UNIQUE,
  session_name VARCHAR(20) NOT NULL,
  from_time TIME NOT NULL,
  to_time TIME NOT NULL,
  quantity INT NOT NULL
  
)



CREATE TABLE items_list(
  Item_Id INT PRIMARY KEY NOT NULL UNIQUE,
  Session_id INT NOT NULL,
  Items VARCHAR(20) NOT NULL,
  CONSTRAINT Sid FOREIGN KEY (Session_id) REFERENCES sessions (session_id)
) 




CREATE TABLE maximum_quantity (
  sno INT  PRIMARY KEY NOT NULL ,
  max_quantity INT NOT NULL
 
) 



CREATE TABLE remaining_details (
  sno INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  se_Id INT(11) NOT NULL,
  item_id INT(11) NOT NULL UNIQUE,
  remaining INT(11) NOT NULL,
  CONSTRAINT Rid FOREIGN KEY (item_id) REFERENCES items_list (Item_Id),
  CONSTRAINT SessIdFK FOREIGN KEY (se_Id) REFERENCES sessions (session_id)
)





CREATE TABLE seat_details (
  seat_id INT PRIMARY KEY NOT NULL,
  seat_no INT NOT NULL,
  seat_status VARCHAR(20) NOT NULL
  
)




CREATE TABLE order_transaction (
  Trans_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Order_Id INT NOT NULL,
  Item_Id INT NOT NULL,
  Seat_No INT NOT NULL,
  Food_ordered VARCHAR(20) NOT NULL,
  Quantity INT NOT NULL,
  Order_Time TIME NOT NULL,
  Order_Status VARCHAR(20) NOT NULL

)


