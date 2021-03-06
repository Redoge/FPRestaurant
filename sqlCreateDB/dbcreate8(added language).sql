-- MySQL Script generated by MySQL Workbench
-- Fri Mar 11 15:59:57 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant` DEFAULT CHARACTER SET utf8 ;
USE `restaurant` ;

-- -----------------------------------------------------
-- Table `restaurant`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(24) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `role_id` INT NOT NULL,
  `language` VARCHAR(16) NOT NULL DEFAULT 'en_US',
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `restaurant`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`user_role` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `client` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`));


-- -----------------------------------------------------
-- Table `restaurant`.`category_dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`category_dishes` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`));


-- -----------------------------------------------------
-- Table `restaurant`.`dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`dishes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `category_id` INT NOT NULL,
  `price` DOUBLE UNSIGNED NOT NULL,
  `deleted` VARCHAR(5) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `restaurant`.`dishes_has_category_dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`dishes_has_category_dishes` (
  `dishes_id` INT NOT NULL,
  `category_dishes_category_id` INT NOT NULL,
  PRIMARY KEY (`dishes_id`, `category_dishes_category_id`),
  INDEX `fk_dishes_has_category_dishes_category_dishes1_idx` (`category_dishes_category_id` ASC) VISIBLE,
  INDEX `fk_dishes_has_category_dishes_dishes1_idx` (`dishes_id` ASC) VISIBLE,
  CONSTRAINT `fk_dishes_has_category_dishes_dishes1`
    FOREIGN KEY (`dishes_id`)
    REFERENCES `restaurant`.`dishes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dishes_has_category_dishes_category_dishes1`
    FOREIGN KEY (`category_dishes_category_id`)
    REFERENCES `restaurant`.`category_dishes` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `restaurant`.`user_role_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`user_role_has_user` (
  `user_role_category_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`user_role_category_id`, `user_id`),
  INDEX `fk_user_role_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_role_has_user_user_role1_idx` (`user_role_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role_has_user_user_role1`
    FOREIGN KEY (`user_role_category_id`)
    REFERENCES `restaurant`.`user_role` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `restaurant`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `restaurant`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`order` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dish` VARCHAR(255) NOT NULL,
  `count` INT UNSIGNED NOT NULL,
  `user_id` INT NOT NULL,
  `dishes_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'accepted',
  `price` DOUBLE UNSIGNED NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `dishes_id`),
  INDEX `fk_order_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_order_dishes1_idx` (`dishes_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `restaurant`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_dishes1`
    FOREIGN KEY (`dishes_id`)
    REFERENCES `restaurant`.`dishes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
