using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Presentacion
{
    public partial class FormPrincipal : Form
    {
        private FormLogin form_login;
        private FormUsuario form_usuario;
        private FormArea form_area;
        private FormModeloControl1 form_modelo_control1;
        private FormEmpleado form_empleado;

        public FormPrincipal()
        {
            InitializeComponent();
        }

        private void FormPrincipal_Load(object sender, EventArgs e)
        {
            form_login = new FormLogin();            
            form_login.MdiParent=this;
            form_login.Show();
            //MessageBox.Show(Environment.MachineName);       
        }

        private void FormPrincipal_FormClosing(object sender, FormClosingEventArgs e)
        {
            //DEBEMOS PREGUNTAR SI REALMENTE DESEAMOS SALIR Y DESCONECTARNOS DE LA BASE DE DATOS
        }

        private void uSUARIOSToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //form_usuario = new FormUsuario();
            form_usuario = FormUsuario.FormUsuario_Instanciar();
            // ver si despues lo contenemos en el formulario principal
            form_usuario.Show();
        }

        private void controDeAreasYDptosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            form_area = FormArea.FormArea_Instanciar();
            //form_area.MdiParent = this;
            form_area.Show();
        }

        private void controlDeEmpleadosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            form_empleado = FormEmpleado.FormEmpleado_Instanciar();
            form_empleado.Show();
        }

        private void pruebaDeFormControl1ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            form_modelo_control1 = FormModeloControl1.FormModeloControl1_Instanciar();
            form_modelo_control1.Show();
        }
    }
}
