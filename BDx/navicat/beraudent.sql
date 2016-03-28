CREATE TABLE [abono_cargo] (
[id] int NOT NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[monto] real NULL,
[tipo] nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL,
[cancelacion] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[id_comprobante] int NOT NULL,
CONSTRAINT [PK__abono_ca__3213E83F05D84357] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_abono_cargo_comprobante1_idx] ON [abono_cargo] ([id_comprobante]  ASC)
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'abono_cargo', 
'COLUMN', N'cancelacion')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'Contendra el numero de orden de compra o el grupo de cancelacion dependiendo de la sucursal, esto se puede calcular con querys pero considero correcto reflejarlo en un campo solo para referenciar'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'abono_cargo'
, @level2type = 'COLUMN', @level2name = N'cancelacion'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Contendra el numero de orden de compra o el grupo de cancelacion dependiendo de la sucursal, esto se puede calcular con querys pero considero correcto reflejarlo en un campo solo para referenciar'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'abono_cargo'
, @level2type = 'COLUMN', @level2name = N'cancelacion'
GO

CREATE TABLE [abono_cargo_producto] (
[id_abono_cargo_acp] int NOT NULL,
[id_producto_solicitado_acp] nvarchar(12) COLLATE Modern_Spanish_CI_AS NOT NULL,
CONSTRAINT [PK__abono_ca__3EB4E963E55E7215] PRIMARY KEY ([id_abono_cargo_acp], [id_producto_solicitado_acp]) 
)
GO

CREATE INDEX [fk_abono_cargo_has_producto_solicitado_producto_solicitado1_idx] ON [abono_cargo_producto] ([id_producto_solicitado_acp]  ASC)
GO
CREATE INDEX [fk_abono_cargo_has_producto_solicitado_abono_cargo1_idx] ON [abono_cargo_producto] ([id_abono_cargo_acp]  ASC)
GO

CREATE TABLE [administrativo] (
[id] int NOT NULL,
[nombres] nvarchar(35) COLLATE Modern_Spanish_CI_AS NULL,
[apellidos] nvarchar(35) COLLATE Modern_Spanish_CI_AS NULL,
[email] nvarchar(25) COLLATE Modern_Spanish_CI_AS NULL,
[celular] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[telefono] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[cargo] nvarchar(15) COLLATE Modern_Spanish_CI_AS NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[id_cliente_a] int NOT NULL,
CONSTRAINT [PK__administ__000ED5CC17AAA5EB] PRIMARY KEY ([id], [id_cliente_a]) 
)
GO

CREATE INDEX [fk_Administrativo_Cliente1_idx] ON [administrativo] ([id_cliente_a]  ASC)
GO

CREATE TABLE [arancel] (
[id] int NOT NULL,
[nombre] nvarchar(20) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__arancel__3213E83F065E0EF6] PRIMARY KEY ([id]) 
)
GO

CREATE TABLE [area] (
[id] tinyint NOT NULL,
[nombre] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
CONSTRAINT [PK__area__3213E83F666B158D] PRIMARY KEY ([id]) 
)
GO

CREATE UNIQUE INDEX [nombre_UNIQUE] ON [area] ([nombre]  ASC)
GO

CREATE TABLE [cancelacion] (
[id] int NOT NULL,
[codigo] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[periodo] nvarchar(11) COLLATE Modern_Spanish_CI_AS NULL,
[monto] real NULL,
[descuento] real NULL,
[total] real NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[id_comprobante_c] int NOT NULL,
CONSTRAINT [PK__cancelac__3213E83F7C6B8F14] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_cancelacion_comprobante1_idx] ON [cancelacion] ([id_comprobante_c]  ASC)
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'cancelacion', 
'COLUMN', N'periodo')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'2016-02-ENE   son 11 caracteres'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'cancelacion'
, @level2type = 'COLUMN', @level2name = N'periodo'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'2016-02-ENE   son 11 caracteres'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'cancelacion'
, @level2type = 'COLUMN', @level2name = N'periodo'
GO

