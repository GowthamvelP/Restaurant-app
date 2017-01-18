

CREATE TABLE sessions (
  session_id INT PRIMARY KEY NOT NULL UNIQUE,
  session_name VARCHAR(20) NOT NULL,
  from_time TIME NOT NULL,
  to_time TIME NOT NULL,
  quantity INT NOT NULL
  
);



CREATE TABLE items_list(
  Item_Id INT PRIMARY KEY NOT NULL UNIQUE,
  Session_id INT NOT NULL,
  Items VARCHAR(20) NOT NULL,
  CONSTRAINT Sid FOREIGN KEY (Session_id) REFERENCES sessions (session_id)
); 



CREATE TABLE

CREATE TABLE maximum_quantity (
  sno INT PRIMARY KEY NOT NULL,
  day_name VARCHAR(20) NOT NULL,
  max_quantity INT NOT NULL
);


CREATE TABLE remaining_details (
  sno INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  se_Id INT(11) NOT NULL,
  item_id INT(11) NOT NULL UNIQUE,
  remaining INT(11) NOT NULL,
  CONSTRAINT Rid FOREIGN KEY (item_id) REFERENCES items_list (Item_Id),
  CONSTRAINT SessIdFK FOREIGN KEY (se_Id) REFERENCES sessions (session_id)
);





CREATE TABLE seat_details (
  seat_id INT PRIMARY KEY NOT NULL UNIQUE,
  seat_no INT NOT NULL,
  seat_status VARCHAR(20) NOT NULL
  
);




CREATE TABLE order_transaction (
  trans_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  order_Id INT NOT NULL,
  item_Id INT NOT NULL UNIQUE,
  seat_No INT NOT NULL UNIQUE,
  food_ordered VARCHAR(20) NOT NULL,
  quantity INT NOT NULL,
  order_Time TIME NOT NULL,
  order_Status VARCHAR(20) NOT NULL 

);

INSERT INTO sessions VALUES(1,breakfast,'08:00:00','11:00:00',100),(2,lunch,'11:15:00','15:00:00',75),(3,refreshment,'15:00:00','23:00:00',200),(4,dinner,'19:00:00','23:00:00',100);
INSERT INTO items_list VALUES(1,1,'idly'),(2,1,'vada'),(3,1,'dosa'),(4,1,'poori'),(5,1,'pongal'),(6,1,'coffee'),(7,1,'tea'),(8,2,'southindianmeals'),(9,2,'northindianmeals'),(10,2,'varietyrice'),(11,3,'coffee'),(12,3,'tea'),(13,3,'snacks'),(14,4,'friedrice'),(15,4,'chappathi'),(16,4,'chatitems');
INSERT INTO  maximum_quantity VALUES(1,week_day,4);
INSERT INTO seat_details VALUES(1,101,'available'),(2,102,'available'),(3,103,'available'),(4,104,'available'),(5,105,'available'),(6,106,'available'),(7,107,'available'),(8,108,'available'),(9,109,'available'),(10,110,'available');
INSERT INTO remaining_details(se_id,item_id,remaining) VALUES(1,1,100),(1,2,100),(1,3,100),(1,4,100),(1,5,100),(1,6,100),(1,7,100),(2,8,75),(2,9,75),(2,10,75),(3,11,200),(3,12,200),(3,13,200),(4,14,100),(4,15,100),(4,16,100);
