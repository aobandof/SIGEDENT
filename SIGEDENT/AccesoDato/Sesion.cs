using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace AccesoDato
{
    public class Sesion
    {
        public static Conexion conexion;

        public bool Sesion_iniciar()
        {
            conexion = Conexion.Conexion_Instanciar();
            
            
            return true;

        }

    }
}
