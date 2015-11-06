-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema beraudent
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema beraudent
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `beraudent` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `beraudent` ;

-- -----------------------------------------------------
-- Table `beraudent`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Cliente` (
  `id_clie` INT NOT NULL AUTO_INCREMENT,
  `nomb_clie` VARCHAR(25) NOT NULL,
  `razo_clie` VARCHAR(45) NULL,
  `rut_clie` VARCHAR(10) NULL,
  PRIMARY KEY (`id_clie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`arancel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`arancel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NULL,
  `detalle` VARCHAR(45) NULL COMMENT 'deta_aran informará como se construyó el arancel (si deriba de algun porcentaje sobre algun arancel base o es un arancel con precios especiales)',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Datos_Facturacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Datos_Facturacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `grupo_facturacion` VARCHAR(45) NOT NULL,
  `razon_social` VARCHAR(45) NOT NULL,
  `nombre_fantasia` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `rut` VARCHAR(45) NOT NULL,
  `detalle` VARCHAR(45) NULL,
  `Cliente_id_clie` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Datos_Facturacion_Cliente1_idx` (`Cliente_id_clie` ASC),
  CONSTRAINT `fk_Datos_Facturacion_Cliente1`
    FOREIGN KEY (`Cliente_id_clie`)
    REFERENCES `beraudent`.`Cliente` (`id_clie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`sucursal` (
  `id` INT NOT NULL,
  `codigo` VARCHAR(10) NULL,
  `abreviatura` VARCHAR(10) NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `alias` VARCHAR(45) NULL,
  `Arancel_id_aran` INT NOT NULL,
  `Cliente_id_clie` INT NOT NULL,
  `Datos_Facturacion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sucursal_Arancel1_idx` (`Arancel_id_aran` ASC),
  INDEX `fk_Sucursal_Cliente1_idx` (`Cliente_id_clie` ASC),
  INDEX `fk_Sucursal_Datos_Facturacion1_idx` (`Datos_Facturacion_id` ASC),
  CONSTRAINT `fk_Sucursal_Arancel1`
    FOREIGN KEY (`Arancel_id_aran`)
    REFERENCES `beraudent`.`arancel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_Cliente1`
    FOREIGN KEY (`Cliente_id_clie`)
    REFERENCES `beraudent`.`Cliente` (`id_clie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_Datos_Facturacion1`
    FOREIGN KEY (`Datos_Facturacion_id`)
    REFERENCES `beraudent`.`Datos_Facturacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`odontologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`odontologo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apellidos` VARCHAR(45) NULL,
  `nombres` VARCHAR(45) NULL,
  `email` VARCHAR(25) NULL,
  `celular` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Administrativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Administrativo` (
  `id_admi` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nomb_admi` VARCHAR(35) NULL,
  `apel_admi` VARCHAR(35) NULL,
  `mail_admi` VARCHAR(35) NULL,
  `celu_admi` VARCHAR(10) NULL,
  `carg_admi` VARCHAR(15) NULL,
  `tele_admi` VARCHAR(10) NULL,
  `Cliente_id_clie` INT NOT NULL,
  PRIMARY KEY (`id_admi`, `Cliente_id_clie`),
  INDEX `fk_Administrativo_Cliente1_idx` (`Cliente_id_clie` ASC),
  CONSTRAINT `fk_Administrativo_Cliente1`
    FOREIGN KEY (`Cliente_id_clie`)
    REFERENCES `beraudent`.`Cliente` (`id_clie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Personal` (
  `id_pers` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nomb_pers` VARCHAR(35) NULL,
  `apel_pers` VARCHAR(35) NULL,
  `mail_pers` VARCHAR(35) NULL,
  `celu_pers` VARCHAR(10) NULL,
  `carg_pers` VARCHAR(15) NULL,
  `tele_pers` VARCHAR(45) NULL,
  `Sucursal_id_sucu` INT NOT NULL,
  PRIMARY KEY (`id_pers`, `Sucursal_id_sucu`),
  INDEX `fk_Personal_Sucursal1_idx` (`Sucursal_id_sucu` ASC),
  CONSTRAINT `fk_Personal_Sucursal1`
    FOREIGN KEY (`Sucursal_id_sucu`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`paciente` (
  `id` INT UNSIGNED NOT NULL,
  `rut` VARCHAR(10) NULL,
  `apellidos` VARCHAR(45) NULL,
  `nombres` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`sucursal_odontologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`sucursal_odontologo` (
  `id_sucursal-so` INT NOT NULL,
  `id_odontologo-so` INT NOT NULL,
  PRIMARY KEY (`id_sucursal-so`, `id_odontologo-so`),
  INDEX `fk_sucursal_has_odontologo_odontologo1_idx` (`id_odontologo-so` ASC),
  INDEX `fk_sucursal_has_odontologo_sucursal1_idx` (`id_sucursal-so` ASC),
  CONSTRAINT `fk_sucursal_has_odontologo_sucursal1`
    FOREIGN KEY (`id_sucursal-so`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sucursal_has_odontologo_odontologo1`
    FOREIGN KEY (`id_odontologo-so`)
    REFERENCES `beraudent`.`odontologo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`orden_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`orden_trabajo` (
  `ot` VARCHAR(10) NOT NULL,
  `ticket` VARCHAR(10) NULL,
  `fecha_ingreso` DATETIME NULL,
  `fecha_entrega` DATETIME NULL,
  `detalle` TEXT(100) NULL,
  `suministros_enviados` VARCHAR(45) NULL,
  `id_paciente-ot` INT UNSIGNED NOT NULL,
  `id_sucursal-so-ot` INT NOT NULL,
  `id_odontologo-so-ot` INT NOT NULL,
  INDEX `fk_Orden_Trabajo_Paciente1_idx` (`id_paciente-ot` ASC),
  PRIMARY KEY (`ot`),
  INDEX `fk_orden_trabajo_sucursal_odontologo1_idx` (`id_sucursal-so-ot` ASC, `id_odontologo-so-ot` ASC),
  CONSTRAINT `fk_Orden_Trabajo_Paciente1`
    FOREIGN KEY (`id_paciente-ot`)
    REFERENCES `beraudent`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orden_trabajo_sucursal_odontologo1`
    FOREIGN KEY (`id_sucursal-so-ot` , `id_odontologo-so-ot`)
    REFERENCES `beraudent`.`sucursal_odontologo` (`id_sucursal-so` , `id_odontologo-so`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`docped`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`docped` (
  `numero` VARCHAR(10) NOT NULL,
  `episodio` VARCHAR(10) NULL COMMENT 'Existen raros casos donde hay mas de un episodio por solped, colocarlo com nota',
  `id_paciente-d` INT UNSIGNED NOT NULL,
  `id_sucursal-so-d` INT NOT NULL,
  `id_odontologo-so-d` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_docped_paciente1_idx` (`id_paciente-d` ASC),
  INDEX `fk_docped_sucursal_odontologo1_idx` (`id_sucursal-so-d` ASC, `id_odontologo-so-d` ASC),
  CONSTRAINT `fk_docped_paciente1`
    FOREIGN KEY (`id_paciente-d`)
    REFERENCES `beraudent`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_docped_sucursal_odontologo1`
    FOREIGN KEY (`id_sucursal-so-d` , `id_odontologo-so-d`)
    REFERENCES `beraudent`.`sucursal_odontologo` (`id_sucursal-so` , `id_odontologo-so`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `detalle` VARCHAR(100) NULL,
  `etapa` ENUM('I', 'P', 'T') NULL,
  `Prestacion_id` INT NOT NULL COMMENT 'AL SER UNA CLAVE FORANEA, no puede ser un valor nulo por lo que cuando es una prestacion que no tiene proces, colocar el mismo codigo',
  PRIMARY KEY (`id`),
  INDEX `fk_Prestacion_Prestacion1_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Prestacion_Prestacion1`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`comprobante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`comprobante` (
  `id` VARCHAR(10) NOT NULL COMMENT 'sera una cadena generada por el numero y el tipo de comprobante\n',
  `numero` VARCHAR(10) NULL,
  `tipo` ENUM('F', 'B', 'FE', 'BE', 'NC', 'ND', 'CE', 'DE') NULL,
  `fecha` DATE NULL,
  `referencia` VARCHAR(30) NULL,
  `rut_cliente` VARCHAR(10) NULL,
  `razon_cliente` VARCHAR(45) NULL,
  `detalle` VARCHAR(45) NULL,
  `valor_neto` FLOAT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`grupo_cancelacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`grupo_cancelacion` (
  `id` INT NOT NULL,
  `periodo` VARCHAR(15) NULL,
  `monto` FLOAT NULL,
  `detalle` VARCHAR(45) NULL,
  `id_comprobante-gc` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_grupo_cancelacion_comprobante1_idx` (`id_comprobante-gc` ASC),
  CONSTRAINT `fk_grupo_cancelacion_comprobante1`
    FOREIGN KEY (`id_comprobante-gc`)
    REFERENCES `beraudent`.`comprobante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Trabajo_Realizado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Trabajo_Realizado` (
  `id` INT NOT NULL,
  `piezas` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `color` VARCHAR(50) NULL,
  `detalle` VARCHAR(45) NULL,
  `id_orden_trabajo` VARCHAR(10) NOT NULL,
  `id_trabajo` INT NOT NULL,
  `grupo_cancelacion_id` INT NOT NULL,
  INDEX `fk_Trabajo_Realizado_Orden_Trabajo1_idx` (`id_orden_trabajo` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_Trabajo_Realizado_trabajo1_idx` (`id_trabajo` ASC),
  INDEX `fk_Trabajo_Realizado_grupo_cancelacion1_idx` (`grupo_cancelacion_id` ASC),
  CONSTRAINT `fk_Trabajo_Realizado_Orden_Trabajo1`
    FOREIGN KEY (`id_orden_trabajo`)
    REFERENCES `beraudent`.`orden_trabajo` (`ot`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajo_Realizado_trabajo1`
    FOREIGN KEY (`id_trabajo`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajo_Realizado_grupo_cancelacion1`
    FOREIGN KEY (`grupo_cancelacion_id`)
    REFERENCES `beraudent`.`grupo_cancelacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Ubicacion` (
  `id_ubic` INT NOT NULL AUTO_INCREMENT,
  `dire_ubic` VARCHAR(30) NOT NULL,
  `tipo_dire` CHAR(2) NULL,
  `num_ubic` MEDIUMINT(3) NOT NULL,
  `depa_ubic` VARCHAR(5) NULL,
  `comu_ubic` VARCHAR(15) NULL,
  `regi_ubic` VARCHAR(45) NULL,
  `tel1_ubic` VARCHAR(45) NULL,
  `tel2_ubic` VARCHAR(45) NULL,
  `Sucursal_id_sucu` INT NOT NULL,
  PRIMARY KEY (`id_ubic`, `Sucursal_id_sucu`),
  INDEX `fk_Ubicacion_Sucursal1_idx` (`Sucursal_id_sucu` ASC),
  CONSTRAINT `fk_Ubicacion_Sucursal1`
    FOREIGN KEY (`Sucursal_id_sucu`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Abono_Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Abono_Cargo` (
  `id_abon_carg` INT NOT NULL,
  `deta_abon_carg` VARCHAR(45) NULL,
  `Trabajo_Pedido_Arancel_Trabajo_Trabajo_id_trab` INT NOT NULL,
  `Trabajo_Pedido_Arancel_Trabajo_Arancel_id_aran` INT NOT NULL,
  `Orden_Compra_id_orde_comp` INT UNSIGNED NOT NULL,
  `mont_abon_carg` INT NULL,
  PRIMARY KEY (`id_abon_carg`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_turkish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`pago` (
  `id` INT NOT NULL,
  `numero_recibo` VARCHAR(8) NULL,
  `fecha_recibo` DATETIME NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`item` (
  `codigo` VARCHAR(10) NOT NULL,
  `precio` FLOAT NULL,
  `id_arancel-i` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_item_arancel_arancel1_idx` (`id_arancel-i` ASC),
  CONSTRAINT `fk_item_arancel_arancel1`
    FOREIGN KEY (`id_arancel-i`)
    REFERENCES `beraudent`.`arancel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`orden_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`orden_compra` (
  `numero` VARCHAR(10) NOT NULL,
  `fecha` DATE NULL,
  `monto` FLOAT NULL,
  `detalle` VARCHAR(45) NULL,
  `id_comprobante-oc` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_orden_compra_comprobante1_idx` (`id_comprobante-oc` ASC),
  CONSTRAINT `fk_orden_compra_comprobante1`
    FOREIGN KEY (`id_comprobante-oc`)
    REFERENCES `beraudent`.`comprobante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`prestacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`prestacion` (
  `numero_docped-p` VARCHAR(10) NOT NULL,
  `posicion` TINYINT(1) UNSIGNED NOT NULL,
  `fecha_registro` DATE NULL,
  `fecha_entrega` DATE NULL,
  `cant_pres` TINYINT(1) UNSIGNED NULL,
  `precio` FLOAT NOT NULL,
  `null_pres` ENUM('V', 'N') NULL DEFAULT 'V' COMMENT 'las posiciones pueden anularse con basurero, bomba  o valor total=0\nsiempre es bueno tener respald de que posicion esta nula',
  `detalle` VARCHAR(45) NULL,
  `codigo_item-p` VARCHAR(10) NOT NULL,
  `numero_orden_compra-p` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`numero_docped-p`, `posicion`),
  INDEX `fk_prestacion_item1_idx` (`codigo_item-p` ASC),
  INDEX `fk_prestacion_Solicitud_Pedido1_idx` (`numero_docped-p` ASC),
  INDEX `fk_prestacion_orden_compra1_idx` (`numero_orden_compra-p` ASC),
  CONSTRAINT `fk_prestacion_item1`
    FOREIGN KEY (`codigo_item-p`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_Solicitud_Pedido1`
    FOREIGN KEY (`numero_docped-p`)
    REFERENCES `beraudent`.`docped` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_orden_compra1`
    FOREIGN KEY (`numero_orden_compra-p`)
    REFERENCES `beraudent`.`orden_compra` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Usuario` (
  `id_usua` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `apel_usua` VARCHAR(45) NULL,
  `nomb_usua` VARCHAR(45) NULL,
  `nick_usua` VARCHAR(45) NULL,
  `pass_usua` VARCHAR(45) NULL,
  `priv_usua` ENUM('A', 'L', 'E') NULL,
  PRIMARY KEY (`id_usua`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`comision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`comision` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `comision` FLOAT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`grupo` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`trabajo_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo_grupo` (
  `Prestacion_id` INT NOT NULL,
  `Grupo_id` INT NOT NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`Prestacion_id`, `Grupo_id`),
  INDEX `fk_Prestacion_has_Grupo_Grupo1_idx` (`Grupo_id` ASC),
  INDEX `fk_Prestacion_has_Grupo_Prestacion1_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Prestacion_has_Grupo_Prestacion1`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestacion_has_Grupo_Grupo1`
    FOREIGN KEY (`Grupo_id`)
    REFERENCES `beraudent`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`trabajo_comision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo_comision` (
  `id_prestacion` INT NOT NULL,
  `codigo_comision` INT NOT NULL,
  PRIMARY KEY (`id_prestacion`, `codigo_comision`),
  INDEX `fk_Prestacion_has_Trabajo_Trabajo1_idx` (`codigo_comision` ASC),
  INDEX `fk_Prestacion_has_Trabajo_Prestacion1_idx` (`id_prestacion` ASC),
  CONSTRAINT `fk_Prestacion_has_Trabajo_Prestacion1`
    FOREIGN KEY (`id_prestacion`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestacion_has_Trabajo_Trabajo1`
    FOREIGN KEY (`codigo_comision`)
    REFERENCES `beraudent`.`comision` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`detalle_item_arancel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`detalle_item_arancel` (
  `codigo_item-dia` VARCHAR(10) NOT NULL,
  `codigo_cliente` VARCHAR(10) NULL,
  `nomenclatura_cliente` VARCHAR(45) NULL,
  `detalle` VARCHAR(100) NULL,
  PRIMARY KEY (`codigo_item-dia`),
  CONSTRAINT `fk_detalle_item_arancel_item1`
    FOREIGN KEY (`codigo_item-dia`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Trabajo_Realizado_has_Abono_Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Trabajo_Realizado_has_Abono_Cargo` (
  `Trabajo_Realizado_id` INT NOT NULL,
  `Abono_Cargo_id_abon_carg` INT NOT NULL,
  PRIMARY KEY (`Trabajo_Realizado_id`, `Abono_Cargo_id_abon_carg`),
  INDEX `fk_Trabajo_Realizado_has_Abono_Cargo_Abono_Cargo1_idx` (`Abono_Cargo_id_abon_carg` ASC),
  INDEX `fk_Trabajo_Realizado_has_Abono_Cargo_Trabajo_Realizado1_idx` (`Trabajo_Realizado_id` ASC),
  CONSTRAINT `fk_Trabajo_Realizado_has_Abono_Cargo_Trabajo_Realizado1`
    FOREIGN KEY (`Trabajo_Realizado_id`)
    REFERENCES `beraudent`.`Trabajo_Realizado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajo_Realizado_has_Abono_Cargo_Abono_Cargo1`
    FOREIGN KEY (`Abono_Cargo_id_abon_carg`)
    REFERENCES `beraudent`.`Abono_Cargo` (`id_abon_carg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Prestacion_has_Abono_Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Prestacion_has_Abono_Cargo` (
  `Prestacion_id_solicitud` VARCHAR(10) NOT NULL,
  `Abono_Cargo_id_abon_carg` INT NOT NULL,
  PRIMARY KEY (`Prestacion_id_solicitud`, `Abono_Cargo_id_abon_carg`),
  INDEX `fk_Prestacion_has_Abono_Cargo_Abono_Cargo1_idx` (`Abono_Cargo_id_abon_carg` ASC),
  CONSTRAINT `fk_Prestacion_has_Abono_Cargo_Abono_Cargo1`
    FOREIGN KEY (`Abono_Cargo_id_abon_carg`)
    REFERENCES `beraudent`.`Abono_Cargo` (`id_abon_carg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`pago_comprobante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`pago_comprobante` (
  `id_pago-pc` INT NOT NULL,
  `id_comprobante-pc` VARCHAR(10) NOT NULL,
  `tipo_pago` ENUM('TF', 'TB', 'WP', 'CH') NULL,
  `numero` VARCHAR(20) NULL,
  `fecha_pago` DATE NULL,
  `fecha_vencimiento` DATE NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pago-pc`, `id_comprobante-pc`),
  INDEX `fk_pago_has_comprobante_pago1_idx` (`id_pago-pc` ASC),
  INDEX `fk_pago_comprobante_comprobante1_idx` (`id_comprobante-pc` ASC),
  CONSTRAINT `fk_pago_has_comprobante_pago1`
    FOREIGN KEY (`id_pago-pc`)
    REFERENCES `beraudent`.`pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_comprobante_comprobante1`
    FOREIGN KEY (`id_comprobante-pc`)
    REFERENCES `beraudent`.`comprobante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`prestacion_has_Trabajo_Realizado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`prestacion_has_Trabajo_Realizado` (
  `prestacion_Solicitud_Pedido_nume_soli_pedi` VARCHAR(10) NOT NULL,
  `prestacion_posicion` TINYINT(1) UNSIGNED NOT NULL,
  `Trabajo_Realizado_id` INT NOT NULL,
  PRIMARY KEY (`prestacion_Solicitud_Pedido_nume_soli_pedi`, `prestacion_posicion`, `Trabajo_Realizado_id`),
  INDEX `fk_prestacion_has_Trabajo_Realizado_Trabajo_Realizado1_idx` (`Trabajo_Realizado_id` ASC),
  INDEX `fk_prestacion_has_Trabajo_Realizado_prestacion1_idx` (`prestacion_Solicitud_Pedido_nume_soli_pedi` ASC, `prestacion_posicion` ASC),
  CONSTRAINT `fk_prestacion_has_Trabajo_Realizado_prestacion1`
    FOREIGN KEY (`prestacion_Solicitud_Pedido_nume_soli_pedi` , `prestacion_posicion`)
    REFERENCES `beraudent`.`prestacion` (`numero_docped-p` , `posicion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_has_Trabajo_Realizado_Trabajo_Realizado1`
    FOREIGN KEY (`Trabajo_Realizado_id`)
    REFERENCES `beraudent`.`Trabajo_Realizado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`item_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`item_trabajo` (
  `codigo_item-it` VARCHAR(10) NOT NULL,
  `id_trabajo-it` INT NOT NULL,
  PRIMARY KEY (`codigo_item-it`, `id_trabajo-it`),
  INDEX `fk_item_has_trabajo_trabajo1_idx` (`id_trabajo-it` ASC),
  INDEX `fk_item_has_trabajo_item1_idx` (`codigo_item-it` ASC),
  CONSTRAINT `fk_item_has_trabajo_item1`
    FOREIGN KEY (`codigo_item-it`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_has_trabajo_trabajo1`
    FOREIGN KEY (`id_trabajo-it`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `beraudent`.`Usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `beraudent`;
INSERT INTO `beraudent`.`Usuario` (`id_usua`, `apel_usua`, `nomb_usua`, `nick_usua`, `pass_usua`, `priv_usua`) VALUES (DEFAULT, 'OBANDO FLORIAN', 'ABEL RAFAEL', 'ofaber', '123456', 'A');
INSERT INTO `beraudent`.`Usuario` (`id_usua`, `apel_usua`, `nomb_usua`, `nick_usua`, `pass_usua`, `priv_usua`) VALUES (DEFAULT, 'QUIROZ ANDRADE', 'CARMEN DEL PILAR', 'cpilar', '123456', 'L');

COMMIT;

