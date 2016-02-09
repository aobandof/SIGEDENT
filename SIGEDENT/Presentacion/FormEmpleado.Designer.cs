namespace Presentacion
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
            this.txb_buscar = new System.Windows.Forms.TextBox();
            this.pan_vista = new System.Windows.Forms.Panel();
            this.btn_eliminar = new System.Windows.Forms.Button();
            this.btn_editar = new System.Windows.Forms.Button();
            this.btn_nuevo = new System.Windows.Forms.Button();
            this.dgv_vista = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.pan_registro = new System.Windows.Forms.Panel();
            this.cbb_area = new System.Windows.Forms.ComboBox();
            this.txb_rut = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.txb_nombres = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txb_apellidos = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txb_codigo = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btn_cancelar = new System.Windows.Forms.Button();
            this.btn_aceptar = new System.Windows.Forms.Button();
            this.pan_vista.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_vista)).BeginInit();
            this.pan_registro.SuspendLayout();
            this.SuspendLayout();
            // 
            // txb_buscar
            // 
            this.txb_buscar.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txb_buscar.Location = new System.Drawing.Point(135, 26);
            this.txb_buscar.Name = "txb_buscar";
            this.txb_buscar.Size = new System.Drawing.Size(333, 22);
            this.txb_buscar.TabIndex = 1;
            this.txb_buscar.TextChanged += new System.EventHandler(this.txb_buscar_TextChanged);
            this.txb_buscar.KeyUp += new System.Windows.Forms.KeyEventHandler(this.txb_buscar_KeyUp);
            // 
            // pan_vista
            // 
            this.pan_vista.Controls.Add(this.btn_eliminar);
            this.pan_vista.Controls.Add(this.btn_editar);
            this.pan_vista.Controls.Add(this.btn_nuevo);
            this.pan_vista.Controls.Add(this.dgv_vista);
            this.pan_vista.Controls.Add(this.txb_buscar);
            this.pan_vista.Controls.Add(this.label1);
            this.pan_vista.Location = new System.Drawing.Point(0, 3);
            this.pan_vista.Name = "pan_vista";
            this.pan_vista.Size = new System.Drawing.Size(489, 379);
            this.pan_vista.TabIndex = 2;
            // 
            // btn_eliminar
            // 
            this.btn_eliminar.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_eliminar.Location = new System.Drawing.Point(321, 331);
            this.btn_eliminar.Name = "btn_eliminar";
            this.btn_eliminar.Size = new System.Drawing.Size(116, 30);
            this.btn_eliminar.TabIndex = 5;
            this.btn_eliminar.Text = "Eliminar";
            this.btn_eliminar.UseVisualStyleBackColor = true;
            this.btn_eliminar.Click += new System.EventHandler(this.btn_eliminar_Click);
            // 
            // btn_editar
            // 
            this.btn_editar.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_editar.Location = new System.Drawing.Point(184, 331);
            this.btn_editar.Name = "btn_editar";
            this.btn_editar.Size = new System.Drawing.Size(116, 30);
            this.btn_editar.TabIndex = 4;
            this.btn_editar.Text = "&Editar";
            this.btn_editar.UseVisualStyleBackColor = true;
            this.btn_editar.Click += new System.EventHandler(this.btn_editar_Click);
            // 
            // btn_nuevo
            // 
            this.btn_nuevo.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_nuevo.Location = new System.Drawing.Point(43, 331);
            this.btn_nuevo.Name = "btn_nuevo";
            this.btn_nuevo.Size = new System.Drawing.Size(116, 30);
            this.btn_nuevo.TabIndex = 3;
            this.btn_nuevo.Text = "&Nuevo";
            this.btn_nuevo.UseVisualStyleBackColor = true;
            this.btn_nuevo.Click += new System.EventHandler(this.btn_nuevo_Click);
            // 
            // dgv_vista
            // 
            this.dgv_vista.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_vista.Location = new System.Drawing.Point(13, 67);
            this.dgv_vista.Name = "dgv_vista";
            this.dgv_vista.Size = new System.Drawing.Size(455, 241);
            this.dgv_vista.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(10, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(61, 16);
            this.label1.TabIndex = 0;
            this.label1.Text = "Buscar *:";
            // 
            // pan_registro
            // 
            this.pan_registro.Controls.Add(this.cbb_area);
            this.pan_registro.Controls.Add(this.txb_rut);
            this.pan_registro.Controls.Add(this.label6);
            this.pan_registro.Controls.Add(this.label5);
            this.pan_registro.Controls.Add(this.txb_nombres);
            this.pan_registro.Controls.Add(this.label4);
            this.pan_registro.Controls.Add(this.txb_apellidos);
            this.pan_registro.Controls.Add(this.label3);
            this.pan_registro.Controls.Add(this.txb_codigo);
            this.pan_registro.Controls.Add(this.label2);
            this.pan_registro.Controls.Add(this.btn_cancelar);
            this.pan_registro.Controls.Add(this.btn_aceptar);
            this.pan_registro.Location = new System.Drawing.Point(495, 3);
            this.pan_registro.Name = "pan_registro";
            this.pan_registro.Size = new System.Drawing.Size(250, 379);
            this.pan_registro.TabIndex = 3;
            // 
            // cbb_area
            // 
            this.cbb_area.FormattingEnabled = true;
            this.cbb_area.Location = new System.Drawing.Point(21, 257);
            this.cbb_area.Name = "cbb_area";
            this.cbb_area.Size = new System.Drawing.Size(212, 21);
            this.cbb_area.TabIndex = 10;
            // 
            // txb_rut
            // 
            this.txb_rut.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txb_rut.Location = new System.Drawing.Point(21, 200);
            this.txb_rut.Name = "txb_rut";
            this.txb_rut.Size = new System.Drawing.Size(212, 22);
            this.txb_rut.TabIndex = 9;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(18, 237);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(40, 16);
            this.label6.TabIndex = 4;
            this.label6.Text = "Area:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(18, 181);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(31, 16);
            this.label5.TabIndex = 4;
            this.label5.Text = "Rut:";
            // 
            // txb_nombres
            // 
            this.txb_nombres.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txb_nombres.Location = new System.Drawing.Point(21, 147);
            this.txb_nombres.Name = "txb_nombres";
            this.txb_nombres.Size = new System.Drawing.Size(212, 22);
            this.txb_nombres.TabIndex = 7;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(18, 128);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(67, 16);
            this.label4.TabIndex = 4;
            this.label4.Text = "Nombres:";
            // 
            // txb_apellidos
            // 
            this.txb_apellidos.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txb_apellidos.Location = new System.Drawing.Point(21, 94);
            this.txb_apellidos.Name = "txb_apellidos";
            this.txb_apellidos.Size = new System.Drawing.Size(212, 22);
            this.txb_apellidos.TabIndex = 7;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(18, 75);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(68, 16);
            this.label3.TabIndex = 4;
            this.label3.Text = "Apellidos:";
            // 
            // txb_codigo
            // 
            this.txb_codigo.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txb_codigo.Location = new System.Drawing.Point(21, 45);
            this.txb_codigo.Name = "txb_codigo";
            this.txb_codigo.Size = new System.Drawing.Size(212, 22);
            this.txb_codigo.TabIndex = 6;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(18, 26);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(55, 16);
            this.label2.TabIndex = 4;
            this.label2.Text = "Codigo:";
            // 
            // btn_cancelar
            // 
            this.btn_cancelar.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_cancelar.Location = new System.Drawing.Point(134, 331);
            this.btn_cancelar.Name = "btn_cancelar";
            this.btn_cancelar.Size = new System.Drawing.Size(99, 30);
            this.btn_cancelar.TabIndex = 12;
            this.btn_cancelar.Text = "&Cancelar";
            this.btn_cancelar.UseVisualStyleBackColor = true;
            this.btn_cancelar.Click += new System.EventHandler(this.btn_cancelar_Click);
            // 
            // btn_aceptar
            // 
            this.btn_aceptar.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_aceptar.Location = new System.Drawing.Point(21, 331);
            this.btn_aceptar.Name = "btn_aceptar";
            this.btn_aceptar.Size = new System.Drawing.Size(99, 30);
            this.btn_aceptar.TabIndex = 11;
            this.btn_aceptar.Text = "&Aceptar";
            this.btn_aceptar.UseVisualStyleBackColor = true;
            this.btn_aceptar.Click += new System.EventHandler(this.btn_aceptar_Click);
            // 
            // FormEmpleado
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(747, 385);
            this.Controls.Add(this.pan_vista);
            this.Controls.Add(this.pan_registro);
            this.Name = "FormEmpleado";
            this.Text = "FControl de Empleados";
            this.Load += new System.EventHandler(this.FormEmpleado_Load);
            this.pan_vista.ResumeLayout(false);
            this.pan_vista.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_vista)).EndInit();
            this.pan_registro.ResumeLayout(false);
            this.pan_registro.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox txb_buscar;
        private System.Windows.Forms.Panel pan_vista;
        private System.Windows.Forms.Button btn_eliminar;
        private System.Windows.Forms.Button btn_editar;
        private System.Windows.Forms.Button btn_nuevo;
        private System.Windows.Forms.DataGridView dgv_vista;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel pan_registro;
        private System.Windows.Forms.TextBox txb_codigo;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btn_cancelar;
        private System.Windows.Forms.Button btn_aceptar;
        private System.Windows.Forms.ComboBox cbb_area;
        private System.Windows.Forms.TextBox txb_rut;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txb_nombres;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txb_apellidos;
        private System.Windows.Forms.Label label3;
    }
}