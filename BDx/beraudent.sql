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
-- Table `beraudent`.`Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Sucursal` (
  `id_sucu` INT NOT NULL,
  `codi_sucu` VARCHAR(10) NULL,
  `abre_sucu` VARCHAR(10) NULL,
  `nomb_sucu` VARCHAR(25) NOT NULL,
  `alia_sucu` VARCHAR(45) NULL,
  `Arancel_id_aran` INT NOT NULL,
  `Cliente_id_clie` INT NOT NULL,
  `Datos_Facturacion_id` INT NOT NULL,
  PRIMARY KEY (`id_sucu`),
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
-- Table `beraudent`.`Odontologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Odontologo` (
  `id_odon` INT NOT NULL AUTO_INCREMENT,
  `apel_odon` VARCHAR(45) NULL,
  `nomb_odon` VARCHAR(45) NULL,
  `mail_odon` VARCHAR(25) NULL,
  `celu_odon` VARCHAR(10) NULL,
  PRIMARY KEY (`id_odon`))
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
-- Table `beraudent`.`Arancel_has_Trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel_has_Trabajo` (
  `Arancel_id_aran` INT NOT NULL,
  `Trabajo_id_trab` INT NOT NULL,
  `prec_aran` INT NULL,
  PRIMARY KEY (`Arancel_id_aran`, `Trabajo_id_trab`))
ENGINE = InnoDB;


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
    REFERENCES `beraudent`.`Sucursal` (`id_sucu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Sucursal_Odontologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Sucursal_Odontologo` (
  `Sucursal_id_sucu` INT NOT NULL,
  `Odontologo_id_odon` INT NOT NULL,
  PRIMARY KEY (`Sucursal_id_sucu`, `Odontologo_id_odon`),
  INDEX `fk_Sucursal_has_Odontologo_Odontologo1_idx` (`Odontologo_id_odon` ASC),
  INDEX `fk_Sucursal_has_Odontologo_Sucursal1_idx` (`Sucursal_id_sucu` ASC),
  CONSTRAINT `fk_Sucursal_has_Odontologo_Sucursal1`
    FOREIGN KEY (`Sucursal_id_sucu`)
    REFERENCES `beraudent`.`Sucursal` (`id_sucu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_has_Odontologo_Odontologo1`
    FOREIGN KEY (`Odontologo_id_odon`)
    REFERENCES `beraudent`.`Odontologo` (`id_odon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Paciente` (
  `id_paciente` INT UNSIGNED NOT NULL,
  `rut_paciente` VARCHAR(10) NULL,
  `nomb_paciente` VARCHAR(45) NULL,
  `apel_paciente` VARCHAR(45) NULL,
  PRIMARY KEY (`id_paciente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Orden_Trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Orden_Trabajo` (
  `ot_orde_trab` VARCHAR(10) NOT NULL,
  `tick_orde_trab` VARCHAR(10) NULL,
  `fech_ingr` DATETIME NULL,
  `fech_entr` DATETIME NULL,
  `nota_orde_trab` TEXT(100) NULL,
  `Sucursal_Odontologo_Sucursal_id_sucu` INT NOT NULL,
  `Sucursal_Odontologo_Odontologo_id_odon` INT NOT NULL,
  `Paciente_id_paciente` INT UNSIGNED NOT NULL,
  `suministros_enviados` VARCHAR(45) NULL,
  INDEX `fk_Orden_Trabajo_Sucursal_Odontologo1_idx` (`Sucursal_Odontologo_Sucursal_id_sucu` ASC, `Sucursal_Odontologo_Odontologo_id_odon` ASC),
  INDEX `fk_Orden_Trabajo_Paciente1_idx` (`Paciente_id_paciente` ASC),
  PRIMARY KEY (`ot_orde_trab`),
  CONSTRAINT `fk_Orden_Trabajo_Sucursal_Odontologo1`
    FOREIGN KEY (`Sucursal_Odontologo_Sucursal_id_sucu` , `Sucursal_Odontologo_Odontologo_id_odon`)
    REFERENCES `beraudent`.`Sucursal_Odontologo` (`Sucursal_id_sucu` , `Odontologo_id_odon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden_Trabajo_Paciente1`
    FOREIGN KEY (`Paciente_id_paciente`)
    REFERENCES `beraudent`.`Paciente` (`id_paciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`Solicitud_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Solicitud_Pedido` (
  `nume_soli_pedi` VARCHAR(10) NOT NULL,
  `Sucursal_Odontologo_Sucursal_id_sucu` INT NOT NULL,
  `Sucursal_Odontologo_Odontologo_id_odon` INT NOT NULL,
  `Paciente_id_paciente` INT UNSIGNED NOT NULL,
  `episodio` VARCHAR(10) NULL COMMENT 'Existen raros casos donde hay mas de un episodio por solped, colocarlo com nota',
  PRIMARY KEY (`nume_soli_pedi`),
  INDEX `fk_Solicitud_Pedido_Sucursal_Odontologo1_idx` (`Sucursal_Odontologo_Sucursal_id_sucu` ASC, `Sucursal_Odontologo_Odontologo_id_odon` ASC),
  INDEX `fk_Solicitud_Pedido_Paciente1_idx` (`Paciente_id_paciente` ASC),
  CONSTRAINT `fk_Solicitud_Pedido_Sucursal_Odontologo1`
    FOREIGN KEY (`Sucursal_Odontologo_Sucursal_id_sucu` , `Sucursal_Odontologo_Odontologo_id_odon`)
    REFERENCES `beraudent`.`Sucursal_Odontologo` (`Sucursal_id_sucu` , `Odontologo_id_odon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitud_Pedido_Paciente1`
    FOREIGN KEY (`Paciente_id_paciente`)
    REFERENCES `beraudent`.`Paciente` (`id_paciente`)
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
  `comprobante_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_grupo_cancelacion_comprobante1_idx` (`comprobante_id` ASC),
  CONSTRAINT `fk_grupo_cancelacion_comprobante1`
    FOREIGN KEY (`comprobante_id`)
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
    REFERENCES `beraudent`.`Orden_Trabajo` (`ot_orde_trab`)
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
    REFERENCES `beraudent`.`Sucursal` (`id_sucu`)
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
  `id_pago` INT NOT NULL,
  `nume_reci_pago` VARCHAR(8) NULL,
  `fech_reci_pago` DATETIME NULL,
  `deta_pago` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`item` (
  `codigo_beraudent` VARCHAR(10) NOT NULL,
  `precio` FLOAT NULL,
  `arancel_id1` INT NOT NULL,
  PRIMARY KEY (`codigo_beraudent`),
  INDEX `fk_item_arancel_arancel1_idx` (`arancel_id1` ASC),
  CONSTRAINT `fk_item_arancel_arancel1`
    FOREIGN KEY (`arancel_id1`)
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
  `comprobante_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_orden_compra_comprobante1_idx` (`comprobante_id` ASC),
  CONSTRAINT `fk_orden_compra_comprobante1`
    FOREIGN KEY (`comprobante_id`)
    REFERENCES `beraudent`.`comprobante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`prestacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`prestacion` (
  `Solicitud_Pedido_nume_soli_pedi` VARCHAR(10) NOT NULL,
  `posicion` TINYINT(1) UNSIGNED NOT NULL,
  `fecha_registro` DATE NULL,
  `fecha_entrega` DATE NULL,
  `cant_pres` TINYINT(1) UNSIGNED NULL,
  `precio` FLOAT NOT NULL,
  `null_pres` ENUM('V', 'N') NULL DEFAULT 'V' COMMENT 'las posiciones pueden anularse con basurero, bomba  o valor total=0\nsiempre es bueno tener respald de que posicion esta nula',
  `detalle` VARCHAR(45) NULL,
  `item_codigo_beraudent` VARCHAR(10) NOT NULL,
  `orden_compra_numero` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Solicitud_Pedido_nume_soli_pedi`, `posicion`),
  INDEX `fk_prestacion_item1_idx` (`item_codigo_beraudent` ASC),
  INDEX `fk_prestacion_Solicitud_Pedido1_idx` (`Solicitud_Pedido_nume_soli_pedi` ASC),
  INDEX `fk_prestacion_orden_compra1_idx` (`orden_compra_numero` ASC),
  CONSTRAINT `fk_prestacion_item1`
    FOREIGN KEY (`item_codigo_beraudent`)
    REFERENCES `beraudent`.`item` (`codigo_beraudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_Solicitud_Pedido1`
    FOREIGN KEY (`Solicitud_Pedido_nume_soli_pedi`)
    REFERENCES `beraudent`.`Solicitud_Pedido` (`nume_soli_pedi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestacion_orden_compra1`
    FOREIGN KEY (`orden_compra_numero`)
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
-- Table `beraudent`.`Arancel1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel1` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Prestacion1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Prestacion1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Proceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Proceso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Prestacion_Proceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Prestacion_Proceso` (
  `Prestacion_id` INT NOT NULL,
  `Proceso_id` INT NOT NULL,
  PRIMARY KEY (`Prestacion_id`, `Proceso_id`),
  INDEX `fk_Prestacion_has_Proceso_Proceso1_idx` (`Proceso_id` ASC),
  INDEX `fk_Prestacion_has_Proceso_Prestacion_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Prestacion_has_Proceso_Prestacion`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`Prestacion1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestacion_has_Proceso_Proceso1`
    FOREIGN KEY (`Proceso_id`)
    REFERENCES `beraudent`.`Proceso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Trabajo_Tecnico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Trabajo_Tecnico` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Proceso_Trabajo_Tecnico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Proceso_Trabajo_Tecnico` (
  `Proceso_id` INT NOT NULL,
  `Trabajo_Tecnico_id` INT NOT NULL,
  PRIMARY KEY (`Proceso_id`, `Trabajo_Tecnico_id`),
  INDEX `fk_Proceso_has_Trabajo_Tecnico_Trabajo_Tecnico1_idx` (`Trabajo_Tecnico_id` ASC),
  INDEX `fk_Proceso_has_Trabajo_Tecnico_Proceso1_idx` (`Proceso_id` ASC),
  CONSTRAINT `fk_Proceso_has_Trabajo_Tecnico_Proceso1`
    FOREIGN KEY (`Proceso_id`)
    REFERENCES `beraudent`.`Proceso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proceso_has_Trabajo_Tecnico_Trabajo_Tecnico1`
    FOREIGN KEY (`Trabajo_Tecnico_id`)
    REFERENCES `beraudent`.`Trabajo_Tecnico` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel_Prestacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel_Prestacion` (
  `codigo_cliente` VARCHAR(10) NULL,
  `nomenclatura_cliente` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `Arancel_id` INT NOT NULL,
  `Prestacion_id` INT NOT NULL,
  PRIMARY KEY (`Arancel_id`, `Prestacion_id`),
  INDEX `fk_Arancel_Prestacion_Prestacion1_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Arancel_Prestacion_Arancel1`
    FOREIGN KEY (`Arancel_id`)
    REFERENCES `beraudent`.`Arancel1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arancel_Prestacion_Prestacion1`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`Prestacion1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel_Proceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel_Proceso` (
  `Arancel_Prestacion_Arancel_id` INT NOT NULL,
  `Arancel_Prestacion_Prestacion_id` INT NOT NULL,
  `Prestacion_Proceso_Proceso_id` INT NOT NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`Arancel_Prestacion_Arancel_id`, `Arancel_Prestacion_Prestacion_id`, `Prestacion_Proceso_Proceso_id`),
  INDEX `fk_Arancel_Prestacion_has_Prestacion_Proceso_Prestacion_Pro_idx` (`Prestacion_Proceso_Proceso_id` ASC),
  INDEX `fk_Arancel_Prestacion_has_Prestacion_Proceso_Arancel_Presta_idx` (`Arancel_Prestacion_Arancel_id` ASC, `Arancel_Prestacion_Prestacion_id` ASC),
  CONSTRAINT `fk_Arancel_Prestacion_has_Prestacion_Proceso_Arancel_Prestaci1`
    FOREIGN KEY (`Arancel_Prestacion_Arancel_id` , `Arancel_Prestacion_Prestacion_id`)
    REFERENCES `beraudent`.`Arancel_Prestacion` (`Arancel_id` , `Prestacion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arancel_Prestacion_has_Prestacion_Proceso_Prestacion_Proce1`
    FOREIGN KEY (`Prestacion_Proceso_Proceso_id`)
    REFERENCES `beraudent`.`Prestacion_Proceso` (`Proceso_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel2` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Prestacion2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Prestacion2` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Proceso1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Proceso1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Prestacion_Proceso1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Prestacion_Proceso1` (
  `Prestacion_id` INT NOT NULL,
  `Proceso_id` INT NOT NULL,
  PRIMARY KEY (`Prestacion_id`, `Proceso_id`),
  INDEX `fk_Prestacion_has_Proceso_Proceso1_idx` (`Proceso_id` ASC),
  INDEX `fk_Prestacion_has_Proceso_Prestacion_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Prestacion_has_Proceso_Prestacion`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`Prestacion2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestacion_has_Proceso_Proceso1`
    FOREIGN KEY (`Proceso_id`)
    REFERENCES `beraudent`.`Proceso1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Trabajo_Tecnico1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Trabajo_Tecnico1` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Proceso_Trabajo_Tecnico1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Proceso_Trabajo_Tecnico1` (
  `Proceso_id` INT NOT NULL,
  `Trabajo_Tecnico_id` INT NOT NULL,
  PRIMARY KEY (`Proceso_id`, `Trabajo_Tecnico_id`),
  INDEX `fk_Proceso_has_Trabajo_Tecnico_Trabajo_Tecnico1_idx` (`Trabajo_Tecnico_id` ASC),
  INDEX `fk_Proceso_has_Trabajo_Tecnico_Proceso1_idx` (`Proceso_id` ASC),
  CONSTRAINT `fk_Proceso_has_Trabajo_Tecnico_Proceso1`
    FOREIGN KEY (`Proceso_id`)
    REFERENCES `beraudent`.`Proceso1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proceso_has_Trabajo_Tecnico_Trabajo_Tecnico1`
    FOREIGN KEY (`Trabajo_Tecnico_id`)
    REFERENCES `beraudent`.`Trabajo_Tecnico1` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel_Prestacion1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel_Prestacion1` (
  `codigo_cliente` VARCHAR(10) NULL,
  `nomenclatura_cliente` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `Arancel_id` INT NOT NULL,
  `Prestacion_id` INT NOT NULL,
  PRIMARY KEY (`Arancel_id`, `Prestacion_id`),
  INDEX `fk_Arancel_Prestacion_Prestacion1_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Arancel_Prestacion_Arancel1`
    FOREIGN KEY (`Arancel_id`)
    REFERENCES `beraudent`.`Arancel2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arancel_Prestacion_Prestacion1`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`Prestacion2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel_Proceso1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel_Proceso1` (
  `Arancel_Prestacion_Arancel_id` INT NOT NULL,
  `Arancel_Prestacion_Prestacion_id` INT NOT NULL,
  `Prestacion_Proceso_Proceso_id` INT NOT NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`Arancel_Prestacion_Arancel_id`, `Arancel_Prestacion_Prestacion_id`, `Prestacion_Proceso_Proceso_id`),
  INDEX `fk_Arancel_Prestacion_has_Prestacion_Proceso_Prestacion_Pro_idx` (`Prestacion_Proceso_Proceso_id` ASC),
  INDEX `fk_Arancel_Prestacion_has_Prestacion_Proceso_Arancel_Presta_idx` (`Arancel_Prestacion_Arancel_id` ASC, `Arancel_Prestacion_Prestacion_id` ASC),
  CONSTRAINT `fk_Arancel_Prestacion_has_Prestacion_Proceso_Arancel_Prestaci1`
    FOREIGN KEY (`Arancel_Prestacion_Arancel_id` , `Arancel_Prestacion_Prestacion_id`)
    REFERENCES `beraudent`.`Arancel_Prestacion1` (`Arancel_id` , `Prestacion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arancel_Prestacion_has_Prestacion_Proceso_Prestacion_Proce1`
    FOREIGN KEY (`Prestacion_Proceso_Proceso_id`)
    REFERENCES `beraudent`.`Prestacion_Proceso1` (`Proceso_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel3`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel3` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Prestacion3`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Prestacion3` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Proceso2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Proceso2` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Prestacion_Proceso2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Prestacion_Proceso2` (
  `Prestacion_id` INT NOT NULL,
  `Proceso_id` INT NOT NULL,
  PRIMARY KEY (`Prestacion_id`, `Proceso_id`),
  INDEX `fk_Prestacion_has_Proceso_Proceso1_idx` (`Proceso_id` ASC),
  INDEX `fk_Prestacion_has_Proceso_Prestacion_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Prestacion_has_Proceso_Prestacion`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`Prestacion3` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestacion_has_Proceso_Proceso1`
    FOREIGN KEY (`Proceso_id`)
    REFERENCES `beraudent`.`Proceso2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Trabajo_Tecnico2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Trabajo_Tecnico2` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Proceso_Trabajo_Tecnico2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Proceso_Trabajo_Tecnico2` (
  `Proceso_id` INT NOT NULL,
  `Trabajo_Tecnico_id` INT NOT NULL,
  PRIMARY KEY (`Proceso_id`, `Trabajo_Tecnico_id`),
  INDEX `fk_Proceso_has_Trabajo_Tecnico_Trabajo_Tecnico1_idx` (`Trabajo_Tecnico_id` ASC),
  INDEX `fk_Proceso_has_Trabajo_Tecnico_Proceso1_idx` (`Proceso_id` ASC),
  CONSTRAINT `fk_Proceso_has_Trabajo_Tecnico_Proceso1`
    FOREIGN KEY (`Proceso_id`)
    REFERENCES `beraudent`.`Proceso2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proceso_has_Trabajo_Tecnico_Trabajo_Tecnico1`
    FOREIGN KEY (`Trabajo_Tecnico_id`)
    REFERENCES `beraudent`.`Trabajo_Tecnico2` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel_Prestacion2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel_Prestacion2` (
  `codigo_cliente` VARCHAR(10) NULL,
  `nomenclatura_cliente` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `Arancel_id` INT NOT NULL,
  `Prestacion_id` INT NOT NULL,
  PRIMARY KEY (`Arancel_id`, `Prestacion_id`),
  INDEX `fk_Arancel_Prestacion_Prestacion1_idx` (`Prestacion_id` ASC),
  CONSTRAINT `fk_Arancel_Prestacion_Arancel1`
    FOREIGN KEY (`Arancel_id`)
    REFERENCES `beraudent`.`Arancel3` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arancel_Prestacion_Prestacion1`
    FOREIGN KEY (`Prestacion_id`)
    REFERENCES `beraudent`.`Prestacion3` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Arancel_Proceso2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Arancel_Proceso2` (
  `Arancel_Prestacion_Arancel_id` INT NOT NULL,
  `Arancel_Prestacion_Prestacion_id` INT NOT NULL,
  `Prestacion_Proceso_Proceso_id` INT NOT NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`Arancel_Prestacion_Arancel_id`, `Arancel_Prestacion_Prestacion_id`, `Prestacion_Proceso_Proceso_id`),
  INDEX `fk_Arancel_Prestacion_has_Prestacion_Proceso_Prestacion_Pro_idx` (`Prestacion_Proceso_Proceso_id` ASC),
  INDEX `fk_Arancel_Prestacion_has_Prestacion_Proceso_Arancel_Presta_idx` (`Arancel_Prestacion_Arancel_id` ASC, `Arancel_Prestacion_Prestacion_id` ASC),
  CONSTRAINT `fk_Arancel_Prestacion_has_Prestacion_Proceso_Arancel_Prestaci1`
    FOREIGN KEY (`Arancel_Prestacion_Arancel_id` , `Arancel_Prestacion_Prestacion_id`)
    REFERENCES `beraudent`.`Arancel_Prestacion2` (`Arancel_id` , `Prestacion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arancel_Prestacion_has_Prestacion_Proceso_Prestacion_Proce1`
    FOREIGN KEY (`Prestacion_Proceso_Proceso_id`)
    REFERENCES `beraudent`.`Prestacion_Proceso2` (`Proceso_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  `item_arancel_codigo_beraudent` VARCHAR(10) NOT NULL,
  `codigo_cliente` VARCHAR(10) NULL,
  `nomenclatura_cliente` VARCHAR(45) NULL,
  `detalle` VARCHAR(100) NULL,
  PRIMARY KEY (`item_arancel_codigo_beraudent`),
  CONSTRAINT `fk_detalle_item_arancel_item_arancel1`
    FOREIGN KEY (`item_arancel_codigo_beraudent`)
    REFERENCES `beraudent`.`item` (`codigo_beraudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`Atachmes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`Atachmes` (
  `item_arancel_codigo_beraudent` VARCHAR(10) NOT NULL,
  `trabajo_id` INT NOT NULL,
  PRIMARY KEY (`item_arancel_codigo_beraudent`, `trabajo_id`),
  INDEX `fk_item_arancel_has_trabajo_trabajo1_idx` (`trabajo_id` ASC),
  INDEX `fk_item_arancel_has_trabajo_item_arancel1_idx` (`item_arancel_codigo_beraudent` ASC),
  CONSTRAINT `fk_item_arancel_has_trabajo_item_arancel1`
    FOREIGN KEY (`item_arancel_codigo_beraudent`)
    REFERENCES `beraudent`.`item` (`codigo_beraudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_arancel_has_trabajo_trabajo1`
    FOREIGN KEY (`trabajo_id`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`item_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `beraudent`.`item_trabajo` (
  `item_arancel_codigo_beraudent` VARCHAR(10) NOT NULL,
  `trabajo_id` INT NOT NULL,
  PRIMARY KEY (`item_arancel_codigo_beraudent`, `trabajo_id`),
  INDEX `fk_item_arancel_has_trabajo_trabajo2_idx` (`trabajo_id` ASC),
  INDEX `fk_item_arancel_has_trabajo_item_arancel2_idx` (`item_arancel_codigo_beraudent` ASC),
  CONSTRAINT `fk_item_arancel_has_trabajo_item_arancel2`
    FOREIGN KEY (`item_arancel_codigo_beraudent`)
    REFERENCES `beraudent`.`item` (`codigo_beraudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_arancel_has_trabajo_trabajo2`
    FOREIGN KEY (`trabajo_id`)
    REFERENCES `beraudent`.`trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


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
  `Prestacion_posicion` TINYINT(1) UNSIGNED NOT NULL,
  `Abono_Cargo_id_abon_carg` INT NOT NULL,
  PRIMARY KEY (`Prestacion_id_solicitud`, `Prestacion_posicion`, `Abono_Cargo_id_abon_carg`),
  INDEX `fk_Prestacion_has_Abono_Cargo_Abono_Cargo1_idx` (`Abono_Cargo_id_abon_carg` ASC),
  INDEX `fk_Prestacion_has_Abono_Cargo_Prestacion1_idx` (`Prestacion_id_solicitud` ASC, `Prestacion_posicion` ASC),
  CONSTRAINT `fk_Prestacion_has_Abono_Cargo_Prestacion1`
    FOREIGN KEY (`Prestacion_posicion`)
    REFERENCES `beraudent`.`prestacion` (`posicion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
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
  `pago_id_pago` INT NOT NULL,
  `comprobante_id` VARCHAR(10) NOT NULL,
  `tipo_pago` ENUM('TF', 'TB', 'WP', 'CH') NULL,
  `numero` VARCHAR(20) NULL,
  `fecha_pago` DATE NULL,
  `fecha_vencimiento` DATE NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`pago_id_pago`, `comprobante_id`),
  INDEX `fk_pago_has_comprobante_comprobante1_idx` (`comprobante_id` ASC),
  INDEX `fk_pago_has_comprobante_pago1_idx` (`pago_id_pago` ASC),
  CONSTRAINT `fk_pago_has_comprobante_pago1`
    FOREIGN KEY (`pago_id_pago`)
    REFERENCES `beraudent`.`pago` (`id_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_has_comprobante_comprobante1`
    FOREIGN KEY (`comprobante_id`)
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
    REFERENCES `beraudent`.`prestacion` (`Solicitud_Pedido_nume_soli_pedi` , `posicion`)
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

