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
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


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
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


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
-- Table `beraudent`.`orden_trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`orden_trabajo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`orden_trabajo` (
  `ot` VARCHAR(10) NOT NULL,
  `ticket` VARCHAR(10) NULL,
  `fecha_ingreso` DATETIME NULL,
  `fecha_entrega` DATETIME NULL,
  `responsable` VARCHAR(10) NULL,
  `detalle` TEXT(100) NULL,
  PRIMARY KEY (`ot`))
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
-- Table `beraudent`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`pedido` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`pedido` (
  `numero` VARCHAR(10) NOT NULL,
  `episodio` VARCHAR(10) NULL COMMENT 'Existen raros casos donde hay mas de un episodio por solped, colocarlo com nota',
  `id_sucursal-so-p` INT NOT NULL,
  `id_odontologo-so-p` INT NOT NULL,
  `id_paciente-p` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_pedido_sucursal_odontologo1_idx` (`id_sucursal-so-p` ASC, `id_odontologo-so-p` ASC),
  INDEX `fk_pedido_paciente1_idx` (`id_paciente-p` ASC),
  CONSTRAINT `fk_pedido_sucursal_odontologo1`
    FOREIGN KEY (`id_sucursal-so-p` , `id_odontologo-so-p`)
    REFERENCES `beraudent`.`sucursal_odontologo` (`id_sucursal-so` , `id_odontologo-so`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_paciente1`
    FOREIGN KEY (`id_paciente-p`)
    REFERENCES `beraudent`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`fase`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`fase` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`fase` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `costo_comision` FLOAT NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`producto` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `detalle` VARCHAR(100) NULL,
  `etapa` ENUM('I', 'P', 'T') NULL,
  `id_producto-p` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_producto_producto1_idx` (`id_producto-p` ASC),
  CONSTRAINT `fk_producto_producto1`
    FOREIGN KEY (`id_producto-p`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`fase_producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`fase_producto` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`fase_producto` (
  `codigo_fase-fp` INT NOT NULL,
  `id_producto-fp` INT NOT NULL,
  PRIMARY KEY (`codigo_fase-fp`, `id_producto-fp`),
  INDEX `fk_fase_has_producto_producto1_idx` (`id_producto-fp` ASC),
  INDEX `fk_fase_has_producto_fase1_idx` (`codigo_fase-fp` ASC),
  CONSTRAINT `fk_fase_has_producto_fase1`
    FOREIGN KEY (`codigo_fase-fp`)
    REFERENCES `beraudent`.`fase` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fase_has_producto_producto1`
    FOREIGN KEY (`id_producto-fp`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`Area` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`Area` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`empleado` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`empleado` (
  `codigo` VARCHAR(10) NOT NULL,
  `nombres` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `rut` VARCHAR(45) NULL,
  `id_area-e` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_empleado_Area1_idx` (`id_area-e` ASC),
  CONSTRAINT `fk_empleado_Area1`
    FOREIGN KEY (`id_area-e`)
    REFERENCES `beraudent`.`Area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`fase_realizada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`fase_realizada` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`fase_realizada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `piezas` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `color` VARCHAR(50) NULL,
  `costo_comision` FLOAT NULL,
  `inicio` DATETIME NULL,
  `fin` DATETIME NULL,
  `detalle` VARCHAR(45) NULL,
  `ot_orden_trabajo-fr` VARCHAR(10) NOT NULL,
  `codigo_fase-fp-fr` INT NOT NULL,
  `id_producto-fp-fr` INT NOT NULL,
  `codigo_empleado-fr` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fase_realizada_orden_trabajo1_idx` (`ot_orden_trabajo-fr` ASC),
  INDEX `fk_fase_realizada_fase_producto1_idx` (`codigo_fase-fp-fr` ASC, `id_producto-fp-fr` ASC),
  INDEX `fk_fase_realizada_empleado1_idx` (`codigo_empleado-fr` ASC),
  CONSTRAINT `fk_fase_realizada_orden_trabajo1`
    FOREIGN KEY (`ot_orden_trabajo-fr`)
    REFERENCES `beraudent`.`orden_trabajo` (`ot`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fase_realizada_fase_producto1`
    FOREIGN KEY (`codigo_fase-fp-fr` , `id_producto-fp-fr`)
    REFERENCES `beraudent`.`fase_producto` (`codigo_fase-fp` , `id_producto-fp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fase_realizada_empleado1`
    FOREIGN KEY (`codigo_empleado-fr`)
    REFERENCES `beraudent`.`empleado` (`codigo`)
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
  `periodo` VARCHAR(15) NULL,
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
-- Table `beraudent`.`producto_solicitado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`producto_solicitado` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`producto_solicitado` (
  `id` VARCHAR(12) NOT NULL,
  `posicion` TINYINT(1) UNSIGNED NOT NULL,
  `fecha_registro` DATE NULL,
  `fecha_entrega` DATE NULL,
  `cant_pres` TINYINT(1) UNSIGNED NULL,
  `precio` FLOAT NOT NULL,
  `null_pres` ENUM('V', 'N') NULL DEFAULT 'V' COMMENT 'las posiciones pueden anularse con basurero, bomba  o valor total=0\nsiempre es bueno tener respald de que posicion esta nula',
  `detalle` VARCHAR(45) NULL,
  `codigo_item-ps` VARCHAR(10) NOT NULL,
  `numero_pedido-ps` VARCHAR(10) NOT NULL,
  `numero_cancelacion-ps` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_producto_solicitado_item1_idx` (`codigo_item-ps` ASC),
  INDEX `fk_producto_solicitado_pedido1_idx` (`numero_pedido-ps` ASC),
  INDEX `fk_producto_solicitado_cancelacion1_idx` (`numero_cancelacion-ps` ASC),
  CONSTRAINT `fk_producto_solicitado_item1`
    FOREIGN KEY (`codigo_item-ps`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_solicitado_pedido1`
    FOREIGN KEY (`numero_pedido-ps`)
    REFERENCES `beraudent`.`pedido` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_solicitado_cancelacion1`
    FOREIGN KEY (`numero_cancelacion-ps`)
    REFERENCES `beraudent`.`cancelacion` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`usuario` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`usuario` (
  `nick` VARCHAR(15) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `permisos` ENUM('A', 'E', 'S', 'C', 'T', 'L') NULL DEFAULT 'L' COMMENT '\'A\'=Administrador\n\'E\'=Escritura / Control Total\n\'S\'=Secretaria\n\'C\'=Contabilidad\n\'T\'=Tecnicos\n\'L\'=Lectura',
  PRIMARY KEY (`nick`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`grupo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`grupo` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`detalle_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`detalle_item` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`detalle_item` (
  `codigo_item-di` VARCHAR(10) NOT NULL,
  `codigo_cliente` VARCHAR(10) NULL,
  `nomenclatura_cliente` VARCHAR(45) NULL,
  `detalle` VARCHAR(100) NULL,
  PRIMARY KEY (`codigo_item-di`),
  CONSTRAINT `fk_detalle_item_item1`
    FOREIGN KEY (`codigo_item-di`)
    REFERENCES `beraudent`.`item` (`codigo`)
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
-- Table `beraudent`.`item_producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`item_producto` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`item_producto` (
  `codigo_item-ip` VARCHAR(10) NOT NULL,
  `id_producto-ip` INT NOT NULL,
  PRIMARY KEY (`codigo_item-ip`, `id_producto-ip`),
  INDEX `fk_item_has_producto_producto1_idx` (`id_producto-ip` ASC),
  INDEX `fk_item_has_producto_item1_idx` (`codigo_item-ip` ASC),
  CONSTRAINT `fk_item_has_producto_item1`
    FOREIGN KEY (`codigo_item-ip`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_has_producto_producto1`
    FOREIGN KEY (`id_producto-ip`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`fase_realizada_producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`fase_realizada_producto` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`fase_realizada_producto` (
  `id_fase_realizada-frp` INT NOT NULL,
  `id_producto_solicitado-frp` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_fase_realizada-frp`, `id_producto_solicitado-frp`),
  INDEX `fk_fase_realizada_has_producto_solicitado_producto_solicita_idx` (`id_producto_solicitado-frp` ASC),
  INDEX `fk_fase_realizada_has_producto_solicitado_fase_realizada1_idx` (`id_fase_realizada-frp` ASC),
  CONSTRAINT `fk_fase_realizada_has_producto_solicitado_fase_realizada1`
    FOREIGN KEY (`id_fase_realizada-frp`)
    REFERENCES `beraudent`.`fase_realizada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fase_realizada_has_producto_solicitado_producto_solicitado1`
    FOREIGN KEY (`id_producto_solicitado-frp`)
    REFERENCES `beraudent`.`producto_solicitado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`abono_cargo_producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`abono_cargo_producto` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`abono_cargo_producto` (
  `id_abono_cargo-acp` INT NOT NULL,
  `id_producto_solicitado-acp` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_abono_cargo-acp`, `id_producto_solicitado-acp`),
  INDEX `fk_abono_cargo_has_producto_solicitado_producto_solicitado1_idx` (`id_producto_solicitado-acp` ASC),
  INDEX `fk_abono_cargo_has_producto_solicitado_abono_cargo1_idx` (`id_abono_cargo-acp` ASC),
  CONSTRAINT `fk_abono_cargo_has_producto_solicitado_abono_cargo1`
    FOREIGN KEY (`id_abono_cargo-acp`)
    REFERENCES `beraudent`.`abono_cargo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_abono_cargo_has_producto_solicitado_producto_solicitado1`
    FOREIGN KEY (`id_producto_solicitado-acp`)
    REFERENCES `beraudent`.`producto_solicitado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`producto_grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`producto_grupo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`producto_grupo` (
  `id_producto-pg` INT NOT NULL,
  `id_grupo-pg` INT NOT NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id_producto-pg`, `id_grupo-pg`),
  INDEX `fk_producto_has_grupo_grupo1_idx` (`id_grupo-pg` ASC),
  INDEX `fk_producto_has_grupo_producto1_idx` (`id_producto-pg` ASC),
  CONSTRAINT `fk_producto_has_grupo_producto1`
    FOREIGN KEY (`id_producto-pg`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_grupo_grupo1`
    FOREIGN KEY (`id_grupo-pg`)
    REFERENCES `beraudent`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`empleado_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`empleado_usuario` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`empleado_usuario` (
  `codigo_empleado-eu` VARCHAR(10) NOT NULL,
  `nick_usuario-eu` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`codigo_empleado-eu`, `nick_usuario-eu`),
  INDEX `fk_empleado_has_usuario_usuario1_idx` (`nick_usuario-eu` ASC),
  INDEX `fk_empleado_has_usuario_empleado1_idx` (`codigo_empleado-eu` ASC),
  CONSTRAINT `fk_empleado_has_usuario_empleado1`
    FOREIGN KEY (`codigo_empleado-eu`)
    REFERENCES `beraudent`.`empleado` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_has_usuario_usuario1`
    FOREIGN KEY (`nick_usuario-eu`)
    REFERENCES `beraudent`.`usuario` (`nick`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `beraudent`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `beraudent`;
INSERT INTO `beraudent`.`usuario` (`nick`, `password`, `permisos`) VALUES ('ofaber', '123456', 'A');
INSERT INTO `beraudent`.`usuario` (`nick`, `password`, `permisos`) VALUES ('cpilar', '123456', 'L');

COMMIT;

