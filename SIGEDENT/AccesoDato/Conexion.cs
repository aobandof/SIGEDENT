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
    public class Conexion
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
            //string cadena_conexion = "server=127.1.1.1; database=beraudent; Uid=root; pwd=;"; //para mysql            
            try
            {
                con = new SqlConnection();
                con.ConnectionString = @"Data Source=CONTABILIDAD6; Initial Catalog=beraudent; Integrated Security=Yes";
                //con.ConnectionString = @"Data Source=LIAM; Initial Catalog=beraudent; Integrated Security=Yes";
                con.Open();
            }
            catch (SqlException ex)
            {
                //al ser un proyecto de biblioteca de clases no podemos usar windows.forms y por ende no son posibles los messagebox
                //MessageBox.Show(ex.Message);   
                //este try cath podemos implementarlos en el procedimiento almacenado.
            }
        }
        public int Sesion_Iniciar()
        {
            SqlCommand cmd = new SqlCommand("select * from usuario where nick_usua='ofaber' and pass_usua='123456'", con);
            return cmd.ExecuteNonQuery();

        }

    }
}
