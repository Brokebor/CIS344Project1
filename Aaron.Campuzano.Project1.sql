-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clients` (
  `ClientName` VARCHAR(45) NOT NULL,
  `PhoneNumber` INT NULL,
  `Address` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`ClientName`),
  UNIQUE INDEX `PhoneNumber_UNIQUE` (`PhoneNumber` ASC) VISIBLE,
  UNIQUE INDEX `Address_UNIQUE` (`Address` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Expenses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Expenses` (
  `GrossExpenses` INT NOT NULL,
  `CleaningSupplies` INT NOT NULL,
  `Payroll` INT NOT NULL,
  `Cleaningtools` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`GrossExpenses`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cleaning`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cleaning` (
  `TotalCleaningFee` INT NOT NULL,
  `StartTime` TIME NOT NULL,
  `EndTime` TIME NOT NULL,
  `LaborCosts` INT NOT NULL,
  `Expenses_GrossExpenses` INT NOT NULL,
  PRIMARY KEY (`TotalCleaningFee`, `Expenses_GrossExpenses`),
  INDEX `fk_Cleaning_Expenses1_idx` (`Expenses_GrossExpenses` ASC) VISIBLE,
  CONSTRAINT `fk_Cleaning_Expenses1`
    FOREIGN KEY (`Expenses_GrossExpenses`)
    REFERENCES `mydb`.`Expenses` (`GrossExpenses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clients_has_Cleaning`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clients_has_Cleaning` (
  `Clients_ClientName` VARCHAR(45) NOT NULL,
  `Cleaning_TotalCleaningFee` INT NOT NULL,
  PRIMARY KEY (`Clients_ClientName`, `Cleaning_TotalCleaningFee`),
  INDEX `fk_Clients_has_Cleaning_Cleaning1_idx` (`Cleaning_TotalCleaningFee` ASC) VISIBLE,
  INDEX `fk_Clients_has_Cleaning_Clients_idx` (`Clients_ClientName` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_has_Cleaning_Clients`
    FOREIGN KEY (`Clients_ClientName`)
    REFERENCES `mydb`.`Clients` (`ClientName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clients_has_Cleaning_Cleaning1`
    FOREIGN KEY (`Cleaning_TotalCleaningFee`)
    REFERENCES `mydb`.`Cleaning` (`TotalCleaningFee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cleaning_has_Cleaning`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cleaning_has_Cleaning` (
  `Cleaning_TotalCleaningFee` INT NOT NULL,
  `Cleaning_Expenses_GrossExpenses` INT NOT NULL,
  `Cleaning_TotalCleaningFee1` INT NOT NULL,
  `Cleaning_Expenses_GrossExpenses1` INT NOT NULL,
  PRIMARY KEY (`Cleaning_TotalCleaningFee`, `Cleaning_Expenses_GrossExpenses`, `Cleaning_TotalCleaningFee1`, `Cleaning_Expenses_GrossExpenses1`),
  INDEX `fk_Cleaning_has_Cleaning_Cleaning2_idx` (`Cleaning_TotalCleaningFee1` ASC, `Cleaning_Expenses_GrossExpenses1` ASC) VISIBLE,
  INDEX `fk_Cleaning_has_Cleaning_Cleaning1_idx` (`Cleaning_TotalCleaningFee` ASC, `Cleaning_Expenses_GrossExpenses` ASC) VISIBLE,
  CONSTRAINT `fk_Cleaning_has_Cleaning_Cleaning1`
    FOREIGN KEY (`Cleaning_TotalCleaningFee` , `Cleaning_Expenses_GrossExpenses`)
    REFERENCES `mydb`.`Cleaning` (`TotalCleaningFee` , `Expenses_GrossExpenses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cleaning_has_Cleaning_Cleaning2`
    FOREIGN KEY (`Cleaning_TotalCleaningFee1` , `Cleaning_Expenses_GrossExpenses1`)
    REFERENCES `mydb`.`Cleaning` (`TotalCleaningFee` , `Expenses_GrossExpenses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