CREATE TABLE [cliente] (
[id] int NOT NULL,
[nombre] nvarchar(25) COLLATE Modern_Spanish_CI_AS NOT NULL,
[direccion_admninistracion] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__cliente__3213E83FEFFC5B4E] PRIMARY KEY ([id]) 
)
GO

CREATE TABLE [comprobante] (
[id] int NOT NULL,
[numero] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[tipo] nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL,
[fecha] date NULL,
[referencia] nvarchar(30) COLLATE Modern_Spanish_CI_AS NULL,
[rut_cliente] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[razon_cliente] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[valor_neto] real NULL,
CONSTRAINT [PK__comproba__3213E83FE2431D76] PRIMARY KEY ([id]) 
)
GO

IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'comprobante', 
'COLUMN', N'id')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'
'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'comprobante'
, @level2type = 'COLUMN', @level2name = N'id'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'
'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'comprobante'
, @level2type = 'COLUMN', @level2name = N'id'
GO

CREATE TABLE [control_cambios] (
[id] int NOT NULL,
[empleado_codigo] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[prueba_realizada_id] int NOT NULL,
[modificacion] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__control___3213E83FAA299415] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_empleado_has_prueba_realizada_prueba_realizada1_idx] ON [control_cambios] ([prueba_realizada_id]  ASC)
GO
CREATE INDEX [fk_empleado_has_prueba_realizada_empleado1_idx] ON [control_cambios] ([empleado_codigo]  ASC)
GO

CREATE TABLE [datos_facturacion] (
[id] int NOT NULL,
[grupo_facturacion] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
[razon_social] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
[nombre_fantasia] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
[direccion] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
[rut] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[id_cliente_df] int NOT NULL,
CONSTRAINT [PK__datos_fa__3213E83F57296BA1] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_Datos_Facturacion_Cliente1_idx] ON [datos_facturacion] ([id_cliente_df]  ASC)
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'datos_facturacion', 
'COLUMN', N'grupo_facturacion')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'nombre del grupo de facturacion por ejemplo OMESA de vidaintegra contiene muchos sucursales que se facturan con este mismo grupo (misma razon social, etc)'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'datos_facturacion'
, @level2type = 'COLUMN', @level2name = N'grupo_facturacion'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'nombre del grupo de facturacion por ejemplo OMESA de vidaintegra contiene muchos sucursales que se facturan con este mismo grupo (misma razon social, etc)'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'datos_facturacion'
, @level2type = 'COLUMN', @level2name = N'grupo_facturacion'
GO

CREATE TABLE [dependencia] (
[id_arancel_base_d] int NOT NULL,
[id_arancel_derivado_d] int NOT NULL,
[porcentaje] int NOT NULL,
CONSTRAINT [PK__dependen__04E6F9135CEB311C] PRIMARY KEY ([id_arancel_base_d], [id_arancel_derivado_d]) 
)
GO

CREATE INDEX [fk_arancel_has_arancel_arancel2_idx] ON [dependencia] ([id_arancel_derivado_d]  ASC)
GO
CREATE INDEX [fk_arancel_has_arancel_arancel1_idx] ON [dependencia] ([id_arancel_base_d]  ASC)
GO

CREATE TABLE [descuento] (
[id_sucursal] int NOT NULL,
[porcentaje] int NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__descuent__4C75801341A086F3] PRIMARY KEY ([id_sucursal]) 
)
GO

CREATE TABLE [detalle_item] (
[codigo_item_di] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[codigo_cliente] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[nomenclatura_cliente] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[detalle] nvarchar(100) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__detalle___CEBD633EF1CC1790] PRIMARY KEY ([codigo_item_di]) 
)
GO

CREATE TABLE [empleado] (
[codigo] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[apellidos] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[nombres] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[rut] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[email] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[id_area_e] tinyint NOT NULL,
[id_usuario_e] int NOT NULL,
CONSTRAINT [PK__empleado__40F9A207A46D6814] PRIMARY KEY ([codigo]) 
)
GO

