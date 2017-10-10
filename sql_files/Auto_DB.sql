-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema autoshop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema autoshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `autoshop` DEFAULT CHARACTER SET utf8 ;
USE `autoshop` ;

-- -----------------------------------------------------
-- Table `autoshop`.`SHOP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`SHOP` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`SHOP` (
  `shop_id` INT NOT NULL,
  `shop_name` VARCHAR(45) NOT NULL,
  `shop_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shop_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoshop`.`CUSTOMER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`CUSTOMER` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`CUSTOMER` (
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
-- Table `autoshop`.`CAR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`CAR` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`CAR` (
  `car_model` VARCHAR(10) NOT NULL,
  `car_make` VARCHAR(20) NOT NULL,
  `car_year` VARCHAR(4) NOT NULL,
  `car_vin` VARCHAR(15) NOT NULL,
  `shop_id` INT NOT NULL,
  `cust_id` VARCHAR(8) NOT NULL,
  `license_plate` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`car_vin`),
  CONSTRAINT `shop_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`SHOP` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cust_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`CUSTOMER` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop`.`EMPLOYEE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`EMPLOYEE` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`EMPLOYEE` (
  `emp_fname` VARCHAR(20) NOT NULL,
  `emp_lname` VARCHAR(20) NOT NULL,
  `emp_id` VARCHAR(15) NOT NULL,
  `emp_wage` VARCHAR(8) NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`emp_id`),
  CONSTRAINT `shop_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`SHOP` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop`.`INVOICE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`INVOICE` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`INVOICE` (
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
  CONSTRAINT `car_vin`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`CAR` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cust_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`CUSTOMER` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `emp_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`EMPLOYEE` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop`.`SUPPLIER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`SUPPLIER` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`SUPPLIER` (
  `supp_id` INT NOT NULL,
  `supp_name` VARCHAR(45) NOT NULL,
  `supp_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoshop`.`PART`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`PART` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`PART` (
  `part_id` VARCHAR(20) NOT NULL,
  `part_name` VARCHAR(20) NOT NULL,
  `part_cost` VARCHAR(20) NOT NULL,
  `part_num_in_inventory` VARCHAR(15) NULL DEFAULT NULL,
  `supp_id` INT NOT NULL,
  PRIMARY KEY (`part_id`, `supp_id`),
  CONSTRAINT `supp_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`SUPPLIER` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `autoshop`.`PARTS_INCLUDED`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`PARTS_INCLUDED` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`PARTS_INCLUDED` (
  `part_id` VARCHAR(20) NOT NULL,
  `inv_id` INT NOT NULL,
  PRIMARY KEY (`part_id`, `inv_id`),
  CONSTRAINT `part_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`PART` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inv_id`
    FOREIGN KEY ()
    REFERENCES `autoshop`.`INVOICE` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoshop`.`ISSUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoshop`.`ISSUE` ;

CREATE TABLE IF NOT EXISTS `autoshop`.`ISSUE` (
  `issue_id` INT NOT NULL,
  `cust_id` VARCHAR(8) NOT NULL,
  `car_vin` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) NULL,
  PRIMARY KEY (`issue_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;