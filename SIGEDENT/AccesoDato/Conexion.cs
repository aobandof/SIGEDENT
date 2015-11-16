using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
//using System.Windows.Forms;

namespace AccesoDato
{
    class Conexion
    {
        private SqlConnection con;
        private static Conexion instancia_conexion;

        public static Conexion Conexion_Instanciar()
        {
            if (instancia_conexion == null)
                instancia_conexion = new Conexion();
            return instancia_conexion;
        }

        //EL CONSTRUTOR:
        private Conexion()
        {
            string cadena_conexion = "server=127.1.1.1; database=beraudent; Uid=root; pwd=;";
            try
            {
                con = new SqlConnection();
                con.ConnectionString = cadena_conexion;
                con.Open();
            }
            catch (SqlException ex)
            {
                //al ser un proyecto de biblioteca de clases no podemos usar windows.forms y por ende no son posibles los messagebox
                //MessageBox.Show(ex.Message);   
                //este try cath podemos implementarlos en el procedimiento almacenado.
            }
        }

    }
}
