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
        //ArrayList resp_bd;
        Entidades.Usuario logueado = new Entidades.Usuario();

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
            //logueado=LogicaNegocio.LNUsuario.LNUsuario_Loguear(txb_usuario.Text, txb_password.Text);
            //MessageBox.Show("Bienvenidos " + logueado.nombres + " " + logueado.apellidos);
            //this.Hide();
            try
            {
                logueado = LogicaNegocio.LNUsuario.LNUsuario_Loguear(txb_usuario.Text, txb_password.Text);
                MessageBox.Show("Bienvenido " + logueado.nombres + " " + logueado.apellidos);
                this.Hide();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            
               
        }

        /********* Si dentro del texbox usuario pulsamos tecla enter, entonces el foco se va para el texbox password ********/
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
        /********* Si dentro del texbox contraseña pulsamos tecla enter, iniciamos sesion ********/
        private void txb_password_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Enter)) // otra opcion: if ( e.keychar==13), pero recordemos que hay 2 enter en el teclado
            {
                try
                {
                    logueado = LogicaNegocio.LNUsuario.LNUsuario_Loguear(txb_usuario.Text, txb_password.Text);
                    MessageBox.Show("Bienvenido " + logueado.nombres + " " + logueado.apellidos);
                    this.Hide();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);

                }
                
             }
        }
    }
}
