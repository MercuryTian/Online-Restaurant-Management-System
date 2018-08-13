-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Restaurant
-- -----------------------------------------------------
-- Developed by Mercury & Henry.

-- -----------------------------------------------------
-- Schema Restaurant
--
-- Developed by Mercury & Henry.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Restaurant` DEFAULT CHARACTER SET utf8 ;
USE `Restaurant` ;

-- -----------------------------------------------------
-- Table `Restaurant`.`Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Table` (
  `table_NO` INT(4) NOT NULL COMMENT '桌号，从0001到9999',
  `custom_ID` BIGINT(8) NOT NULL COMMENT '当前用餐会员编号',
  `capacity` INT(2) NOT NULL COMMENT '容纳人数',
  `used` INT(1) NOT NULL COMMENT '是否被占用，0表示未被占用，1表示被占用',
  PRIMARY KEY (`table_NO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Customer` (
  `cutomer_ID` BIGINT(8) NOT NULL COMMENT '会员编号',
  `customer_name` VARCHAR(20) NOT NULL,
  `customer_tel` BIGINT(11) NOT NULL COMMENT '电话，长度只能为8位或11位',
  `customer_key` VARCHAR(20) NOT NULL COMMENT '账户密码，只能包括A-z，0-9及10个特殊符号',
  `balance` DOUBLE NOT NULL,
  `history` VARCHAR(20) NOT NULL COMMENT '历史点餐信息，记录上次菜单中的随机两个菜品',
  `credit` BIGINT(10) NOT NULL COMMENT '积分',
  `date` DATE NOT NULL COMMENT '开户日期，MYSQL的字符设置格式为YYYY-MM-DD',
  PRIMARY KEY (`cutomer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Staff` (
  `staff_ID` BIGINT(8) NOT NULL,
  `staff_name` VARCHAR(20) NOT NULL,
  `staff_key` VARCHAR(20) NOT NULL,
  `staff_tel` BIGINT(11) NOT NULL,
  `wage` DOUBLE NOT NULL,
  `salary` DOUBLE NOT NULL,
  `position` VARCHAR(6) NULL COMMENT '职位：高级管理员，前台服务员，销售统计员，人事管理员',
  PRIMARY KEY (`staff_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Order` (
  `order_ID` BIGINT(13) NOT NULL,
  `table_NO` INT(4) NOT NULL COMMENT '从0001-9999',
  `customer_ID` BIGINT(8) NOT NULL,
  `order_date` DATE NOT NULL COMMENT '订单日期，默认格式是YYYY-MM-DD',
  `staff_ID` BIGINT(8) NOT NULL COMMENT '经办员工工号',
  `order_menu` VARCHAR(400) NOT NULL COMMENT '所点菜品，记录三位的菜品编号，中间用空格相隔',
  `expenditure` DOUBLE NOT NULL COMMENT '消费金额',
  `discount` BIGINT(20) NULL COMMENT '折扣信息，记录计算折扣的菜品编号，以空格间隔',
  `people` TINYINT(2) NOT NULL COMMENT '用餐人数，值小于20',
  `memo` VARCHAR(60) NULL COMMENT '忌口备注',
  PRIMARY KEY (`order_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`PreOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`PreOrder` (
  `table_NO` INT(4) NOT NULL,
  `customer_ID` BIGINT(8) NOT NULL,
  `preorder_date` DATE NOT NULL,
  `customer_name` VARCHAR(20) NOT NULL,
  `people` TINYINT(2) NOT NULL,
  `customer_tel` BIGINT(11) NOT NULL,
  PRIMARY KEY (`table_NO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Menu` (
  `menu_NO` INT(3) NOT NULL,
  `menu_name` VARCHAR(20) NOT NULL,
  `price` DOUBLE NOT NULL,
  `discount` BIGINT(20) NOT NULL,
  `left_amount` INT(5) NOT NULL,
  PRIMARY KEY (`menu_NO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Profit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Profit` (
  `profit_date` DATE NOT NULL,
  `day_profit` DOUBLE NOT NULL,
  `day_out` DOUBLE NOT NULL,
  `day_in` DOUBLE NOT NULL,
  `month_profit` DOUBLE NOT NULL,
  PRIMARY KEY (`profit_date`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
