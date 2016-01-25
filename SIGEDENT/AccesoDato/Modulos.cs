using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace AccesoDato
{
    public class Modulos
    {
        public static SqlCommand cmd;
        //modulo para obtener un Datatable de una consulta select
        
        public DataTable Obtener_Registros(string nombre_procedimiento, String[] nombres_parametros, params Object[] valor_parametros){
            cmd = new SqlCommand(nombre_procedimiento,Conexion.Conexion_Instanciar().con);
            //cmd.CommandType=
            DataTable dt = new DataTable();
            //if(nombre_procedimiento.Length!=0 && nombres_parametros.Length==valor_parametros.Length)
            //    foreach(string nomb_parametro in nombres_parametros){                    
            //    }
            return dt;
        }

        //modulo ejecutar que se dinamiza para insertar, actualizar, seleccionar  y eliminar
        
        public int Ejecutar(string nombre_procedimiento, string[] nombres_parametros, params Object[] valor_parametros ){
            

            return 0;
        }
    }
}
