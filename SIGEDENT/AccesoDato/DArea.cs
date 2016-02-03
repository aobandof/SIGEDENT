using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public sealed class DArea
    {
        public static SqlCommand cmd;
        //int i;      
        
        private static void instanciar_cmd(string nombre_procedimiento){
            cmd = new SqlCommand(nombre_procedimiento, Conexion.Conexion_Instanciar().con);
            cmd.CommandType = CommandType.StoredProcedure;
        }
        //METODO PARA INSERTAR y ACTUALIZAR REGISTRO
        public static int Area_Grabar(Entidades.Area a){
            instanciar_cmd("sp_area_grabar");
            string[] nombres_parametros =   { "@id", "@nombre" }; //SIEMPRE HAY QUE VERIFICAR QUE AMBOS ARREGLOS TENGAN LA MISMA LONGITUD
            Object[] valores_parametros =   { a.id, a.nombre };
            int i = 0;
            foreach (string nombre_parametro in nombres_parametros) {
                cmd.Parameters.Add(new SqlParameter(nombre_parametro, valores_parametros[i++]));
            }
            try {   return cmd.ExecuteNonQuery(); }
            catch (SqlException e)  { throw new Exception("Error encontrado: " + e.Message); }
        }
        //METODO PARA ELIMINAR REGISTRO
        public static int Area_Eliminar(int id)
        {
            instanciar_cmd("sp_area_eliminar");
            cmd.Parameters.Add(new SqlParameter("@id", id));
            try { return cmd.ExecuteNonQuery(); }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }
        }
        //METODO PARA SELECCIONAR TODOS REGISTRO
        public static DataTable Area_Seleccionar_Todos_Registros()
        {
            instanciar_cmd("sp_area_seleccionar_todos");
            DataTable dt = new DataTable();
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
            }
            catch (SqlException e) { throw new Exception("Error Encontrado: " + e.Message); }
            return dt;            
        }      
        //METODO PARA SELECCIONAR UN REGISTRO
        public static Entidades.Area Area_Seleccionar_Registro(int id) {
            instanciar_cmd("sp_area_seleccionar");            
            Entidades.Area area = new Entidades.Area();
            cmd.Parameters.Add(new SqlParameter("@id", id));
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    area.id = dr.GetInt16(0);
                    area.nombre = dr.GetString(1);
                }
            }
            catch (Exception e){ throw new Exception("Error Encontrado: " + e.Message);  }            
            return area;
        }
        //METODO PARA SELECCIONAR UN FILTRO DE REGISTROS
        public static DataTable Area_Seleccionar_Filtro(string filtro)
        {
            DataTable dt = new DataTable();
            cmd = new SqlCommand("sp_area_filtrar", Conexion.Conexion_Instanciar().con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@filtro", filtro));
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
                return dt;
            }
            catch (SqlException e)
            {
                throw new Exception("Error encontrado: " + e.Message);
            }
        }

        //metodo para seleccionar una tabla de registros
        /*public static DataTable Area_Seleccionar_Todos_Registros()
        {
            string[] nomb_parametros = { "@operacion", "@id" };
            return Modulos.Obtener_Registros("sp_area_se", nomb_parametros, 'W', 0);
        }*/

        //metodo para seleccionar un registro
        /*public static Entidades.Area Area_Seleccionar_Registro(int id)
        {
            DataTable dt = new DataTable();
            Entidades.Area area = new Entidades.Area();
            string[] nomb_parametros = { "@operacion", "@id" };
            dt = Modulos.Obtener_Registros("sp_area_se", nomb_parametros, 'S', id);
            foreach (DataRow fila in dt.Rows)
            {
                area.id = Convert.ToInt16(fila["id"]);
                area.nombre = fila["nombre"].ToString();                
            }
            return area;
        }*/




        //Metodo para Insertar y Actualizar
        /*public static int Area_Grabar(Entidades.Area a)
        {
            string[] nomb_parametros = { "@id", "@nombre" };
            return Modulos.Ejecutar("sp_area_grabar", nomb_parametros,a.id, a.nombre);
        }*/


    }
}
