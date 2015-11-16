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
    public partial class FormLogin : Form
    {
        public FormLogin()
        {
            InitializeComponent();
        }

        private void FormLogin_Load(object sender, EventArgs e)
        {
            txb_usuario.Focus();
        }

        private void btn_ingresar_Click(object sender, EventArgs e)
        {
            // aca iran reglas de negocio
        }

        private void txb_usuario_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Enter)) // otra opcion: if ( e.keychar==13), pero recordemos que hay 2 enter en el teclado
            {
                txb_password.Focus();
            }

            //if (Char.IsLetter(e.KeyChar))
            //{
            //    e.Handled = false;
            //}
            //else if (Char.IsControl(e.KeyChar))
            //{
            //    e.Handled = false;
            //}
            //else if (Char.IsSeparator(e.KeyChar))
            //{
            //    e.Handled = false;
            //}
            //else
            //{
            //    e.Handled = true;
            //}
        }

        private void txb_password_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Enter)) // otra opcion: if ( e.keychar==13), pero recordemos que hay 2 enter en el teclado
            {
                //llamar a metodo iniciar sesion
            }
        }
    }
}
