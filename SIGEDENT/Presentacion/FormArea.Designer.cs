﻿namespace Presentacion
{
    partial class FormEmpleado
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pan_registro = new System.Windows.Forms.Panel();
            this.btn_cancelar = new System.Windows.Forms.Button();
            this.btn_aceptar = new System.Windows.Forms.Button();
            this.txb_codigo = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.pan_vista = new System.Windows.Forms.Panel();
            this.btn_eliminar = new System.Windows.Forms.Button();
            this.btn_editar = new System.Windows.Forms.Button();
            this.btn_nuevo = new System.Windows.Forms.Button();
            this.dgv_vista = new System.Windows.Forms.DataGridView();
            this.codigo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.apellidos = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nombres = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rut = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nombre_area = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.txb_buscar = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.txb_apellidos = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txb_nombres = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.txb_rut = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.cbb_area = new System.Windows.Forms.ComboBox();
            this.pan_registro.SuspendLayout();
            this.pan_vista.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_vista)).BeginInit();
            this.SuspendLayout();
            // 
            // pan_registro
            // 
            this.pan_registro.Controls.Add(this.cbb_area);
            this.pan_registro.Controls.Add(this.btn_cancelar);
            this.pan_registro.Controls.Add(this.btn_aceptar);
            this.pan_registro.Controls.Add(this.label6);
            this.pan_registro.Controls.Add(this.txb_rut);
            this.pan_registro.Controls.Add(this.label5);
            this.pan_registro.Controls.Add(this.txb_nombres);
            this.pan_registro.Controls.Add(this.label4);
            this.pan_registro.Controls.Add(this.txb_apellidos);
            this.pan_registro.Controls.Add(this.label3);
            this.pan_registro.Controls.Add(this.txb_codigo);
            this.pan_registro.Controls.Add(this.label2);
            this.pan_registro.Location = new System.Drawing.Point(570, 3);
            this.pan_registro.Name = "pan_registro";
            this.pan_registro.Size = new System.Drawing.Size(235, 441);
            this.pan_registro.TabIndex = 0;
            // 
            // btn_cancelar
            // 
            this.btn_cancelar.Location = new System.Drawing.Point(124, 390);
            this.btn_cancelar.Name = "btn_cancelar";
            this.btn_cancelar.Size = new System.Drawing.Size(96, 23);
            this.btn_cancelar.TabIndex = 9;
            this.btn_cancelar.Text = "CANCELAR";
            this.btn_cancelar.UseVisualStyleBackColor = true;
            this.btn_cancelar.Click += new System.EventHandler(this.btn_cancelar_Click);
            // 
            // btn_aceptar
            // 
            this.btn_aceptar.Location = new System.Drawing.Point(22, 390);
            this.btn_aceptar.Name = "btn_aceptar";
            this.btn_aceptar.Size = new System.Drawing.Size(96, 23);
            this.btn_aceptar.TabIndex = 8;
            this.btn_aceptar.Text = "ACEPTAR";
            this.btn_aceptar.UseVisualStyleBackColor = true;
            this.btn_aceptar.Click += new System.EventHandler(this.btn_aceptar_Click);
            // 
            // txb_codigo
            // 
            this.txb_codigo.Location = new System.Drawing.Point(15, 31);
            this.txb_codigo.Name = "txb_codigo";
            this.txb_codigo.Size = new System.Drawing.Size(205, 20);
            this.txb_codigo.TabIndex = 7;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(14, 15);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(43, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Codigo:";
            // 
            // pan_vista
            // 
            this.pan_vista.Controls.Add(this.btn_eliminar);
            this.pan_vista.Controls.Add(this.btn_editar);
            this.pan_vista.Controls.Add(this.btn_nuevo);
            this.pan_vista.Controls.Add(this.dgv_vista);
            this.pan_vista.Controls.Add(this.txb_buscar);
            this.pan_vista.Controls.Add(this.label1);
            this.pan_vista.Location = new System.Drawing.Point(3, 3);
            this.pan_vista.Name = "pan_vista";
            this.pan_vista.Size = new System.Drawing.Size(561, 441);
            this.pan_vista.TabIndex = 0;
            // 
            // btn_eliminar
            // 
            this.btn_eliminar.Location = new System.Drawing.Point(389, 388);
            this.btn_eliminar.Name = "btn_eliminar";
            this.btn_eliminar.Size = new System.Drawing.Size(154, 25);
            this.btn_eliminar.TabIndex = 6;
            this.btn_eliminar.Text = "ELIMINAR";
            this.btn_eliminar.UseVisualStyleBackColor = true;
            this.btn_eliminar.Click += new System.EventHandler(this.btn_eliminar_Click);
            // 
            // btn_editar
            // 
            this.btn_editar.Location = new System.Drawing.Point(199, 388);
            this.btn_editar.Name = "btn_editar";
            this.btn_editar.Size = new System.Drawing.Size(154, 25);
            this.btn_editar.TabIndex = 5;
            this.btn_editar.Text = "EDITAR";
            this.btn_editar.UseVisualStyleBackColor = true;
            this.btn_editar.Click += new System.EventHandler(this.btn_editar_Click);
            // 
            // btn_nuevo
            // 
            this.btn_nuevo.Location = new System.Drawing.Point(21, 388);
            this.btn_nuevo.Name = "btn_nuevo";
            this.btn_nuevo.Size = new System.Drawing.Size(154, 25);
            this.btn_nuevo.TabIndex = 4;
            this.btn_nuevo.Text = "NUEVO";
            this.btn_nuevo.UseVisualStyleBackColor = true;
            this.btn_nuevo.Click += new System.EventHandler(this.btn_nuevo_Click);
            // 
            // dgv_vista
            // 
            this.dgv_vista.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_vista.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.codigo,
            this.apellidos,
            this.nombres,
            this.rut,
            this.nombre_area});
            this.dgv_vista.Location = new System.Drawing.Point(21, 73);
            this.dgv_vista.Name = "dgv_vista";
            this.dgv_vista.Size = new System.Drawing.Size(522, 287);
            this.dgv_vista.TabIndex = 2;
            this.dgv_vista.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_vista_CellContentClick);
            // 
            // codigo
            // 
            this.codigo.DataPropertyName = "codigo";
            this.codigo.HeaderText = "Codigo";
            this.codigo.Name = "codigo";
            // 
            // apellidos
            // 
            this.apellidos.DataPropertyName = "apellidos";
            this.apellidos.HeaderText = "Apellidos";
            this.apellidos.Name = "apellidos";
            // 
            // nombres
            // 
            this.nombres.DataPropertyName = "nombres";
            this.nombres.HeaderText = "Nombres";
            this.nombres.Name = "nombres";
            // 
            // rut
            // 
            this.rut.DataPropertyName = "rut";
            this.rut.HeaderText = "Rut";
            this.rut.Name = "rut";
            // 
            // nombre_area
            // 
            this.nombre_area.DataPropertyName = "nombre_area";
            this.nombre_area.HeaderText = "Area";
            this.nombre_area.Name = "nombre_area";
            // 
            // txb_buscar
            // 
            this.txb_buscar.Location = new System.Drawing.Point(116, 21);
            this.txb_buscar.Name = "txb_buscar";
            this.txb_buscar.Size = new System.Drawing.Size(374, 20);
            this.txb_buscar.TabIndex = 1;
            this.txb_buscar.TextChanged += new System.EventHandler(this.txb_buscar_TextChanged);
            this.txb_buscar.KeyUp += new System.Windows.Forms.KeyEventHandler(this.txb_buscar_KeyUp);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(41, 28);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(57, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Empleado:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(14, 66);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(52, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Apellidos:";
            // 
            // txb_apellidos
            // 
            this.txb_apellidos.Location = new System.Drawing.Point(15, 82);
            this.txb_apellidos.Name = "txb_apellidos";
            this.txb_apellidos.Size = new System.Drawing.Size(205, 20);
            this.txb_apellidos.TabIndex = 7;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(14, 115);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(52, 13);
            this.label4.TabIndex = 4;
            this.label4.Text = "Nombres:";
            // 
            // txb_nombres
            // 
            this.txb_nombres.Location = new System.Drawing.Point(15, 131);
            this.txb_nombres.Name = "txb_nombres";
            this.txb_nombres.Size = new System.Drawing.Size(205, 20);
            this.txb_nombres.TabIndex = 7;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(14, 166);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(27, 13);
            this.label5.TabIndex = 4;
            this.label5.Text = "Rut:";
            // 
            // txb_rut
            // 
            this.txb_rut.Location = new System.Drawing.Point(15, 182);
            this.txb_rut.Name = "txb_rut";
            this.txb_rut.Size = new System.Drawing.Size(205, 20);
            this.txb_rut.TabIndex = 7;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(19, 221);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(32, 13);
            this.label6.TabIndex = 4;
            this.label6.Text = "Area:";
            // 
            // cbb_area
            // 
            this.cbb_area.FormattingEnabled = true;
            this.cbb_area.Location = new System.Drawing.Point(17, 237);
            this.cbb_area.Name = "cbb_area";
            this.cbb_area.Size = new System.Drawing.Size(205, 21);
            this.cbb_area.TabIndex = 10;
            // 
            // FormEmpleado
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(808, 442);
            this.Controls.Add(this.pan_vista);
            this.Controls.Add(this.pan_registro);
            this.Name = "FormEmpleado";
            this.Text = "Configuracion de Empleados";
            this.Load += new System.EventHandler(this.FormArea_Load);
            this.pan_registro.ResumeLayout(false);
            this.pan_registro.PerformLayout();
            this.pan_vista.ResumeLayout(false);
            this.pan_vista.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_vista)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pan_registro;
        private System.Windows.Forms.Panel pan_vista;
        private System.Windows.Forms.DataGridView dgv_vista;
        private System.Windows.Forms.TextBox txb_buscar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btn_cancelar;
        private System.Windows.Forms.Button btn_aceptar;
        private System.Windows.Forms.TextBox txb_codigo;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btn_eliminar;
        private System.Windows.Forms.Button btn_editar;
        private System.Windows.Forms.Button btn_nuevo;
        private System.Windows.Forms.DataGridViewTextBoxColumn codigo;
        private System.Windows.Forms.DataGridViewTextBoxColumn apellidos;
        private System.Windows.Forms.DataGridViewTextBoxColumn nombres;
        private System.Windows.Forms.DataGridViewTextBoxColumn rut;
        private System.Windows.Forms.DataGridViewTextBoxColumn nombre_area;
        private System.Windows.Forms.ComboBox cbb_area;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txb_rut;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txb_nombres;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txb_apellidos;
        private System.Windows.Forms.Label label3;
    }
}