CREATE INDEX [fk_empleado_Area1_idx] ON [empleado] ([id_area_e]  ASC)
GO
CREATE INDEX [fk_empleado_usuario1_idx] ON [empleado] ([id_usuario_e]  ASC)
GO

CREATE TABLE [fase] (
[codigo] int NOT NULL,
[nombre] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
[costo_comision] real NOT NULL,
CONSTRAINT [PK__fase__40F9A2070160CA31] PRIMARY KEY ([codigo]) 
)
GO

CREATE TABLE [fase_producto] (
[codigo_fase_fp] int NOT NULL,
[id_producto_fp] int NOT NULL,
CONSTRAINT [PK__fase_pro__6782E859626FCE0E] PRIMARY KEY ([codigo_fase_fp], [id_producto_fp]) 
)
GO

CREATE INDEX [fk_fase_has_producto_producto1_idx] ON [fase_producto] ([id_producto_fp]  ASC)
GO
CREATE INDEX [fk_fase_has_producto_fase1_idx] ON [fase_producto] ([codigo_fase_fp]  ASC)
GO

CREATE TABLE [fase_realizada] (
[id] int NOT NULL,
[piezas] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[precio] real NULL,
[color] nvarchar(50) COLLATE Modern_Spanish_CI_AS NULL,
[costo_comision] real NULL,
[inicio] datetime2(7) NULL,
[fin] datetime2(7) NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[codigo_empleado_fr] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[id_prueba_realizada_fr] int NOT NULL,
[codigo_fase_fr] int NOT NULL,
CONSTRAINT [PK__fase_rea__3213E83F9ADA050E] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_fase_realizada_empleado1_idx] ON [fase_realizada] ([codigo_empleado_fr]  ASC)
GO
CREATE INDEX [fk_fase_realizada_prueba_realizada1_idx] ON [fase_realizada] ([id_prueba_realizada_fr]  ASC)
GO
CREATE INDEX [fk_fase_realizada_fase1_idx] ON [fase_realizada] ([codigo_fase_fr]  ASC)
GO

CREATE TABLE [grupo] (
[id] int NOT NULL,
[nombre] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__grupo__3213E83F0AE8343C] PRIMARY KEY ([id]) 
)
GO

CREATE TABLE [item] (
[codigo] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[id_arancel_i] int NOT NULL,
[id_producto_i] int NOT NULL,
[precio] real NULL,
CONSTRAINT [PK__item__40F9A2075C8EE392] PRIMARY KEY ([codigo]) 
)
GO

CREATE INDEX [fk_item_arancel_arancel1_idx] ON [item] ([id_arancel_i]  ASC)
GO
CREATE INDEX [fk_item_producto1_idx] ON [item] ([id_producto_i]  ASC)
GO

CREATE TABLE [odontologo] (
[id] int NOT NULL,
[apellidos] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[nombres] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[email1] nvarchar(25) COLLATE Modern_Spanish_CI_AS NULL,
[email2] nvarchar(25) COLLATE Modern_Spanish_CI_AS NULL,
[celular] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__odontolo__3213E83F53A5219C] PRIMARY KEY ([id]) 
)
GO

CREATE TABLE [paciente] (
[id] int NOT NULL,
[rut] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[apellidos] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[nombres] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__paciente__3213E83F371EA913] PRIMARY KEY ([id]) 
)
GO

CREATE TABLE [pago] (
[id] int NOT NULL,
[numero_recibo] nvarchar(8) COLLATE Modern_Spanish_CI_AS NULL,
[fecha_recibo] datetime2(7) NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__pago__3213E83FF4214056] PRIMARY KEY ([id]) 
)
GO

CREATE TABLE [pago_comprobante] (
[id_pago_pc] int NOT NULL,
[id_comprobante] int NOT NULL,
[tipo_pago] nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL,
[fecha] date NULL,
[fecha_vencimiento] date NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__pago_com__5006AC25F58A1189] PRIMARY KEY ([id_pago_pc], [id_comprobante]) 
)
GO

