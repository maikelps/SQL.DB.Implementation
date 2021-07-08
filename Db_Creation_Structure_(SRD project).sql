/*  Do not drop if it is already created */
DROP database IF EXISTS srd_store_db; 

/*Create database*/
CREATE DATABASE IF NOT EXISTS `srd_store_db` DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE 'utf8_general_ci';

/*tell which database you will use*/
USE srd_store_db;

/* Table for the category of the items */
CREATE TABLE IF NOT EXISTS `category` (
  `CATEGORY_ID` INTEGER NOT NULL DEFAULT 0,
  `CATEGORY_NAME` VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (`CATEGORY_ID`)
);

# Sex category (M=male, F=Female, B=Boy, G=Girl, U=Unknown)
CREATE TABLE IF NOT EXISTS `gender_age_category` (
  `GA_CATEGORY_ID` VARCHAR(1) NOT NULL DEFAULT 'U',
  `CATEGORY_DESCRIPTION` VARCHAR(7) DEFAULT NULL,
  PRIMARY KEY (`GA_CATEGORY_ID`)
) ;

/* Table for all the items in the store with their quantity in stock */
CREATE TABLE IF NOT EXISTS `item` (
  `ITEM_ID` INTEGER NOT NULL DEFAULT 0,
  `ITEM_NAME` VARCHAR(100) NOT NULL,
  `ITEM_PRICE` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `ITEM_QUANTITY` INTEGER NOT NULL DEFAULT 0,
  `ITEM_CATEGORY_ID` INTEGER NOT NULL DEFAULT 0,
  `SUB_CATEGORY_ID` VARCHAR(1) ,
  PRIMARY KEY (`ITEM_ID`)
) ;

CREATE TABLE IF NOT EXISTS `ratings` (
  `STARS` INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (`STARS`)
) ;

/* Table to store every item sold */
CREATE TABLE IF NOT EXISTS `sales` (
  `SALE_ID` INTEGER NOT NULL DEFAULT 0,
  `QUANTITY_SOLD` INTEGER NOT NULL DEFAULT 1,
  `SOLD_ITEM_ID` INTEGER NOT NULL,
  `RATING` INTEGER NOT NULL DEFAULT 0,
  `INVOICE_NUMBER` INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (`SALE_ID`)
) ;

/* Table to relate the items sold with clients */
CREATE TABLE IF NOT EXISTS `invoice` (
  `INVOICE_ID` INTEGER NOT NULL DEFAULT 0,
  `DATE_ISSUE` DATE NOT NULL,
  `END_DATE` DATE NOT NULL,
  `DISCOUNT` BOOL NOT NULL DEFAULT 0,
  `TAX_RATE` BOOL NOT NULL DEFAULT 0.23,
  `CLIENT_ID` INTEGER DEFAULT NULL,
  PRIMARY KEY (`INVOICE_ID`)
) ;

# Country:
CREATE TABLE IF NOT EXISTS `country` (
  `COUNTRY_ID` INTEGER NOT NULL DEFAULT 0,
  `COUNTRY_NAME` varchar(128) NOT NULL,
  PRIMARY KEY (`COUNTRY_ID`)
) ;

# City:
CREATE TABLE IF NOT EXISTS `city` (
  `CITY_ID` INTEGER NOT NULL DEFAULT 0,
  `CITY_NAME` VARCHAR(128) NOT NULL,
  `COUNTRY_KEY` INTEGER NOT NULL,
  PRIMARY KEY (`CITY_ID`)
) ;

CREATE TABLE IF NOT EXISTS `spending` (
  `SPENDING_ID` INTEGER NOT NULL DEFAULT 0,
  `SPENDING_CATEGORY` VARCHAR(50), # bad, worse, medium...
  PRIMARY KEY (`SPENDING_ID`)
) ;

CREATE TABLE IF NOT EXISTS `promotions` (
  `PROMOTION_ID` INTEGER NOT NULL DEFAULT 0,
  `PROMOTION_DESCRIPTION` VARCHAR(50), # bad, worse, medium...
  PRIMARY KEY (`PROMOTION_ID`)
) ;

