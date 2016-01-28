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
            catch
            {

            }
        }

        private void FormArea_Load(object sender, EventArgs e)
        {
            dgv_vista.AutoGenerateColumns = false;
            //dgv_vista.AutoResizeColumn();
            dgv_vista.AutoResizeColumns();
        }
    }
}