CREATE INDEX [fk_pago_has_comprobante_pago1_idx] ON [pago_comprobante] ([id_pago_pc]  ASC)
GO
CREATE INDEX [fk_pago_comprobante_comprobante1_idx] ON [pago_comprobante] ([id_comprobante]  ASC)
GO

CREATE TABLE [pedido] (
[numero] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[episodio] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[ot] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[id_sucursal_so_p] int NOT NULL,
[id_odontologo_so_p] int NOT NULL,
[id_paciente_p] int NOT NULL,
CONSTRAINT [PK__pedido__FC77F210E4667BBA] PRIMARY KEY ([numero]) 
)
GO

CREATE INDEX [fk_pedido_sucursal_odontologo1_idx] ON [pedido] ([id_sucursal_so_p]  ASC, [id_odontologo_so_p]  ASC)
GO
CREATE INDEX [fk_pedido_paciente1_idx] ON [pedido] ([id_paciente_p]  ASC)
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'pedido', 
'COLUMN', N'episodio')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'Existen raros casos donde hay mas de un episodio por solped, colocarlo com nota'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'pedido'
, @level2type = 'COLUMN', @level2name = N'episodio'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Existen raros casos donde hay mas de un episodio por solped, colocarlo com nota'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'pedido'
, @level2type = 'COLUMN', @level2name = N'episodio'
GO

CREATE TABLE [personal] (
[id] int NOT NULL,
[nombres] nvarchar(35) COLLATE Modern_Spanish_CI_AS NULL,
[apellidos] nvarchar(35) COLLATE Modern_Spanish_CI_AS NULL,
[email] nvarchar(25) COLLATE Modern_Spanish_CI_AS NULL,
[celular] int NULL,
[telefono] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[cargo] nvarchar(15) COLLATE Modern_Spanish_CI_AS NULL,
[id_sucursal_p] int NOT NULL,
CONSTRAINT [PK__personal__EDB970A79B943ED8] PRIMARY KEY ([id], [id_sucursal_p]) 
)
GO

CREATE INDEX [fk_Personal_Sucursal1_idx] ON [personal] ([id_sucursal_p]  ASC)
GO

CREATE TABLE [precio_expcional] (
[id_sucursal_pe] int NOT NULL,
[codigo_item_pe] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[precio] real NULL,
CONSTRAINT [PK__precio_e__5665AC2FF8D92468] PRIMARY KEY ([id_sucursal_pe], [codigo_item_pe]) 
)
GO

CREATE INDEX [fk_sucursal_has_item_item1_idx] ON [precio_expcional] ([codigo_item_pe]  ASC)
GO
CREATE INDEX [fk_sucursal_has_item_sucursal1_idx] ON [precio_expcional] ([id_sucursal_pe]  ASC)
GO

CREATE TABLE [producto] (
[id] int NOT NULL,
[nombre] nvarchar(45) COLLATE Modern_Spanish_CI_AS NOT NULL,
[detalle] nvarchar(100) COLLATE Modern_Spanish_CI_AS NULL,
[etapa] nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__producto__3213E83F529E74C5] PRIMARY KEY ([id]) 
)
GO

CREATE TABLE [producto_grupo] (
[id_producto_pg] int NOT NULL,
[id_grupo_pg] int NOT NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
CONSTRAINT [PK__producto__F25721BFF22A6B09] PRIMARY KEY ([id_producto_pg], [id_grupo_pg]) 
)
GO

CREATE INDEX [fk_producto_has_grupo_grupo1_idx] ON [producto_grupo] ([id_grupo_pg]  ASC)
GO
CREATE INDEX [fk_producto_has_grupo_producto1_idx] ON [producto_grupo] ([id_producto_pg]  ASC)
GO