/* Table with all client details */
CREATE TABLE IF NOT EXISTS `customers` (
  `CUSTOMER_ID` INTEGER NOT NULL DEFAULT 0,
  `CUSTOMER_NAME` VARCHAR(50) NOT NULL,
  `LAST_NAME` VARCHAR(50),
  `EMAIL` VARCHAR(128) NOT NULL,
  `CUSTOMER_ADRESS` VARCHAR(128) NOT NULL,
  `ZIPCODE` VARCHAR(10) NOT NULL,
  `CUSTOMER_CITY` INTEGER NOT NULL DEFAULT 1,
  `BIRTHDAY` DATE,
  `VALID_PROMOTION` INTEGER NOT NULL DEFAULT 0,
  `SPENDING_SCORE` INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (`CUSTOMER_ID`)
) ;

CREATE TABLE IF NOT EXISTS log (
LOG_ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TS DATETIME NOT NULL,
USR VARCHAR(63),
EV VARCHAR(15),
MSG VARCHAR(255)
);

INSERT INTO `category` 
	(`CATEGORY_ID`, `CATEGORY_NAME`) 
VALUES
	(1, 't-shirts'),
	(2, 'sweatshirts'),
	(3, 'jackets'),
	(4, 'denims'),
	(5, 'cargos'),
	(6, 'sunglasses'),
	(7, 'rings'),
    (8, 'shoes'),
    (9, 'socks'),
    (10, 'skirt');

INSERT INTO `gender_age_category` 
	(`GA_CATEGORY_ID`, `CATEGORY_DESCRIPTION`) 
VALUES
	('M', 'Man'),
	('W', 'Woman'),
	('B', 'Boy'),
	('G', 'Girl'),
	('U', 'Unisex')
;

INSERT INTO `item` 
	(`ITEM_ID`, `ITEM_NAME`, `ITEM_PRICE`, `ITEM_QUANTITY`, `ITEM_CATEGORY_ID`,`SUB_CATEGORY_ID`) 
VALUES
	(1, 'Coca Cola t-shirt', 10, 6, 1, 'M'),
	(2, 'Red Polo', 35, 3, 2,'B'),
	(3, 'GAP sweater', 50, 4, 3, 'M'),
	(4,  'Nike crewneck', 45, 2, 3,'W'),
	(5,  'stone wash regular-fit', 60, 8, 5,'M'),
	(6,  'camo cargos', 28, 1, 6,'M'),
	(7,  'aviator', 10, 4, 7,'W'),
	(8,  'basic grey sweater', 32, 3, 2,'B'),
	(9,  'dark blue puffer', 60, 2, 4,'U'),
	(10,  'beige cargos', 25, 9, 6,'M');
    

INSERT INTO `ratings` 
	(`STARS`) 
VALUES
	(0),
	(1),
	(2),
	(3),
	(4),
	(5);

INSERT INTO `sales` 
	(`SALE_ID`, `QUANTITY_SOLD`, `SOLD_ITEM_ID`, `RATING`,`INVOICE_NUMBER`) 
VALUES
	(1, 1, 03, 1, 1),
	(2, 2, 02, 3, 2),
	(3, 3, 05, 5, 3),
	(4, 1, 07, 2, 3),
	(5, 2, 04, 4, 4),
	(6, 1, 01, 3, 4),
	(7, 2, 05, 2, 5),
    (8, 1, 03, 1, 5),
	(9, 2, 02, 3, 5),
	(10, 3, 05, 5, 6),
	(11, 1, 07, 2, 7),
	(12, 2, 04, 4, 8),
	(13, 1, 01, 3, 9),
	(14, 2, 05, 2, 10),
	(15, 3, 05, 5, 11),
	(16, 1, 07, 2, 12),
	(17, 2, 04, 4, 13),
	(18, 1, 01, 3, 14),
	(19, 2, 05, 2, 15),
    (20, 3, 05, 5, 16),
	(21, 1, 07, 2, 17),
	(22, 2, 04, 4, 18),
	(23, 1, 01, 3, 19),
	(24, 2, 05, 2, 20),
    (25, 3, 05, 5, 20),
	(26, 1, 07, 2, 21),
	(27, 2, 04, 4, 22),
	(28, 1, 01, 3, 23),
	(29, 2, 05, 2, 24)
;


INSERT INTO `invoice` 
	(`INVOICE_ID`, `DATE_ISSUE`, `END_DATE`,  `DISCOUNT`, `TAX_RATE`, `CLIENT_ID`) 
