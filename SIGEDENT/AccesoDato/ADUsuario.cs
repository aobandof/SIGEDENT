using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

//using CapaEntidades;

namespace AccesoDato
{    
    public class ADUsuario
    {
        public static SqlCommand cmd;
        public static Conexion conexion;
        
        public static bool Usuario_Grabar(Entidades.Usuario pUsuario)
        {


            return true; //Convert.ToBoolean(cmd.ExcecuteNonQuery());
        }

        public static int Usuario_Iniciar(string pnickname, string ppassword){ // devuelve valor entero indicando la cantidad de filas encontradas

            conexion = Conexion.Conexion_Instanciar(); //aca es donde se realiza la conexion permanente
            cmd = new SqlCommand("sp_loguear",conexion.con);
            //cmd.CommandText = "sp_loguear";
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Connection = conexion.con;

            cmd.Parameters.Add(new SqlParameter("@nickname", pnickname));
            cmd.Parameters.Add(new SqlParameter("@password", ppassword));

            SqlParameter plogueado = new SqlParameter("@logueado", 0);
            plogueado.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(plogueado);
            cmd.ExecuteNonQuery();
            return Int32.Parse(cmd.Parameters["@logueado"].Value.ToString());
        }
    }
}