CREATE TABLE [producto_solicitado] (
[id] nvarchar(12) COLLATE Modern_Spanish_CI_AS NOT NULL,
[posicion] tinyint NOT NULL,
[fecha_registro] date NULL,
[fecha_entrega] date NULL,
[cant_pres] tinyint NULL,
[precio] real NOT NULL,
[null_pres] nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL,
[detalle] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[codigo_item_ps] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[numero_pedido_ps] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[id_cancelacion_ps] int NOT NULL,
CONSTRAINT [PK__producto__3213E83FC2C39FC2] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_producto_solicitado_item1_idx] ON [producto_solicitado] ([codigo_item_ps]  ASC)
GO
CREATE INDEX [fk_producto_solicitado_pedido1_idx] ON [producto_solicitado] ([numero_pedido_ps]  ASC)
GO
CREATE INDEX [fk_producto_solicitado_cancelacion1_idx] ON [producto_solicitado] ([id_cancelacion_ps]  ASC)
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'producto_solicitado', 
'COLUMN', N'null_pres')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'las posiciones pueden anularse con basurero, bomba  o valor total=0
siempre es bueno tener respald de que posicion esta nula'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'producto_solicitado'
, @level2type = 'COLUMN', @level2name = N'null_pres'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'las posiciones pueden anularse con basurero, bomba  o valor total=0
siempre es bueno tener respald de que posicion esta nula'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'producto_solicitado'
, @level2type = 'COLUMN', @level2name = N'null_pres'
GO

CREATE TABLE [prueba_realizada] (
[id] int NOT NULL,
[id_producto_sps] int NOT NULL,
[id_producto_solicitado_sps] nvarchar(12) COLLATE Modern_Spanish_CI_AS NOT NULL,
[fecha_ingreso] date NOT NULL,
[fecha_egreso] date NOT NULL,
[estado] nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL,
CONSTRAINT [PK__prueba_r__3213E83FAA882B4B] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_producto_has_producto_solicitado_producto_solicitado1_idx] ON [prueba_realizada] ([id_producto_solicitado_sps]  ASC)
GO
CREATE INDEX [fk_producto_has_producto_solicitado_producto1_idx] ON [prueba_realizada] ([id_producto_sps]  ASC)
GO

CREATE TABLE [subproducto] (
[id_producto_padre_s] int NOT NULL,
[id_producto_hijo_s] int NOT NULL,
CONSTRAINT [PK__subprodu__B92577351B737128] PRIMARY KEY ([id_producto_padre_s], [id_producto_hijo_s]) 
)
GO

CREATE INDEX [fk_producto_has_producto_producto2_idx] ON [subproducto] ([id_producto_hijo_s]  ASC)
GO
CREATE INDEX [fk_producto_has_producto_producto1_idx] ON [subproducto] ([id_producto_padre_s]  ASC)
GO

CREATE TABLE [sucursal] (
[id] int NOT NULL,
[codigo] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
[nombre] nvarchar(25) COLLATE Modern_Spanish_CI_AS NOT NULL,
[tipo_cobro] nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL,
[id_cliente_s] int NOT NULL,
[id_datos_facturacion_s] int NOT NULL,
[id_arancel_s] int NOT NULL,
CONSTRAINT [PK__sucursal__3213E83F8526B87D] PRIMARY KEY ([id]) 
)
GO

CREATE INDEX [fk_Sucursal_Cliente1_idx] ON [sucursal] ([id_cliente_s]  ASC)
GO
CREATE INDEX [fk_Sucursal_Datos_Facturacion1_idx] ON [sucursal] ([id_datos_facturacion_s]  ASC)
GO
CREATE INDEX [fk_sucursal_arancel1_idx] ON [sucursal] ([id_arancel_s]  ASC)
GO

CREATE TABLE [sucursal_odontologo] (
[id_sucursal_so] int NOT NULL,
[id_odontologo_so] int NOT NULL,
CONSTRAINT [PK__sucursal__B2F65B689BD754F1] PRIMARY KEY ([id_sucursal_so], [id_odontologo_so]) 
)
GO

CREATE INDEX [fk_sucursal_has_odontologo_odontologo1_idx] ON [sucursal_odontologo] ([id_odontologo_so]  ASC)
GO
CREATE INDEX [fk_sucursal_has_odontologo_sucursal1_idx] ON [sucursal_odontologo] ([id_sucursal_so]  ASC)
GO