VALUES
	(1, '2018-05-09', '2018-05-09', 0, 0.23, 1),
	(2, '2018-05-15', '2018-05-15', 0.10, 0.23, 2),
	(3, '2018-07-30', '2018-07-30', 0, 0.23, 2),
	(4, '2018-05-05', '2018-05-05', 0, 0.23, 2),
	(5, '2018-05-17', '2018-05-17', 0, 0.23, 4),
	(6, '2018-09-30', '2018-09-30', 0, 0.23, 2),
    (7, '2018-02-09', '2018-02-10', 0, 0.23, 5),
	(8, '2019-03-19', '2019-03-20', 0.10, 0.23, 2),
	(9, '2019-05-09', '2019-05-10', 0, 0.23, 3),
	(10, '2019-07-05', '2019-07-07', 0, 0.23, 5),
	(11, '2019-10-17', '2019-10-17', 0, 0.23, 5),
	(12, '2019-09-30', '2019-09-30', 0, 0.23, 1),
    (13, '2019-08-01', '2019-08-01', 0, 0.23, 2),
	(14, '2019-09-15', '2019-09-15', 0.10, 0.23, 2),
	(15, '2019-10-08', '2019-10-08', 0, 0.23, 4),
	(16, '2019-05-05', '2019-05-05', 0, 0.23, 4),
	(17, '2019-06-17', '2019-06-17', 0, 0.23, 1),
	(18, '2019-09-30', '2019-09-30', 0, 0.23, 1),
    (19, '2020-03-09', '2020-03-09', 0, 0.23, 3),
	(20, '2020-07-17', '2020-07-17', 0.10, 0.23, 3),
	(21, '2020-09-09', '2020-09-09', 0, 0.23, 2),
	(22, '2020-10-05', '2020-10-05', 0, 0.23, 4),
	(23, '2020-11-01', '2020-11-01', 0, 0.23, 4),
	(24, '2020-11-30', '2020-11-30', 0, 0.23, 1)
;

INSERT INTO `customers` 
	(`CUSTOMER_ID`, `CUSTOMER_NAME`, `LAST_NAME`, `EMAIL`, `CUSTOMER_ADRESS`,`ZIPCODE`, `CUSTOMER_CITY`, `BIRTHDAY`,`VALID_PROMOTION`,`SPENDING_SCORE`) 
VALUES
	(1, 'João', 'César' , 'joaocesar@gmail.com', 'rua 25 de abril n12', '2660-115', 1, '1999-07-12', 0, 2),
	(2, 'Maikel', 'Sousa',  'maikelsousa@gmail.com', 'Av. Eusébio da Silva Ferreira',  '1500-313', 1, '1992-06-18', 0, 2 ),
	(3, 'Catarina', 'Moreira', 'catarinamoreira@gmail.com', 'R. de João Afonso de Aveiro', '3800-198', 2, '1998-09-22', 0, 2),
	(4, 'Mariana', 'Domingues', 'marianadomingues@gmail.com', 'Rua Doutor Joaquim Pires De Lima 294', '4200-350', 3, '1999-02-10',0, 2),
	(5, 'Luisa', 'Barral', 'luisa@gmail.com' , 'Grupo Aldapeta nº3, 2º Izq',  '48013', 4, '1999-03-30', 0, 2);


INSERT INTO `city` 
	(`CITY_ID`, `CITY_NAME`, `COUNTRY_KEY`) 
VALUES
	(1, 'Lisboa', 1),
	(2, 'Aveiro',1),
	(3, 'Porto', 1),
	(4, 'Bilbao', 2);

INSERT INTO `country` 
	(`COUNTRY_ID`, `COUNTRY_NAME`) 
VALUES
	(1, 'Portugal'),
	(2, 'Spain');

INSERT INTO 
	promotions (PROMOTION_ID, PROMOTION_DESCRIPTION)
VALUES
	( 0 , "no promotion"),
    ( 1 , "New clients 30% OFF"),
    (2 , 'BUY 1 GET 1 FREE');

INSERT INTO 
	spending (SPENDING_ID, SPENDING_CATEGORY)
VALUES
	( 0 , "no purchase volume"),
    ( 1 , "low purchase volume"),
    ( 2 , "Average purchase volume"),
    ( 3 , "High purchase volume"),
    ( 4 , "Premium client")
;

# --- First Inserting Data:
# Needed for pentaho to work, the new clients are set as a default value for 
# birthday and address details.

