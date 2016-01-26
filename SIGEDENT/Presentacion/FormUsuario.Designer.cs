namespace Presentacion
{
    partial class FormUsuario
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
            this.pan_catalogo = new System.Windows.Forms.Panel();
            this.txb_buscar = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.pan_dato = new System.Windows.Forms.Panel();
            this.label2 = new System.Windows.Forms.Label();
            this.txb_usuario = new System.Windows.Forms.TextBox();
            this.pan_catalogo.SuspendLayout();
            this.pan_dato.SuspendLayout();
            this.SuspendLayout();
            // 
            // pan_catalogo
            // 
            this.pan_catalogo.Controls.Add(this.txb_buscar);
            this.pan_catalogo.Controls.Add(this.label1);
            this.pan_catalogo.Location = new System.Drawing.Point(12, 13);
            this.pan_catalogo.Name = "pan_catalogo";
            this.pan_catalogo.Size = new System.Drawing.Size(520, 412);
            this.pan_catalogo.TabIndex = 0;
            // 
            // txb_buscar
            // 
            this.txb_buscar.Location = new System.Drawing.Point(113, 19);
            this.txb_buscar.Name = "txb_buscar";
            this.txb_buscar.Size = new System.Drawing.Size(248, 20);
            this.txb_buscar.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(25, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(82, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Buscar Usuario:";
            
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(27, 16);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(46, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Usuario:";
            // 
            // txb_usuario
            // 
            this.txb_usuario.Location = new System.Drawing.Point(30, 35);
            this.txb_usuario.Name = "txb_usuario";
            this.txb_usuario.Size = new System.Drawing.Size(191, 20);
            this.txb_usuario.TabIndex = 0;
            // 
            // FormUsuario
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(880, 511);
            this.ControlBox = false;
            this.Controls.Add(this.pan_dato);
            this.Controls.Add(this.pan_catalogo);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "FormUsuario";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Administracion de Usuarios del Sistema";
            this.Load += new System.EventHandler(this.FormUsuario_Load);
            this.pan_catalogo.ResumeLayout(false);
            this.pan_catalogo.PerformLayout();
            this.pan_dato.ResumeLayout(false);
            this.pan_dato.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pan_catalogo;
        private System.Windows.Forms.Panel pan_dato;
        private System.Windows.Forms.TextBox txb_buscar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txb_usuario;
    }
}