CREATE TABLE [ubicacion] (
[id] int NOT NULL,
[direccion] nvarchar(30) COLLATE Modern_Spanish_CI_AS NOT NULL,
[comu_ubic] nvarchar(15) COLLATE Modern_Spanish_CI_AS NULL,
[regi_ubic] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[tel1_ubic] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[tel2_ubic] nvarchar(45) COLLATE Modern_Spanish_CI_AS NULL,
[id_sucursal_u] int NOT NULL,
CONSTRAINT [PK__ubicacio__3DB970A00BD1407E] PRIMARY KEY ([id], [id_sucursal_u]) 
)
GO

CREATE INDEX [fk_Ubicacion_Sucursal1_idx] ON [ubicacion] ([id_sucursal_u]  ASC)
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'ubicacion', 
'COLUMN', N'direccion')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'esta direccion debe contener el tipo (calle, jiron o avenida en abreviatura), el numero y el departamento si fuera necesasrio.'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'ubicacion'
, @level2type = 'COLUMN', @level2name = N'direccion'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'esta direccion debe contener el tipo (calle, jiron o avenida en abreviatura), el numero y el departamento si fuera necesasrio.'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'ubicacion'
, @level2type = 'COLUMN', @level2name = N'direccion'
GO

CREATE TABLE [usuario] (
[id] int NOT NULL,
[user] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
[password] nvarchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL,
[permisos] nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL,
CONSTRAINT [PK__usuario__3213E83FA7E01622] PRIMARY KEY ([id]) 
)
GO

CREATE UNIQUE INDEX [user_UNIQUE] ON [usuario] ([user]  ASC)
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'', 
'TABLE', N'usuario', 
'COLUMN', N'permisos')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'''A''=Administrador
''S''=Super Usuario 
''U''=Usuario solo con pocos atributos de modificación
''E''=Ejecutivo
''T''=Tecnico
''D''=Doctor'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'usuario'
, @level2type = 'COLUMN', @level2name = N'permisos'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'''A''=Administrador
''S''=Super Usuario 
''U''=Usuario solo con pocos atributos de modificación
''E''=Ejecutivo
''T''=Tecnico
''D''=Doctor'
, @level0type = 'SCHEMA', @level0name = N''
, @level1type = 'TABLE', @level1name = N'usuario'
, @level2type = 'COLUMN', @level2name = N'permisos'
GO


