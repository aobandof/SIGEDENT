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
        public FormPrincipal()
        {
            InitializeComponent();
        }

        private void FormPrincipal_Load(object sender, EventArgs e)
        {
            form_login = new FormLogin();
            form_login.MdiParent=this;
            form_login.Show();
            //NOS CONECTAMOS A LA BASE DE DATOS AUTOMATICAMENTE


        }

        private void FormPrincipal_FormClosing(object sender, FormClosingEventArgs e)
        {
            //DEBEMOS PREGUNTAR SI REALMENTE DESEAMOS SALIR Y DESCONECTARNOS DE LA BASE DE DATOS
        }

        private void uSUARIOSToolStripMenuItem_Click(object sender, EventArgs e)
        {
            form_usuario = new FormUsuario();
            form_usuario.Show();
        }
    }
}
