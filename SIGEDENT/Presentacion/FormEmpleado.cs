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
    public partial class FormEmpleado : Form
    {
        private static FormEmpleado iform_empleado;
        private Entidades.Empleado empleado;
        //private Entidades.Modelo modelo; //descomentar y declarar la entidad con la cual se trabajará

        public FormEmpleado()
        {
            InitializeComponent();
        }

        private void FormEmpleado_Load(object sender, EventArgs e)
        {
            dgv_vista.AutoGenerateColumns = false;
            //Elegir proporcion para cada columna con respecto al tamaño de la pantalla //descomentar la siguiente linea
            dgv_vista.Columns[0].Width = Convert.ToInt32((Screen.PrimaryScreen.Bounds.Width / 15));
            dgv_vista.Columns[1].Width = Convert.ToInt32((Screen.PrimaryScreen.Bounds.Width / 9));
            dgv_vista.Columns[2].Width = Convert.ToInt32((Screen.PrimaryScreen.Bounds.Width / 9));
            dgv_vista.Columns[3].Width = Convert.ToInt32((Screen.PrimaryScreen.Bounds.Width / 18));
            dgv_vista.Columns[4].Width = Convert.ToInt32((Screen.PrimaryScreen.Bounds.Width / 10));            
            LLenar_DataGridView("");
            Activar_Panel(false); //Inicialmente activamos el panel busqueda            
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
            //modificar el metodo segun la tabla que queramos mostrar en el dgv_vista
            try { dgv_vista.DataSource = Datos.DEmpleado.Empleado_Seleccionar_Filtro("apellidos", busqueda); }
            catch (Exception ex) { MessageBox.Show(ex.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning); }
        }

        private void LLenar_Combo_Areas()
        {
            cbb_area.ValueMember = "id";
            cbb_area.DisplayMember = "nombre";
            try { cbb_area.DataSource = Datos.DArea.Area_Seleccionar_Tabla(); }
            catch (Exception ex) { MessageBox.Show(ex.Message); }
        }

        private void Detallar_Elegido()
        {
            //llenar las cajas de texto del panel pan_registro con las propiedades de la clase instanciada actual
            txb_codigo.Text = empleado.codigo;
            txb_apellidos.Text=empleado.apellidos;
            txb_nombres.Text=empleado.nombres;
            txb_rut.Text=empleado.rut;
            cbb_area.Text = empleado.nombre_area;
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
            //txb_nombre.Clear();
            Activar_Panel(true);
            LLenar_Combo_Areas();
        }

        private void btn_editar_Click(object sender, EventArgs e)
        {
            if (dgv_vista.CurrentRow != null)
            {
                //instanciamos el objeto entidad con la fila elegida en el dgv_vista
                empleado = (Entidades.Empleado)dgv_vista.CurrentRow.DataBoundItem;
                LLenar_Combo_Areas();
                Detallar_Elegido();
                Activar_Panel(true);
            }
            else
                MessageBox.Show("Debe elegir una fila en la relacion de areas");
        }

        private void btn_eliminar_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("Desea Eliminar el Registro de la Base de Datos", "Confirmar Eliminacion", MessageBoxButtons.YesNo);
            if (dr == DialogResult.Yes)
            {
                if (dgv_vista.CurrentRow != null)
                {
                    try { Datos.DEmpleado.Empleado_Eliminar(dgv_vista.CurrentRow.Cells["Codigo"].Value.ToString()); }
                    catch (Exception ex) { MessageBox.Show(ex.Message); }
                    LLenar_DataGridView("");
                }
                else
                    MessageBox.Show("Debe elegir una fila en la relacion de areas");
            }
        }

        private void btn_aceptar_Click(object sender, EventArgs e)
        {
            /* si no usamos la capa Negocio, entonces debemos validar antes de este evento */
            if (txb_codigo.Text != "" && txb_codigo.Text.Length > 2 && txb_apellidos.Text!="")
            { //codigo y apellidos no vacios y codigo mayor de 2 cifras
                if (empleado == null) { // el area a grabar no fue elgida del dgv, entonces instanciamos el objeto area indicando id=0 para que el sp_area_grabar realice un registro nuevo
                    empleado = new Entidades.Empleado();    
                }
                empleado.codigo = txb_codigo.Text;
                empleado.apellidos = txb_apellidos.Text;
                empleado.nombres = txb_nombres.Text;
                empleado.rut = txb_rut.Text;
                empleado.area = (Entidades.Area)cbb_area.SelectedItem;
                //empleado.area.id = Convert.ToInt32(cbb_area.SelectedIndex);
                //empleado.area.nombre = cbb_area.SelectedItem.ToString();
                try { Datos.DEmpleado.Empleado_Grabar(empleado); }
                catch (Exception ex) { MessageBox.Show(ex.Message); }
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
    }
}