ALTER TABLE [abono_cargo] ADD CONSTRAINT [FK__abono_car__id_co__1BE81D6E] FOREIGN KEY ([id_comprobante]) REFERENCES [comprobante] ([id])
GO
ALTER TABLE [abono_cargo_producto] ADD CONSTRAINT [FK__abono_car__id_ab__1CDC41A7] FOREIGN KEY ([id_abono_cargo_acp]) REFERENCES [abono_cargo] ([id])
GO
ALTER TABLE [abono_cargo_producto] ADD CONSTRAINT [FK__abono_car__id_pr__1DD065E0] FOREIGN KEY ([id_producto_solicitado_acp]) REFERENCES [producto_solicitado] ([id])
GO
ALTER TABLE [administrativo] ADD CONSTRAINT [FK__administr__id_cl__1EC48A19] FOREIGN KEY ([id_cliente_a]) REFERENCES [cliente] ([id])
GO
ALTER TABLE [cancelacion] ADD CONSTRAINT [FK__cancelaci__id_co__1FB8AE52] FOREIGN KEY ([id_comprobante_c]) REFERENCES [comprobante] ([id])
GO
ALTER TABLE [control_cambios] ADD CONSTRAINT [FK__control_c__emple__20ACD28B] FOREIGN KEY ([empleado_codigo]) REFERENCES [empleado] ([codigo])
GO
ALTER TABLE [control_cambios] ADD CONSTRAINT [FK__control_c__prueb__21A0F6C4] FOREIGN KEY ([prueba_realizada_id]) REFERENCES [prueba_realizada] ([id])
GO
ALTER TABLE [datos_facturacion] ADD CONSTRAINT [FK__datos_fac__id_cl__22951AFD] FOREIGN KEY ([id_cliente_df]) REFERENCES [cliente] ([id])
GO
ALTER TABLE [dependencia] ADD CONSTRAINT [FK__dependenc__id_ar__23893F36] FOREIGN KEY ([id_arancel_base_d]) REFERENCES [arancel] ([id])
GO
ALTER TABLE [dependencia] ADD CONSTRAINT [FK__dependenc__id_ar__247D636F] FOREIGN KEY ([id_arancel_derivado_d]) REFERENCES [arancel] ([id])
GO
ALTER TABLE [descuento] ADD CONSTRAINT [FK__descuento__id_su__257187A8] FOREIGN KEY ([id_sucursal]) REFERENCES [sucursal] ([id])
GO
ALTER TABLE [detalle_item] ADD CONSTRAINT [FK__detalle_i__codig__2665ABE1] FOREIGN KEY ([codigo_item_di]) REFERENCES [item] ([codigo])
GO
ALTER TABLE [empleado] ADD CONSTRAINT [FK__empleado__id_are__2759D01A] FOREIGN KEY ([id_area_e]) REFERENCES [area] ([id])
GO
ALTER TABLE [empleado] ADD CONSTRAINT [FK__empleado__id_usu__284DF453] FOREIGN KEY ([id_usuario_e]) REFERENCES [usuario] ([id])
GO
ALTER TABLE [fase_producto] ADD CONSTRAINT [FK__fase_prod__codig__2942188C] FOREIGN KEY ([codigo_fase_fp]) REFERENCES [fase] ([codigo])
GO
ALTER TABLE [fase_producto] ADD CONSTRAINT [FK__fase_prod__id_pr__2A363CC5] FOREIGN KEY ([id_producto_fp]) REFERENCES [producto] ([id])
GO
ALTER TABLE [fase_realizada] ADD CONSTRAINT [FK__fase_real__codig__2B2A60FE] FOREIGN KEY ([codigo_empleado_fr]) REFERENCES [empleado] ([codigo])
GO
ALTER TABLE [fase_realizada] ADD CONSTRAINT [FK__fase_real__codig__2C1E8537] FOREIGN KEY ([codigo_fase_fr]) REFERENCES [fase] ([codigo])
GO
ALTER TABLE [fase_realizada] ADD CONSTRAINT [FK__fase_real__id_pr__2D12A970] FOREIGN KEY ([id_prueba_realizada_fr]) REFERENCES [prueba_realizada] ([id])
GO
ALTER TABLE [item] ADD CONSTRAINT [FK__item__id_arancel__2E06CDA9] FOREIGN KEY ([id_arancel_i]) REFERENCES [arancel] ([id])
GO
ALTER TABLE [item] ADD CONSTRAINT [FK__item__id_product__2EFAF1E2] FOREIGN KEY ([id_producto_i]) REFERENCES [producto] ([id])
GO
ALTER TABLE [pago_comprobante] ADD CONSTRAINT [FK__pago_comp__id_co__2FEF161B] FOREIGN KEY ([id_comprobante]) REFERENCES [comprobante] ([id])
GO
ALTER TABLE [pago_comprobante] ADD CONSTRAINT [FK__pago_comp__id_pa__30E33A54] FOREIGN KEY ([id_pago_pc]) REFERENCES [pago] ([id])
GO
ALTER TABLE [pedido] ADD CONSTRAINT [FK__pedido__32CB82C6] FOREIGN KEY ([id_sucursal_so_p], [id_odontologo_so_p]) REFERENCES [sucursal_odontologo] ([id_sucursal_so], [id_odontologo_so])
GO
ALTER TABLE [pedido] ADD CONSTRAINT [FK__pedido__id_pacie__31D75E8D] FOREIGN KEY ([id_paciente_p]) REFERENCES [paciente] ([id])
GO
ALTER TABLE [personal] ADD CONSTRAINT [FK__personal__id_suc__33BFA6FF] FOREIGN KEY ([id_sucursal_p]) REFERENCES [sucursal] ([id])
GO
ALTER TABLE [precio_expcional] ADD CONSTRAINT [FK__precio_ex__codig__34B3CB38] FOREIGN KEY ([codigo_item_pe]) REFERENCES [item] ([codigo])
GO
ALTER TABLE [precio_expcional] ADD CONSTRAINT [FK__precio_ex__id_su__35A7EF71] FOREIGN KEY ([id_sucursal_pe]) REFERENCES [sucursal] ([id])
GO
ALTER TABLE [producto_grupo] ADD CONSTRAINT [FK__producto___id_gr__369C13AA] FOREIGN KEY ([id_grupo_pg]) REFERENCES [grupo] ([id])
GO
ALTER TABLE [producto_grupo] ADD CONSTRAINT [FK__producto___id_pr__379037E3] FOREIGN KEY ([id_producto_pg]) REFERENCES [producto] ([id])
GO
ALTER TABLE [producto_solicitado] ADD CONSTRAINT [FK__producto___codig__39788055] FOREIGN KEY ([codigo_item_ps]) REFERENCES [item] ([codigo])
GO
ALTER TABLE [producto_solicitado] ADD CONSTRAINT [FK__producto___id_ca__38845C1C] FOREIGN KEY ([id_cancelacion_ps]) REFERENCES [cancelacion] ([id])
GO
ALTER TABLE [producto_solicitado] ADD CONSTRAINT [FK__producto___numer__3A6CA48E] FOREIGN KEY ([numero_pedido_ps]) REFERENCES [pedido] ([numero])
GO
ALTER TABLE [prueba_realizada] ADD CONSTRAINT [FK__prueba_re__id_pr__3B60C8C7] FOREIGN KEY ([id_producto_sps]) REFERENCES [producto] ([id])
GO
ALTER TABLE [prueba_realizada] ADD CONSTRAINT [FK__prueba_re__id_pr__3C54ED00] FOREIGN KEY ([id_producto_solicitado_sps]) REFERENCES [producto_solicitado] ([id])
GO
ALTER TABLE [subproducto] ADD CONSTRAINT [FK__subproduc__id_pr__3D491139] FOREIGN KEY ([id_producto_padre_s]) REFERENCES [producto] ([id])
GO
ALTER TABLE [subproducto] ADD CONSTRAINT [FK__subproduc__id_pr__3E3D3572] FOREIGN KEY ([id_producto_hijo_s]) REFERENCES [producto] ([id])
GO
ALTER TABLE [sucursal] ADD CONSTRAINT [FK__sucursal__id_ara__4119A21D] FOREIGN KEY ([id_arancel_s]) REFERENCES [arancel] ([id])
GO
ALTER TABLE [sucursal] ADD CONSTRAINT [FK__sucursal__id_cli__3F3159AB] FOREIGN KEY ([id_cliente_s]) REFERENCES [cliente] ([id])
GO
ALTER TABLE [sucursal] ADD CONSTRAINT [FK__sucursal__id_dat__40257DE4] FOREIGN KEY ([id_datos_facturacion_s]) REFERENCES [datos_facturacion] ([id])
GO
ALTER TABLE [sucursal_odontologo] ADD CONSTRAINT [FK__sucursal___id_od__420DC656] FOREIGN KEY ([id_odontologo_so]) REFERENCES [odontologo] ([id])
GO
ALTER TABLE [sucursal_odontologo] ADD CONSTRAINT [FK__sucursal___id_su__4301EA8F] FOREIGN KEY ([id_sucursal_so]) REFERENCES [sucursal] ([id])
GO
ALTER TABLE [ubicacion] ADD CONSTRAINT [FK__ubicacion__id_su__43F60EC8] FOREIGN KEY ([id_sucursal_u]) REFERENCES [sucursal] ([id])
GO

