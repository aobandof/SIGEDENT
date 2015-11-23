using System;
using System.Collections.Generic;
using System.Collections;
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
        ArrayList resp_bd;
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
            resp_bd=LogicaNegocio.LNUsuario.Usuario_Loguear(txb_usuario.Text, txb_password.Text);

            if (Convert.ToInt16(resp_bd[0]) == 1)
            {
                MessageBox.Show(resp_bd[1].ToString());
                this.Hide();
            }
            else
            {
                MessageBox.Show(resp_bd[1].ToString());
            }            
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
                resp_bd = LogicaNegocio.LNUsuario.Usuario_Loguear(txb_usuario.Text, txb_password.Text);
                //MessageBox.Show(resp_bd[0].ToString());

                if (Convert.ToInt16(resp_bd[0]) == 1)
                {
                    MessageBox.Show(resp_bd[1].ToString());
                    this.Hide();
                }
                else
                {
                    MessageBox.Show(resp_bd[1].ToString());
                }  
                //MessageBox.Show(LogicaNegocio.LNUsuario.Usuario_Loguear(txb_usuario.Text, txb_password.Text));         
            }
        }
    }
}
