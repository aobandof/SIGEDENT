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
-- Table `beraudent`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`cliente` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `direccion_admninistracion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`arancel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`arancel` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`arancel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NULL,
  `detalle` VARCHAR(45) NULL COMMENT 'deta_aran informará como se construyó el arancel (si deriba de algun porcentaje sobre algun arancel base o es un arancel con precios especiales)',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`datos_facturacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`datos_facturacion` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`datos_facturacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `grupo_facturacion` VARCHAR(45) NOT NULL COMMENT 'nombre del grupo de facturacion por ejemplo OMESA de vidaintegra contiene muchos sucursales que se facturan con este mismo grupo (misma razon social, etc)',
  `razon_social` VARCHAR(45) NOT NULL,
  `nombre_fantasia` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `rut` VARCHAR(45) NOT NULL,
  `detalle` VARCHAR(45) NULL,
  `id_cliente-df` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Datos_Facturacion_Cliente1_idx` (`id_cliente-df` ASC),
  CONSTRAINT `fk_Datos_Facturacion_Cliente1`
    FOREIGN KEY (`id_cliente-df`)
    REFERENCES `beraudent`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`sucursal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`sucursal` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`sucursal` (
  `id` INT NOT NULL,
  `codigo` VARCHAR(10) NULL,
  `abreviatura` VARCHAR(10) NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `alias` VARCHAR(45) NULL,
  `id_arancel-s` INT NOT NULL,
  `id_cliente-s` INT NOT NULL,
  `id_datos_facturacion-s` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sucursal_Arancel1_idx` (`id_arancel-s` ASC),
  INDEX `fk_Sucursal_Cliente1_idx` (`id_cliente-s` ASC),
  INDEX `fk_Sucursal_Datos_Facturacion1_idx` (`id_datos_facturacion-s` ASC),
  CONSTRAINT `fk_Sucursal_Arancel1`
    FOREIGN KEY (`id_arancel-s`)
    REFERENCES `beraudent`.`arancel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_Cliente1`
    FOREIGN KEY (`id_cliente-s`)
    REFERENCES `beraudent`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_Datos_Facturacion1`
    FOREIGN KEY (`id_datos_facturacion-s`)
    REFERENCES `beraudent`.`datos_facturacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`odontologo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`odontologo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`odontologo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apellidos` VARCHAR(45) NULL,
  `nombres` VARCHAR(45) NULL,
  `email1` VARCHAR(25) NULL,
  `email2` VARCHAR(25) NULL,
  `celular` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`administrativo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`administrativo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`administrativo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(35) NULL,
  `apellidos` VARCHAR(35) NULL,
  `email` VARCHAR(25) NULL,
  `celular` VARCHAR(10) NULL,
  `telefono` VARCHAR(10) NULL,
  `cargo` VARCHAR(15) NULL,
  `id_cliente-a` INT NOT NULL,
  PRIMARY KEY (`id`, `id_cliente-a`),
  INDEX `fk_Administrativo_Cliente1_idx` (`id_cliente-a` ASC),
  CONSTRAINT `fk_Administrativo_Cliente1`
    FOREIGN KEY (`id_cliente-a`)
    REFERENCES `beraudent`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`personal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`personal` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`personal` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(35) NULL,
  `apellidos` VARCHAR(35) NULL,
  `email` VARCHAR(25) NULL,
  `celular` INT NULL,
  `telefono` VARCHAR(45) NULL,
  `cargo` VARCHAR(15) NULL,
  `id_sucursal-p` INT NOT NULL,
  PRIMARY KEY (`id`, `id_sucursal-p`),
  INDEX `fk_Personal_Sucursal1_idx` (`id_sucursal-p` ASC),
  CONSTRAINT `fk_Personal_Sucursal1`
    FOREIGN KEY (`id_sucursal-p`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`paciente` ;

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
DROP TABLE IF EXISTS `beraudent`.`sucursal_odontologo` ;

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
DROP TABLE IF EXISTS `beraudent`.`orden_trabajo` ;

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
DROP TABLE IF EXISTS `beraudent`.`docped` ;

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
DROP TABLE IF EXISTS `beraudent`.`trabajo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `detalle` VARCHAR(100) NULL,
  `etapa` ENUM('I', 'P', 'T') NULL,
  `id_trabajo-t` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trabajo_trabajo1_idx` (`id_trabajo-t` ASC),
  CONSTRAINT `fk_trabajo_trabajo1`
    FOREIGN KEY (`id_trabajo-t`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`comprobante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`comprobante` ;

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
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`grupo_cancelacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`grupo_cancelacion` ;

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
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`trabajo_realizado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`trabajo_realizado` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo_realizado` (
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
-- Table `beraudent`.`ubicacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`ubicacion` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`ubicacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(30) NOT NULL COMMENT 'esta direccion debe contener el tipo (calle, jiron o avenida en abreviatura), el numero y el departamento si fuera necesasrio.',
  `comu_ubic` VARCHAR(15) NULL,
  `regi_ubic` VARCHAR(45) NULL,
  `tel1_ubic` VARCHAR(45) NULL,
  `tel2_ubic` VARCHAR(45) NULL,
  `id_sucursal-u` INT NOT NULL,
  PRIMARY KEY (`id`, `id_sucursal-u`),
  INDEX `fk_Ubicacion_Sucursal1_idx` (`id_sucursal-u` ASC),
  CONSTRAINT `fk_Ubicacion_Sucursal1`
    FOREIGN KEY (`id_sucursal-u`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`abono_cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`abono_cargo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`abono_cargo` (
  `id` INT NOT NULL,
  `detalle` VARCHAR(45) NULL,
  `monto` FLOAT NULL,
  `tipo` ENUM('A', 'C') NULL,
  `cancelacion` VARCHAR(10) NULL COMMENT 'Contendra el numero de orden de compra o el grupo de cancelacion dependiendo de la sucursal, esto se puede calcular con querys pero considero correcto reflejarlo en un campo solo para referenciar',
  `id_comprobante-ac` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_abono_cargo_comprobante1_idx` (`id_comprobante-ac` ASC),
  CONSTRAINT `fk_abono_cargo_comprobante1`
    FOREIGN KEY (`id_comprobante-ac`)
    REFERENCES `beraudent`.`comprobante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`pago` ;

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
DROP TABLE IF EXISTS `beraudent`.`item` ;

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
-- Table `beraudent`.`cancelacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`cancelacion` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`cancelacion` (
  `numero` VARCHAR(10) NOT NULL,
  `fecha` DATE NULL,
  `monto` FLOAT NULL,
  `detalle` VARCHAR(45) NULL,
  `id_comprobante-c` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_cancelacion_comprobante1_idx` (`id_comprobante-c` ASC),
  CONSTRAINT `fk_cancelacion_comprobante1`
    FOREIGN KEY (`id_comprobante-c`)
    REFERENCES `beraudent`.`comprobante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`prestacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`prestacion` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`prestacion` (
  `id` VARCHAR(12) NOT NULL,
  `posicion` TINYINT(1) UNSIGNED NOT NULL,
  `fecha_registro` DATE NULL,
  `fecha_entrega` DATE NULL,
  `cant_pres` TINYINT(1) UNSIGNED NULL,
  `precio` FLOAT NOT NULL,
  `null_pres` ENUM('V', 'N') NULL DEFAULT 'V' COMMENT 'las posiciones pueden anularse con basurero, bomba  o valor total=0\nsiempre es bueno tener respald de que posicion esta nula',
  `detalle` VARCHAR(45) NULL,
  `codigo_item-p` VARCHAR(10) NOT NULL,
  `numero_docped-p` VARCHAR(10) NOT NULL,
  `numero_cancelacion-p` VARCHAR(10) NOT NULL,
  INDEX `fk_prestacion_item1_idx` (`codigo_item-p` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_prestacion_docped1_idx` (`numero_docped-p` ASC),
  INDEX `fk_prestacion_cancelacion1_idx` (`numero_cancelacion-p` ASC),
  CONSTRAINT `fk_prestacion_item1`
    FOREIGN KEY (`codigo_item-p`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_docped1`
    FOREIGN KEY (`numero_docped-p`)
    REFERENCES `beraudent`.`docped` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_cancelacion1`
    FOREIGN KEY (`numero_cancelacion-p`)
    REFERENCES `beraudent`.`cancelacion` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`Usuario` ;

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
DROP TABLE IF EXISTS `beraudent`.`comision` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`comision` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `comision` FLOAT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`grupo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`grupo` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`detalle_item_arancel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`detalle_item_arancel` ;

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
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`item_trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`item_trabajo` ;

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


-- -----------------------------------------------------
-- Table `beraudent`.`trabajo_abono_cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`trabajo_abono_cargo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo_abono_cargo` (
  `id_trabajo_realizado-tac` INT NOT NULL,
  `id_abono_cargo-tac` INT NOT NULL,
  PRIMARY KEY (`id_trabajo_realizado-tac`, `id_abono_cargo-tac`),
  INDEX `fk_trabajo_realizado_has_abono_cargo_abono_cargo1_idx` (`id_abono_cargo-tac` ASC),
  INDEX `fk_trabajo_realizado_has_abono_cargo_trabajo_realizado1_idx` (`id_trabajo_realizado-tac` ASC),
  CONSTRAINT `fk_trabajo_realizado_has_abono_cargo_trabajo_realizado1`
    FOREIGN KEY (`id_trabajo_realizado-tac`)
    REFERENCES `beraudent`.`trabajo_realizado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trabajo_realizado_has_abono_cargo_abono_cargo1`
    FOREIGN KEY (`id_abono_cargo-tac`)
    REFERENCES `beraudent`.`abono_cargo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`prestacion_trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`prestacion_trabajo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`prestacion_trabajo` (
  `id_prestacion-pt` VARCHAR(12) NOT NULL,
  `id_trabajo_realizado-pt` INT NOT NULL,
  PRIMARY KEY (`id_prestacion-pt`, `id_trabajo_realizado-pt`),
  INDEX `fk_prestacion_has_trabajo_realizado_trabajo_realizado1_idx` (`id_trabajo_realizado-pt` ASC),
  INDEX `fk_prestacion_has_trabajo_realizado_prestacion1_idx` (`id_prestacion-pt` ASC),
  CONSTRAINT `fk_prestacion_has_trabajo_realizado_prestacion1`
    FOREIGN KEY (`id_prestacion-pt`)
    REFERENCES `beraudent`.`prestacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_has_trabajo_realizado_trabajo_realizado1`
    FOREIGN KEY (`id_trabajo_realizado-pt`)
    REFERENCES `beraudent`.`trabajo_realizado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`pago_comprobante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`pago_comprobante` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`pago_comprobante` (
  `id_pago-pc` INT NOT NULL,
  `id_comprobante-pc` VARCHAR(10) NOT NULL,
  `tipo_pago` ENUM('TF', 'TB', 'WP', 'CH') NULL,
  `fecha` DATE NULL,
  `fecha_vencimiento` DATE NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pago-pc`, `id_comprobante-pc`),
  INDEX `fk_pago_has_comprobante_comprobante1_idx` (`id_comprobante-pc` ASC),
  INDEX `fk_pago_has_comprobante_pago1_idx` (`id_pago-pc` ASC),
  CONSTRAINT `fk_pago_has_comprobante_pago1`
    FOREIGN KEY (`id_pago-pc`)
    REFERENCES `beraudent`.`pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_has_comprobante_comprobante1`
    FOREIGN KEY (`id_comprobante-pc`)
    REFERENCES `beraudent`.`comprobante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`trabajo_has_grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`trabajo_has_grupo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo_has_grupo` (
  `id_trabajo-tg` INT NOT NULL,
  `id_grupo-tg` INT NOT NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id_trabajo-tg`, `id_grupo-tg`),
  INDEX `fk_trabajo_has_grupo_grupo1_idx` (`id_grupo-tg` ASC),
  INDEX `fk_trabajo_has_grupo_trabajo1_idx` (`id_trabajo-tg` ASC),
  CONSTRAINT `fk_trabajo_has_grupo_trabajo1`
    FOREIGN KEY (`id_trabajo-tg`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trabajo_has_grupo_grupo1`
    FOREIGN KEY (`id_grupo-tg`)
    REFERENCES `beraudent`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`trabajo_has_comision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`trabajo_has_comision` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`trabajo_has_comision` (
  `id_trabajo-tc` INT NOT NULL,
  `id_comision-tc` INT NOT NULL,
  PRIMARY KEY (`id_trabajo-tc`, `id_comision-tc`),
  INDEX `fk_trabajo_has_comision_comision1_idx` (`id_comision-tc` ASC),
  INDEX `fk_trabajo_has_comision_trabajo1_idx` (`id_trabajo-tc` ASC),
  CONSTRAINT `fk_trabajo_has_comision_trabajo1`
    FOREIGN KEY (`id_trabajo-tc`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trabajo_has_comision_comision1`
    FOREIGN KEY (`id_comision-tc`)
    REFERENCES `beraudent`.`comision` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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