/*
INSERT INTO 
	country (COUNTRY_ID, COUNTRY_NAME)
VALUES
	( 1 , "Portugal"),
    ( 2 , "Spain");
    
INSERT INTO 
	city (CITY_ID, CITY_NAME, COUNTRY_KEY)
VALUES
	( 1 , "Lisbon", 1),
    ( 2 , "Porto", 1);
    
INSERT INTO 
	promotions (PROMOTION_ID, PROMOTION_DESCRIPTION)
VALUES
	( 0 , "no promotion"),
    ( 1 , "New clients promotion");

INSERT INTO 
	spending (SPENDING_ID, SPENDING_CATEGORY)
VALUES
	( 0 , "No spending"),
    ( 1 , "Low spending"),
    ( 2 , "Average spending"),
    ( 3 , "High spending"),
    ( 4 , "Premium volume spending");
    
*/

/*
# --- Second Inserting Data: ---

INSERT INTO 
	category (CATEGORY_ID, CATEGORY_NAME)
VALUES
	( 1 , "pants"),
	( 2 , "shirts"),
	( 3 , "jackets"),
	( 4 , "sweaters"),
	( 5 , "socks"),
	( 6 , "sweaters"),
	( 7 , "coats"),
	( 8 , "sport_clothing"),
	( 9 , "shoes"),
    ( 10 , "jeans");

INSERT INTO 
	gender_age_category (GA_CATEGORY_ID, CATEGORY_DESCRIPTION)
VALUES
	( "M" , "male"),
	( "F" , "female"),
	( "B" , "boy"),
	( "G" , "girl"),
    ( "U" , "unisex"),
	( "X" , "unknown");

INSERT INTO 
	item (ITEM_ID, ITEM_NAME, ITEM_PRICE, ITEM_QUANTITY, CATEGORY_ID, SUB_CATEGORY_ID)
VALUES
	( 1 , "Vintage Blue Jeans", 25.99, 10, 1, "M"),
	( 2 , "Vintage Blue Jeans", 20.99, 10, 1, "F"),
	( 3 , "Girly Vintage Shirt", 14.99, 10, 2, "F"),
	( 4 , "Girly Blouse", 20.99, 10, 2, "F"),
	( 5 , "Female Vintage Jacket", 39.99, 10, 3, "F"),
    ( 6 , "Vintage Jacket", 41.99, 10, 3, "M"),
    ( 7 , "Paris Fashion week jacket", 39.99, 10, 3, "F"),
    ( 8 , "Bob the builder socks", 7.99, 100, 5, "U"),
    ( 9 , "Winter socks", 7.99, 100, 5, "G"),
    ( 10 , "Winter socks", 7.99, 100, 5, "B"),
    ( 11 , "Coronavirus left me broke", 19.99, 40, 6, "U"),
    ( 12 , "Coronavirus Vaccine denier", 99.99, 80, 6, "U");

INSERT INTO 
	sales (SALE_ID, QUANTITY_SOLD, SOLD_ITEM_ID, INVOICE_NUMBER)
VALUES
	( 1 , 2, 1, 1),
    ( 2 , 10, 12, 1),
    ( 3 , 2, 11, 1),
    ( 4 , 2, 11, 2);

INSERT INTO 
	invoice (INVOICE_ID, DATE_ISSUE, END_DATE, SALE_DESCRIPTON, DISCOUNT, TAX_RATE, CLIENT_ID)
VALUES
	( 1 , '2020-12-11', '2020-12-13', "Just give me my stuff", 0.1, 0.23, 1),
    ( 2 , '2020-12-12', '2020-12-13', "I find the shirt funny", 0, 0.23, 1);

#Add the spending category (string)
INSERT INTO 
	customers (CUSTOMER_ID, CUSTOMER_NAME, LAST_NAME, EMAIL, CUSTOMER_ADRESS, CUSTOMER_CITY, 
    BIRTHDAY, SPENDING_SCORE, SPENDING_CAT)
VALUES
	( 1 , "José", "Mourinho", "jose.mourinho@tottenham.com", "Avenida da Liberdade", 1,
     '1963-01-26', 81, "Good"),
    ( 2 , "Fernando", "Pessoa", "fernando.pessoa@gmail.com", "Avenida da Liberdade", 1,
    '1888-06-13', 81, "Good");
*/
# --- Primary keys: ---

