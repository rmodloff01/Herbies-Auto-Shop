-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema autoshop_development
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema autoshop_development
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `autoshop_development` DEFAULT CHARACTER SET utf8 ;
USE `autoshop_development` ;

-- -----------------------------------------------------
-- Table `autoshop_development`.`SHOP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`SHOP` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`SHOP` (
  `shop_id` INT NOT NULL,
  `shop_name` VARCHAR(45) NOT NULL,
  `shop_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shop_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoshop_development`.`CUSTOMER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`CUSTOMER` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`CUSTOMER` (
  `cust_id` VARCHAR(8) NOT NULL,
  `cust_fname` VARCHAR(15) NOT NULL,
  `cust_lname` VARCHAR(15) NOT NULL,
  `cust_phone` VARCHAR(13) NOT NULL,
  `cust_addr` VARCHAR(30) NOT NULL,
  `cust_date` DATE NOT NULL,
  PRIMARY KEY (`cust_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop_development`.`CAR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`CAR` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`CAR` (
  `car_model` VARCHAR(10) NOT NULL,
  `car_make` VARCHAR(20) NOT NULL,
  `car_year` VARCHAR(4) NOT NULL,
  `car_vin` VARCHAR(15) NOT NULL,
  `shop_id` INT NOT NULL,
  `cust_id` VARCHAR(8) NOT NULL,
  `license_plate` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`car_vin`),
  INDEX `shop_id_idx` (`shop_id` ASC),
  INDEX `cust_id_idx` (`cust_id` ASC),
  CONSTRAINT `shop`
    FOREIGN KEY (`shop_id`)
    REFERENCES `autoshop_development`.`SHOP` (`shop_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cust_id`
    FOREIGN KEY (`cust_id`)
    REFERENCES `autoshop_development`.`CUSTOMER` (`cust_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop_development`.`EMPLOYEE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`EMPLOYEE` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`EMPLOYEE` (
  `emp_fname` VARCHAR(20) NOT NULL,
  `emp_lname` VARCHAR(20) NOT NULL,
  `emp_id` VARCHAR(15) NOT NULL,
  `emp_wage` VARCHAR(8) NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `shop_id_idx` (`shop_id` ASC),
  CONSTRAINT `shop_id`
    FOREIGN KEY (`shop_id`)
    REFERENCES `autoshop_development`.`SHOP` (`shop_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop_development`.`INVOICE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`INVOICE` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`INVOICE` (
  `cost_of_labor` DECIMAL(2) NULL DEFAULT NULL,
  `car_vin` VARCHAR(15) NOT NULL,
  `cust_id` VARCHAR(8) NOT NULL,
  `inv_id` INT NOT NULL,
  `emp_id` VARCHAR(15) NOT NULL,
  `inv_desc` VARCHAR(255) NULL,
  `prob_desc` VARCHAR(255) NOT NULL,
  `eng_code` VARCHAR(45) NULL,
  `inv_date` DATE NOT NULL,
  `tot_cost` DECIMAL(2) NULL,
  PRIMARY KEY (`inv_id`),
  INDEX `car_vin_idx` (`car_vin` ASC),
  INDEX `cust_id_idx` (`cust_id` ASC),
  INDEX `emp_id_idx` (`emp_id` ASC),
  CONSTRAINT `car`
    FOREIGN KEY (`car_vin`)
    REFERENCES `autoshop_development`.`CAR` (`car_vin`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cust`
    FOREIGN KEY (`cust_id`)
    REFERENCES `autoshop_development`.`CUSTOMER` (`cust_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `emp`
    FOREIGN KEY (`emp_id`)
    REFERENCES `autoshop_development`.`EMPLOYEE` (`emp_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop_development`.`SUPPLIER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`SUPPLIER` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`SUPPLIER` (
  `supp_id` INT NOT NULL,
  `supp_name` VARCHAR(45) NOT NULL,
  `supp_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoshop_development`.`PART`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`PART` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`PART` (
  `part_id` VARCHAR(20) NOT NULL,
  `part_name` VARCHAR(20) NOT NULL,
  `part_cost` VARCHAR(20) NOT NULL,
  `part_num_in_inventory` VARCHAR(15) NULL DEFAULT NULL,
  `supp_id` INT NOT NULL,
  PRIMARY KEY (`part_id`, `supp_id`),
  INDEX `supp_id_idx` (`supp_id` ASC),
  CONSTRAINT `supp_id`
    FOREIGN KEY (`supp_id`)
    REFERENCES `autoshop_development`.`SUPPLIER` (`supp_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop_development`.`PARTS_INCLUDED`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`PARTS_INCLUDED` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`PARTS_INCLUDED` (
  `part_id` VARCHAR(20) NOT NULL,
  `inv_id` INT NOT NULL,
  PRIMARY KEY (`part_id`, `inv_id`),
  INDEX `inv_id_idx` (`inv_id` ASC),
  CONSTRAINT `part_id`
    FOREIGN KEY (`part_id`)
    REFERENCES `autoshop_development`.`PART` (`part_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `inv_id`
    FOREIGN KEY (`inv_id`)
    REFERENCES `autoshop_development`.`INVOICE` (`inv_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoshop_development`.`ISSUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop_development`.`ISSUE` ;

CREATE TABLE IF NOT EXISTS `autoshop_development`.`ISSUE` (
  `issue_id` INT NOT NULL,
  `cust_id` VARCHAR(8) NOT NULL,
  `car_vin` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) NULL,
  PRIMARY KEY (`issue_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
