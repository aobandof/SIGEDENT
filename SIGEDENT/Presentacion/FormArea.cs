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
    public partial class FormArea : Form
    {
        private static FormArea iform_area = null;
        private Entidades.Area area;
        
        public FormArea()
        {
            InitializeComponent();
        }

        public static FormArea FormArea_Instanciar()
        {
            if (iform_area == null || iform_area.IsDisposed == true)
            {
                iform_area = new FormArea();
            }
            iform_area.BringToFront();
            return iform_area;
        }


        private void Activar_Panel(bool estado)
        {
            pan_registro.Enabled = estado;
            pan_vista.Enabled = !estado;
            if (estado)
                txb_nombre_area.Focus();
            else
                txb_buscar.Focus();
        }

        private void LLenar_DataGridView(string busqueda)
        {
            try
            {
                dgv_vista.DataSource = Datos.DArea.Area_Seleccionar_Filtro(busqueda);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void FormArea_Load(object sender, EventArgs e)
        {
            dgv_vista.AutoGenerateColumns = false;
            //dgv_vista.AutoResizeColumn();
            dgv_vista.AutoResizeColumns();
            LLenar_DataGridView("");
            Activar_Panel(false); //Inicialmente activamos el panel busqueda
        }

        private void Detallar_Elegido()
        {
            txb_nombre_area.Text = area.nombre;


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
            area = null;
            txb_nombre_area.Clear();
            Activar_Panel(true);
        }

        private void btn_editar_Click(object sender, EventArgs e)
        {
            if (dgv_vista.CurrentRow != null)
            {
                area = (Entidades.Area)dgv_vista.CurrentRow.DataBoundItem;
                Detallar_Elegido();
            }
            else
                MessageBox.Show("Debe elegir una fila en la relacion de areas");           
        }

        private void btn_eliminar_Click(object sender, EventArgs e) {
            if (dgv_vista.CurrentRow != null) {
                try {  Datos.DArea.Area_Eliminar(Convert.ToInt16(dgv_vista.CurrentRow.Cells["Id"].Value));  }
                catch (Exception ex) { MessageBox.Show(ex.Message); }                
                LLenar_DataGridView("");
            }
            else
                MessageBox.Show("Debe elegir una fila en la relacion de areas"); 
        }

        private void btn_aceptar_Click(object sender, EventArgs e)
        {
            /* si no usamos la capa Negocio, entonces debemos validar antes de este evento */                        
            if (txb_nombre_area.Text != "" && txb_nombre_area.Text.Length > 2)
            { //nombre no vacio y mayo de 2 cifras
                if(area==null) {
                    area = new Entidades.Area();
                    area.id = Convert.ToInt16(0);
                    area.nombre=txb_nombre_area.Text;
                }
                try { Datos.DArea.Area_Grabar(area);}
                catch(Exception ex) { MessageBox.Show(ex.Message);}
                Activar_Panel(false);
                LLenar_DataGridView("");
            }
            else
                MessageBox.Show("Verifique los datos por favor");
        }
    }
}
    