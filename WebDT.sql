#Tao db
CREATE DATABASE cellphoneshopdb;
USE cellphoneshopdb;
#Tao bang productbrands
CREATE TABLE `cellphoneshopdb`.`productbrands` (
 `productBrand` VARCHAR(20) NOT NULL , 
`description` VARCHAR(255) NOT NULL , 
`countryOrigin` VARCHAR(255) NOT NULL , 
`image` BLOB NOT NULL ,
 PRIMARY KEY (`productBrand`)
) ENGINE = InnoDB;
#Tao bang products
CREATE TABLE `cellphoneshopdb`.`products` (
 `productID` INT(15) NOT NULL AUTO_INCREMENT ,
 `productName` VARCHAR(60) NOT NULL ,
 `productBrand` VARCHAR(50) NOT NULL ,
 `productScreen` VARCHAR(20) NOT NULL ,
 `productCPU` VARCHAR(50) NOT NULL ,
 `productRAM` INT(3) NOT NULL ,
 `productROM` INT(4) NOT NULL ,
 `description` VARCHAR(255) NULL ,
 `quantityInStock` SMALLINT(6) NOT NULL ,
 `buyPrice` DECIMAL(10,2) NOT NULL ,
 PRIMARY KEY (`productID`)
) ENGINE = InnoDB;
ALTER TABLE `products` ADD CONSTRAINT `product_brand` 
FOREIGN KEY (`productBrand`) 
REFERENCES `productbrands`(`productBrand`)
 ON DELETE RESTRICT ON UPDATE CASCADE;
#Bang orderdetails
CREATE TABLE `cellphoneshopdb`.`orderdetails` (
 `orderCode` INT(15) NOT NULL ,
 `productID` INT(15) NOT NULL ,
 `quantityOrdered` INT(11) NOT NULL ,
 `priceEach` DECIMAL(10,2) NOT NULL ,
 PRIMARY KEY (`orderCode`, `productID`)
) ENGINE = InnoDB;
ALTER TABLE `orderdetails` 
ADD CONSTRAINT `product_id` 
FOREIGN KEY (`productID`) REFERENCES `products`(`productID`)
 ON DELETE RESTRICT ON UPDATE CASCADE;
#Bang customers
CREATE TABLE `cellphoneshopdb`.`customers` (
 `customerID` INT(15) NOT NULL AUTO_INCREMENT ,
 `customerName` VARCHAR(50) NOT NULL ,
 `phoneNumber` VARCHAR(11) NOT NULL ,
 `address` VARCHAR(255) NOT NULL ,
 PRIMARY KEY (`customerID`)
) ENGINE = InnoDB;
#Bang orders
CREATE TABLE `cellphoneshopdb`.`orders` (
 `orderCode` INT(15) NOT NULL ,
 `customerID` INT(15) NOT NULL ,
 `orderDate` DATE NOT NULL ,
 `shippedDate` DATE NOT NULL ,
 `status` VARCHAR(50) NOT NULL ,
 PRIMARY KEY (`orderCode`)
) ENGINE = InnoDB;
ALTER TABLE `orders` ADD CONSTRAINT `cus_id` 
FOREIGN KEY (`customerID`) REFERENCES `customers`(`customerID`) 
ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `orderdetails`
 ADD CONSTRAINT `orderDetails_fk_1` FOREIGN KEY (`orderCode`)
 REFERENCES `orders` (`orderCode`)
 ON UPDATE CASCADE