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
CREATE SCHEMA IF NOT EXISTS `beraudent` DEFAULT CHARACTER SET utf8 ;
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
  `id_cliente_df` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Datos_Facturacion_Cliente1_idx` (`id_cliente_df` ASC),
  CONSTRAINT `fk_Datos_Facturacion_Cliente1`
    FOREIGN KEY (`id_cliente_df`)
    REFERENCES `beraudent`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`sucursal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`sucursal` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`sucursal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(10) NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `tipo_cobro` ENUM('T', 'P') NULL DEFAULT 'T',
  `id_cliente_s` INT NOT NULL,
  `id_datos_facturacion_s` INT NOT NULL,
  `id_arancel_s` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sucursal_Cliente1_idx` (`id_cliente_s` ASC),
  INDEX `fk_Sucursal_Datos_Facturacion1_idx` (`id_datos_facturacion_s` ASC),
  INDEX `fk_sucursal_arancel1_idx` (`id_arancel_s` ASC),
  CONSTRAINT `fk_Sucursal_Cliente1`
    FOREIGN KEY (`id_cliente_s`)
    REFERENCES `beraudent`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_Datos_Facturacion1`
    FOREIGN KEY (`id_datos_facturacion_s`)
    REFERENCES `beraudent`.`datos_facturacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sucursal_arancel1`
    FOREIGN KEY (`id_arancel_s`)
    REFERENCES `beraudent`.`arancel` (`id`)
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
  `detalle` VARCHAR(45) NULL,
  `id_cliente_a` INT NOT NULL,
  PRIMARY KEY (`id`, `id_cliente_a`),
  INDEX `fk_Administrativo_Cliente1_idx` (`id_cliente_a` ASC),
  CONSTRAINT `fk_Administrativo_Cliente1`
    FOREIGN KEY (`id_cliente_a`)
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
  `id_sucursal_p` INT NOT NULL,
  PRIMARY KEY (`id`, `id_sucursal_p`),
  INDEX `fk_Personal_Sucursal1_idx` (`id_sucursal_p` ASC),
  CONSTRAINT `fk_Personal_Sucursal1`
    FOREIGN KEY (`id_sucursal_p`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`sucursal_odontologo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`sucursal_odontologo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`sucursal_odontologo` (
  `id_sucursal_so` INT NOT NULL,
  `id_odontologo_so` INT NOT NULL,
  PRIMARY KEY (`id_sucursal_so`, `id_odontologo_so`),
  INDEX `fk_sucursal_has_odontologo_odontologo1_idx` (`id_odontologo_so` ASC),
  INDEX `fk_sucursal_has_odontologo_sucursal1_idx` (`id_sucursal_so` ASC),
  CONSTRAINT `fk_sucursal_has_odontologo_sucursal1`
    FOREIGN KEY (`id_sucursal_so`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sucursal_has_odontologo_odontologo1`
    FOREIGN KEY (`id_odontologo_so`)
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
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `ot` VARCHAR(10) NULL,
  `id_sucursal_so_p` INT NOT NULL,
  `id_odontologo_so_p` INT NOT NULL,
  `id_paciente_p` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_pedido_sucursal_odontologo1_idx` (`id_sucursal_so_p` ASC, `id_odontologo_so_p` ASC),
  INDEX `fk_pedido_paciente1_idx` (`id_paciente_p` ASC),
  CONSTRAINT `fk_pedido_sucursal_odontologo1`
    FOREIGN KEY (`id_sucursal_so_p` , `id_odontologo_so_p`)
    REFERENCES `beraudent`.`sucursal_odontologo` (`id_sucursal_so` , `id_odontologo_so`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_paciente1`
    FOREIGN KEY (`id_paciente_p`)
    REFERENCES `beraudent`.`paciente` (`id`)
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
  `id` TINYINT(1) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`usuario` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(10) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `permisos` ENUM('A', 'S', 'E', 'T', 'D') NOT NULL COMMENT '\'A\'=Administrador\n\'S\'=Super Usuario \n\'U\'=Usuario solo con pocos atributos de modificación\n\'E\'=Ejecutivo\n\'T\'=Tecnico\n\'D\'=Doctor',
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
  `rut` VARCHAR(10) NULL,
  `id_area_e` TINYINT(1) NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_empleado_Area1_idx` (`id_area_e` ASC),
  INDEX `fk_empleado_usuario1_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_empleado_Area1`
    FOREIGN KEY (`id_area_e`)
    REFERENCES `beraudent`.`Area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `beraudent`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `id_arancel_i` INT NOT NULL,
  `id_producto_i` INT NOT NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_item_arancel_arancel1_idx` (`id_arancel_i` ASC),
  INDEX `fk_item_producto1_idx` (`id_producto_i` ASC),
  CONSTRAINT `fk_item_arancel_arancel1`
    FOREIGN KEY (`id_arancel_i`)
    REFERENCES `beraudent`.`arancel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_producto1`
    FOREIGN KEY (`id_producto_i`)
    REFERENCES `beraudent`.`producto` (`id`)
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
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '\n',
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
-- Table `beraudent`.`cancelacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`cancelacion` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`cancelacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(10) NULL,
  `periodo` VARCHAR(11) NULL COMMENT '2016-02-ENE   son 11 caracteres',
  `monto` FLOAT NULL,
  `descuento` FLOAT NULL DEFAULT 0,
  `total` FLOAT NULL,
  `detalle` VARCHAR(45) NULL,
  `id_comprobante_c` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cancelacion_comprobante1_idx` (`id_comprobante_c` ASC),
  CONSTRAINT `fk_cancelacion_comprobante1`
    FOREIGN KEY (`id_comprobante_c`)
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
  `codigo_item_ps` VARCHAR(10) NOT NULL,
  `numero_pedido_ps` VARCHAR(10) NOT NULL,
  `id_cancelacion_ps` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_producto_solicitado_item1_idx` (`codigo_item_ps` ASC),
  INDEX `fk_producto_solicitado_pedido1_idx` (`numero_pedido_ps` ASC),
  INDEX `fk_producto_solicitado_cancelacion1_idx` (`id_cancelacion_ps` ASC),
  CONSTRAINT `fk_producto_solicitado_item1`
    FOREIGN KEY (`codigo_item_ps`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_solicitado_pedido1`
    FOREIGN KEY (`numero_pedido_ps`)
    REFERENCES `beraudent`.`pedido` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_solicitado_cancelacion1`
    FOREIGN KEY (`id_cancelacion_ps`)
    REFERENCES `beraudent`.`cancelacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`prueba_realizada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`prueba_realizada` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`prueba_realizada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_producto_sps` INT NOT NULL,
  `id_producto_solicitado_sps` VARCHAR(12) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `fecha_egreso` DATE NOT NULL,
  `estado` ENUM('I', 'P', 'T', 'D') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_producto_has_producto_solicitado_producto_solicitado1_idx` (`id_producto_solicitado_sps` ASC),
  INDEX `fk_producto_has_producto_solicitado_producto1_idx` (`id_producto_sps` ASC),
  CONSTRAINT `fk_producto_has_producto_solicitado_producto1`
    FOREIGN KEY (`id_producto_sps`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_producto_solicitado_producto_solicitado1`
    FOREIGN KEY (`id_producto_solicitado_sps`)
    REFERENCES `beraudent`.`producto_solicitado` (`id`)
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
  `codigo_empleado_fr` VARCHAR(10) NOT NULL,
  `id_prueba_realizada_fr` INT NOT NULL,
  `codigo_fase_fr` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fase_realizada_empleado1_idx` (`codigo_empleado_fr` ASC),
  INDEX `fk_fase_realizada_prueba_realizada1_idx` (`id_prueba_realizada_fr` ASC),
  INDEX `fk_fase_realizada_fase1_idx` (`codigo_fase_fr` ASC),
  CONSTRAINT `fk_fase_realizada_empleado1`
    FOREIGN KEY (`codigo_empleado_fr`)
    REFERENCES `beraudent`.`empleado` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fase_realizada_prueba_realizada1`
    FOREIGN KEY (`id_prueba_realizada_fr`)
    REFERENCES `beraudent`.`prueba_realizada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fase_realizada_fase1`
    FOREIGN KEY (`codigo_fase_fr`)
    REFERENCES `beraudent`.`fase` (`codigo`)
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
  `id_sucursal_u` INT NOT NULL,
  PRIMARY KEY (`id`, `id_sucursal_u`),
  INDEX `fk_Ubicacion_Sucursal1_idx` (`id_sucursal_u` ASC),
  CONSTRAINT `fk_Ubicacion_Sucursal1`
    FOREIGN KEY (`id_sucursal_u`)
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `detalle` VARCHAR(45) NULL,
  `monto` FLOAT NULL,
  `tipo` ENUM('A', 'C') NULL,
  `cancelacion` VARCHAR(10) NULL COMMENT 'Contendra el numero de orden de compra o el grupo de cancelacion dependiendo de la sucursal, esto se puede calcular con querys pero considero correcto reflejarlo en un campo solo para referenciar',
  `id_comprobante` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_abono_cargo_comprobante1_idx` (`id_comprobante` ASC),
  CONSTRAINT `fk_abono_cargo_comprobante1`
    FOREIGN KEY (`id_comprobante`)
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_recibo` VARCHAR(8) NULL,
  `fecha_recibo` DATETIME NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`grupo` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`grupo` (
  `id` INT NOT NULL AUTO_INCREMENT,
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
  `codigo_item_di` VARCHAR(10) NOT NULL,
  `codigo_cliente` VARCHAR(10) NULL,
  `nomenclatura_cliente` VARCHAR(45) NULL,
  `detalle` VARCHAR(100) NULL,
  PRIMARY KEY (`codigo_item_di`),
  CONSTRAINT `fk_detalle_item_item1`
    FOREIGN KEY (`codigo_item_di`)
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
  `id_pago_pc` INT NOT NULL,
  `id_comprobante` INT NOT NULL,
  `tipo_pago` ENUM('TF', 'TB', 'WP', 'CH') NULL,
  `fecha` DATE NULL,
  `fecha_vencimiento` DATE NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pago_pc`, `id_comprobante`),
  INDEX `fk_pago_has_comprobante_pago1_idx` (`id_pago_pc` ASC),
  INDEX `fk_pago_comprobante_comprobante1_idx` (`id_comprobante` ASC),
  CONSTRAINT `fk_pago_has_comprobante_pago1`
    FOREIGN KEY (`id_pago_pc`)
    REFERENCES `beraudent`.`pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_comprobante_comprobante1`
    FOREIGN KEY (`id_comprobante`)
    REFERENCES `beraudent`.`comprobante` (`id`)
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
  `codigo_fase_fp` INT NOT NULL,
  `id_producto_fp` INT NOT NULL,
  PRIMARY KEY (`codigo_fase_fp`, `id_producto_fp`),
  INDEX `fk_fase_has_producto_producto1_idx` (`id_producto_fp` ASC),
  INDEX `fk_fase_has_producto_fase1_idx` (`codigo_fase_fp` ASC),
  CONSTRAINT `fk_fase_has_producto_fase1`
    FOREIGN KEY (`codigo_fase_fp`)
    REFERENCES `beraudent`.`fase` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fase_has_producto_producto1`
    FOREIGN KEY (`id_producto_fp`)
    REFERENCES `beraudent`.`producto` (`id`)
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
  `id_producto_pg` INT NOT NULL,
  `id_grupo_pg` INT NOT NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id_producto_pg`, `id_grupo_pg`),
  INDEX `fk_producto_has_grupo_grupo1_idx` (`id_grupo_pg` ASC),
  INDEX `fk_producto_has_grupo_producto1_idx` (`id_producto_pg` ASC),
  CONSTRAINT `fk_producto_has_grupo_producto1`
    FOREIGN KEY (`id_producto_pg`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_grupo_grupo1`
    FOREIGN KEY (`id_grupo_pg`)
    REFERENCES `beraudent`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`subproducto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`subproducto` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`subproducto` (
  `id_producto_padre_s` INT NOT NULL,
  `id_producto_hijo_s` INT NOT NULL,
  PRIMARY KEY (`id_producto_padre_s`, `id_producto_hijo_s`),
  INDEX `fk_producto_has_producto_producto2_idx` (`id_producto_hijo_s` ASC),
  INDEX `fk_producto_has_producto_producto1_idx` (`id_producto_padre_s` ASC),
  CONSTRAINT `fk_producto_has_producto_producto1`
    FOREIGN KEY (`id_producto_padre_s`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_producto_producto2`
    FOREIGN KEY (`id_producto_hijo_s`)
    REFERENCES `beraudent`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`control_cambios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`control_cambios` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`control_cambios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empleado_codigo` VARCHAR(10) NOT NULL,
  `prueba_realizada_id` INT NOT NULL,
  `modificacion` VARCHAR(45) NULL,
  INDEX `fk_empleado_has_prueba_realizada_prueba_realizada1_idx` (`prueba_realizada_id` ASC),
  INDEX `fk_empleado_has_prueba_realizada_empleado1_idx` (`empleado_codigo` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_empleado_has_prueba_realizada_empleado1`
    FOREIGN KEY (`empleado_codigo`)
    REFERENCES `beraudent`.`empleado` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_has_prueba_realizada_prueba_realizada1`
    FOREIGN KEY (`prueba_realizada_id`)
    REFERENCES `beraudent`.`prueba_realizada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`descuento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`descuento` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`descuento` (
  `id_sucursal` INT NOT NULL,
  `porcentaje` INT NULL,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`id_sucursal`),
  CONSTRAINT `fk_descuento_sucursal1`
    FOREIGN KEY (`id_sucursal`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beraudent`.`precio_expcional`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`precio_expcional` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`precio_expcional` (
  `id_sucursal_pe` INT NOT NULL,
  `codigo_item_pe` VARCHAR(10) NOT NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`id_sucursal_pe`, `codigo_item_pe`),
  INDEX `fk_sucursal_has_item_item1_idx` (`codigo_item_pe` ASC),
  INDEX `fk_sucursal_has_item_sucursal1_idx` (`id_sucursal_pe` ASC),
  CONSTRAINT `fk_sucursal_has_item_sucursal1`
    FOREIGN KEY (`id_sucursal_pe`)
    REFERENCES `beraudent`.`sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sucursal_has_item_item1`
    FOREIGN KEY (`codigo_item_pe`)
    REFERENCES `beraudent`.`item` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `beraudent`.`dependencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beraudent`.`dependencia` ;

CREATE TABLE IF NOT EXISTS `beraudent`.`dependencia` (
  `id_arancel_base_d` INT NOT NULL,
  `id_arancel_derivado_d` INT NOT NULL,
  `porcentaje` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_arancel_base_d`, `id_arancel_derivado_d`),
  INDEX `fk_arancel_has_arancel_arancel2_idx` (`id_arancel_derivado_d` ASC),
  INDEX `fk_arancel_has_arancel_arancel1_idx` (`id_arancel_base_d` ASC),
  CONSTRAINT `fk_arancel_has_arancel_arancel1`
    FOREIGN KEY (`id_arancel_base_d`)
    REFERENCES `beraudent`.`arancel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_arancel_has_arancel_arancel2`
    FOREIGN KEY (`id_arancel_derivado_d`)
    REFERENCES `beraudent`.`arancel` (`id`)
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
  `id_abono_cargo_acp` INT NOT NULL,
  `id_producto_solicitado_acp` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_abono_cargo_acp`, `id_producto_solicitado_acp`),
  INDEX `fk_abono_cargo_has_producto_solicitado_producto_solicitado1_idx` (`id_producto_solicitado_acp` ASC),
  INDEX `fk_abono_cargo_has_producto_solicitado_abono_cargo1_idx` (`id_abono_cargo_acp` ASC),
  CONSTRAINT `fk_abono_cargo_has_producto_solicitado_abono_cargo1`
    FOREIGN KEY (`id_abono_cargo_acp`)
    REFERENCES `beraudent`.`abono_cargo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_abono_cargo_has_producto_solicitado_producto_solicitado1`
    FOREIGN KEY (`id_producto_solicitado_acp`)
    REFERENCES `beraudent`.`producto_solicitado` (`id`)
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
INSERT INTO `beraudent`.`usuario` (`id`, `user`, `password`, `permisos`) VALUES (DEFAULT, 'indefinido', '11111', 'U');
INSERT INTO `beraudent`.`usuario` (`id`, `user`, `password`, `permisos`) VALUES (DEFAULT, 'admin', '013821', 'A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `beraudent`.`comprobante`
-- -----------------------------------------------------
START TRANSACTION;
USE `beraudent`;
INSERT INTO `beraudent`.`comprobante` (`id`, `numero`, `tipo`, `fecha`, `referencia`, `rut_cliente`, `razon_cliente`, `detalle`, `valor_neto`) VALUES (DEFAULT, 'NO CREADO', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `beraudent`.`cancelacion`
-- -----------------------------------------------------
START TRANSACTION;
USE `beraudent`;
INSERT INTO `beraudent`.`cancelacion` (`id`, `codigo`, `periodo`, `monto`, `descuento`, `total`, `detalle`, `id_comprobante_c`) VALUES (DEFAULT, 'IMPAGO', NULL, NULL, NULL, NULL, NULL, 1);

COMMIT;