ALTER TABLE `item`
ADD CONSTRAINT `fk_item_category`
  FOREIGN KEY (`ITEM_CATEGORY_ID`)
  REFERENCES `srd_store_db`.`category` (`CATEGORY_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `sales`
ADD CONSTRAINT `fk_sales_items`
  FOREIGN KEY (`SOLD_ITEM_ID`)
  REFERENCES `srd_store_db`.`item` (`ITEM_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `sales`
ADD CONSTRAINT `fk_sales_invoice`
  FOREIGN KEY (`INVOICE_NUMBER`)
  REFERENCES `srd_store_db`.`invoice` (`INVOICE_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `sales`
ADD CONSTRAINT `fk_sales_ratings`
  FOREIGN KEY (`RATING`)
  REFERENCES `srd_store_db`.`ratings` (`STARS`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `invoice`
ADD CONSTRAINT `fk_invoice_customer`
  FOREIGN KEY (`CLIENT_ID`)
  REFERENCES `srd_store_db`.`customers` (`CUSTOMER_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `customers`
ADD CONSTRAINT `fk_customers_city`
  FOREIGN KEY (`CUSTOMER_CITY`)
  REFERENCES `srd_store_db`.`city` (`CITY_ID`)
  ON DELETE RESTRICT
  ON UPDATE NO ACTION;
  
ALTER TABLE `customers`
ADD CONSTRAINT `fk_customers_promotions`
  FOREIGN KEY (`VALID_PROMOTION`)
  REFERENCES `srd_store_db`.`promotions` (`PROMOTION_ID`)
  ON DELETE RESTRICT
  ON UPDATE NO ACTION;

ALTER TABLE `customers`
ADD CONSTRAINT `fk_customers_spending`
  FOREIGN KEY (`SPENDING_SCORE`)
  REFERENCES `srd_store_db`.`spending` (`SPENDING_ID`)
  ON DELETE RESTRICT
  ON UPDATE NO ACTION;
  
ALTER TABLE `city`
ADD CONSTRAINT `fk_city_country`
  FOREIGN KEY (`COUNTRY_KEY`)
  REFERENCES `srd_store_db`.`country` (`COUNTRY_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `item`
ADD CONSTRAINT `fk_item_agegender`
  FOREIGN KEY (`SUB_CATEGORY_ID`)
  REFERENCES `srd_store_db`.`gender_age_category` (`GA_CATEGORY_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


# --- TRIGGERS: ---

# C)
# UPDATE THE STOCK TRIGGER:
DROP TRIGGER IF EXISTS `stock_ai_item`;
DELIMITER $$
CREATE TRIGGER stock_ai_item
	AFTER INSERT
    ON item
    FOR EACH ROW
BEGIN
UPDATE item
SET item.ITEM_QUANTITY = item.ITEM_QUANTITY - sales.QUANTITY_SOLD
	WHERE ((item.ITEM_ID = sales.ITEM_ID) AND (sales.INVOICE_NUMBER = invoice.INVOICE_ID));
END $$
DELIMITER;

# LOG TABLE TRIGGER:
DROP TRIGGER IF EXISTS `item_au_log`;
DELIMITER $$
CREATE TRIGGER item_au_log
	AFTER UPDATE ON item
	FOR EACH ROW
BEGIN
IF (NEW.ITEM_PRICE != OLD.ITEM_PRICE) THEN
	INSERT INTO log (TS,USR,EV,MSG)
	VALUES (NOW(), USER(), "Update", CONCAT('OLD PRICE:', OLD.ITEM_PRICE,'. ', 'NEW PRICE:', NEW.ITEM_PRICE));
END IF;
END $$
DELIMITER ;

# Queries for question G

# G.1. 
/*
SELECT 
	INV.DATE_ISSUE AS PURCHASE_DATE,
    CONCAT( C.CUSTOMER_NAME, " ", C.LAST_NAME) AS CUSTOMER_NAME,
    I.ITEM_NAME AS ITEMS_SOLD
	FROM invoice AS INV
    INNER JOIN sales AS S
		ON INV.INVOICE_ID = S.INVOICE_NUMBER
    INNER JOIN customers AS C
		ON C.CUSTOMER_ID = INV.CLIENT_ID
    INNER JOIN item AS I
		ON I.ITEM_ID = S.SOLD_ITEM_ID
	WHERE INV.DATE_ISSUE BETWEEN '2019-12-11' AND '2020-12-31';
*/