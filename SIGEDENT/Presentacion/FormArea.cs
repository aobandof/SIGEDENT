﻿using System;
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
    public partial class FormEmpleado : Form
    {
        private static FormEmpleado iform_empleado = null;
        private Entidades.Empleado empleado;
        
        public FormEmpleado()
        {
            InitializeComponent();
        }

        public static FormEmpleado FormEmpleado_Instanciar()
        {
            if (iform_empleado == null || iform_empleado.IsDisposed == true)
            {
                iform_empleado = new FormEmpleado();
            }
            iform_empleado.BringToFront();
            return iform_empleado;
        }


        private void Activar_Panel(bool estado)
        {
            pan_registro.Enabled = estado;
            pan_vista.Enabled = !estado;
            if (estado)
                txb_codigo.Focus();
            else
                txb_buscar.Focus();
        }

        private void LLenar_DataGridView(string busqueda)
        {
            try
            {
                dgv_vista.DataSource = Datos.DEmpleado.Empleado_Seleccionar_Filtro("apellidos",busqueda);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void FormEmpleado_Load(object sender, EventArgs e)
        {
            dgv_vista.AutoGenerateColumns = false;
            dgv_vista.Columns[0].Width = (Screen.PrimaryScreen.Bounds.Width) / 35;
            dgv_vista.Columns[1].Width =Convert.ToInt32((Screen.PrimaryScreen.Bounds.Width/ 4.8));
            LLenar_DataGridView("");
            Activar_Panel(false); //Inicialmente activamos el panel busqueda
        }

        private void Detallar_Elegido()
        {
            txb_codigo.Text = empleado.codigo;
            txb_apellidos.Text = empleado.apellidos;
            txb_nombres.Text = empleado.nombres;
            txb_rut.Text = empleado.rut;
            cbb_area.Text=empleado.area.nombre;
            LLenar_Areas(empleado.area.);
        }

        private void txb_buscar_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                LLenar_DataGridView(txb_buscar.Text);
        }

        private void txb_buscar_TextChanged(object sender, EventArgs e)
        {
            /*Implementar el filtro en el Datagrdview pero sin consultar la base de datos,
             * si no trabajar con el datatable obtenido al abrir el formulario o despues
             * de insertar o actuallizar */
        }

        private void btn_nuevo_Click(object sender, EventArgs e)
        {
            empleado = null;
            txb_codigo.Clear();
            Activar_Panel(true);
        }

        private void btn_editar_Click(object sender, EventArgs e)
        {
            if (dgv_vista.CurrentRow != null)
            {
                empleado = (Entidades.Empleado)dgv_vista.CurrentRow.DataBoundItem;
                Detallar_Elegido();
            }
            else
                MessageBox.Show("Debe elegir una fila en la relacion de empleados");           
        }

        private void btn_eliminar_Click(object sender, EventArgs e) {
            if (dgv_vista.CurrentRow != null) {
                try {  Datos.DEmpleado.Empleado_Eliminar(Convert.ToInt16(dgv_vista.CurrentRow.Cells["Id"].Value));  }
                catch (Exception ex) { MessageBox.Show(ex.Message); }                
                LLenar_DataGridView("");
            }
            else
                MessageBox.Show("Debe elegir una fila en la relacion de empleados"); 
        }

        private void btn_aceptar_Click(object sender, EventArgs e)
        {
            /* si no usamos la capa Negocio, entonces debemos validar antes de este evento */                        
            if (txb_codigo.Text != "" && txb_codigo.Text.Length > 2)
            { //nombre no vacio y mayo de 2 cifras
                if(empleado==null) { // el empleado a grabar no fue elgida del dgv, entonces instanciamos el objeto empleado indicando id=0 para que el sp_empleado_grabar realice un registro nuevo
                    empleado = new Entidades.Empleado();
                    empleado.id = Convert.ToInt16(0);
                    empleado.nombre=txb_codigo.Text;
                }
                try { Datos.DEmpleado.Empleado_Grabar(empleado);}
                catch(Exception ex) { MessageBox.Show(ex.Message);}
                Activar_Panel(false);
                LLenar_DataGridView("");
            }
            else
                MessageBox.Show("Verifique los datos por favor");
        }

        private void btn_cancelar_Click(object sender, EventArgs e)
        {
            Activar_Panel(false);
        }

        private void dgv_vista_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
    