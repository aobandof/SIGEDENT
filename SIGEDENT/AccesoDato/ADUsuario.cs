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
    public sealed class ADUsuario
    {
        public SqlCommand cmd;
        public Conexion conexion;
        
        public static bool Usuario_Grabar(Entidades.Usuario pUsuario)
        {


            return true; //Convert.ToBoolean(cmd.ExcecuteNonQuery());
        }

        public int Usuario_Leer(Entidades.Usuario pUsuario){ // devuelve valor entero indicando la cantidad de filas encontradas

            //conexion = Conexion.Conexion_Instanciar();
            ////cmd = conexion.CreateCommand();

            //cmd=new SqlCommand("select * from usuario",conexion);
            return 1;
        }
    }
}
