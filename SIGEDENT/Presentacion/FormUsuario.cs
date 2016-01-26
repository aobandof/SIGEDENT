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
    public partial class FormUsuario : Form
    {
        private static FormUsuario iform_usuario = null;

        public FormUsuario()
        {
            InitializeComponent();
        }

        //Por patron singleton creamos y/o enviamos el formulario de unica forma
        public static FormUsuario FormUsuario_Instanciar(){
            if ((iform_usuario == null) || (iform_usuario.IsDisposed == true))
            {
                iform_usuario = new FormUsuario();
            }
            iform_usuario.BringToFront(); //traer al frende de los demas formularios
            return iform_usuario;
        }

        private void FormUsuario_Load(object sender, EventArgs e)
        {

        }
    
    }
}
