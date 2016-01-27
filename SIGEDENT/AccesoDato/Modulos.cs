using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public class Modulos
    {
        public static SqlCommand cmd;
                
        //modulo para obtener un Datatable de una consulta select        
        public static DataTable Obtener_Registros(string nombre_procedimiento, String[] nombres_parametros, params Object[] valores_parametros)
        {            
            cmd = new SqlCommand(nombre_procedimiento,Conexion.Conexion_Instanciar().con);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            if (nombre_procedimiento.Length != 0 && nombres_parametros.Length == valores_parametros.Length) 
            { 
                int i=0;
                foreach(string nomb_parametro in nombres_parametros)
                    cmd.Parameters.Add(new SqlParameter(nomb_parametro,valores_parametros[i++]));
            }
            try 
            {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
            }
            catch (SqlException e)
            {
                throw new Exception("Error Encontrado: "+e.Message);
            }
            return dt;
        }

        //modulo ejecutar que se dinamiza para insertar, actualizar, seleccionar  y eliminar        
        public static int Ejecutar(string nombre_procedimiento, string[] nombres_parametros, params Object[] valores_parametros ){
            cmd = new SqlCommand(nombre_procedimiento, Conexion.Conexion_Instanciar().con);
            cmd.CommandType = CommandType.StoredProcedure;
            if (nombre_procedimiento.Length != 0 && nombres_parametros.Length == valores_parametros.Length)
            {
                int i = 0;
                foreach(string nombre_parametro in nombres_parametros){
                    cmd.Parameters.Add(new SqlParameter(nombre_parametro, valores_parametros[i++]));
                }
                try
                {
                    return cmd.ExecuteNonQuery();
                }
                catch (SqlException e)
                {
                    throw new Exception("Error encontrado: " + e.Message);
                }
            }
            return 0;
        }
    }
}
