drop SCHEMA `metro_dwh` ;  
CREATE SCHEMA `metro_dwh` ;  

-- PRODUCTS TABLE
CREATE TABLE `metro_dwh`.`product` (
  `idProduct` VARCHAR(45) NOT NULL,
  `Product_Name` VARCHAR(45) NULL,
  `Unit_Price` FLOAT NULL,
  PRIMARY KEY (`idProduct`));

-- time  table
CREATE TABLE `metro_dwh`.`time` (
  `idTime` VARCHAR(45) NOT NULL,
  `T_date` VARCHAR(45) NULL,
  `day` INT NULL,
  `t_month` INT NULL,
  `year` INT NULL,
   `t_Quarter` INT NULL,
  PRIMARY KEY (`idTime`));
  
-- location Table
CREATE TABLE `metro_dwh`.`location` (
  `id_Store` VARCHAR(45) NOT NULL,
  `StoreName` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Store`));


  -- supplier table
CREATE TABLE `metro_dwh`.`supplier` (
  `idSupplier` VARCHAR(45) NOT NULL,
  `supplierName` VARCHAR(45) NULL,
  PRIMARY KEY (`idSupplier`));
-- customers
CREATE TABLE `metro_dwh`.`customers` (
  `idCustomers` VARCHAR(45) NOT NULL,
  `customersName` VARCHAR(45) NULL,
  PRIMARY KEY (`idCustomers`));

CREATE TABLE `metro_dwh`.`transactions` (
  `transaction_id` INT NOT NULL,
  `custId` VARCHAR(45) NULL,
  `productId` VARCHAR(45) NULL,
  `timeId` VARCHAR(45) NULL,
  `StoreId` VARCHAR(45) NULL, 
  `supplierID` VARCHAR(45) NULL,
  `Quantity` INT NULL,
  `Sales` FLOAT NULL,
  PRIMARY KEY (`transaction_id`)
  
);
ALTER TABLE `metro_dwh`.`transactions` 
ADD INDEX `custid_idx` (`custId` ASC) VISIBLE,
ADD INDEX `prodid_idx` (`productId` ASC) VISIBLE,
ADD INDEX `timeid_idx` (`timeId` ASC) VISIBLE,
ADD INDEX `storeid_idx` (`StoreId` ASC) VISIBLE,
ADD INDEX `supplierid_idx` (`supplierID` ASC) VISIBLE;
;
ALTER TABLE `metro_dwh`.`transactions` 
ADD CONSTRAINT `custid`
  FOREIGN KEY (`custId`)
  REFERENCES `metro_dwh`.`customers` (`idCustomers`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `prodid`
  FOREIGN KEY (`productId`)
  REFERENCES `metro_dwh`.`product` (`idProduct`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `timeid`
  FOREIGN KEY (`timeId`)
  REFERENCES `metro_dwh`.`time` (`idTime`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `storeid`
  FOREIGN KEY (`StoreId`)
  REFERENCES `metro_dwh`.`location` (`id_Store`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `supplierid`
  FOREIGN KEY (`supplierID`)
  REFERENCES `metro_dwh`.`supplier` (`idSupplier`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;







