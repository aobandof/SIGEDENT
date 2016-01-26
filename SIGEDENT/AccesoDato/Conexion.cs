using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
//using System.Windows.Forms;

namespace Datos
{
    public class Conexion
    {
        public SqlConnection con;
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
            con = new SqlConnection();
            //cadenas de conexion mas portable (siempre y cuando el nombre de la instancia del Server SQL sea la misma que el nombre de la maquina
            con.ConnectionString = @"Data Source=" + Environment.MachineName + "; Initial Catalog=beraudent; Integrated Security=Yes";
            con.Open();           
        }
        //public int Sesion_Iniciar()
        //{
        //    SqlCommand cmd = new SqlCommand("select * from usuario where nick_usua='ofaber' and pass_usua='123456'", con);
        //    return cmd.ExecuteNonQuery();

        //}

    }
}
