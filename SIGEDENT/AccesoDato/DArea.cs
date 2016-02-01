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

        //Metodo para Insertar y Actualizar
        public static int Area_Grabar(Entidades.Area a)
        {
            string[] nomb_parametros = { "@id", "@nombre" };
            return Modulos.Ejecutar("sp_area_grabar", nomb_parametros,a.id, a.nombre);
        }
        
        //metodo para seleccionar una tabla de registros
        public static DataTable Area_Seleccionar_Todos_Registros()
        {
            string[] nomb_parametros = { "@operacion", "@id" };
            return Modulos.Obtener_Registros("sp_area_se", nomb_parametros, 'W', 0);
        }

        //metodo para seleccionar un registro
        public static Entidades.Area Area_Seleccionar_Registro(int id)
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
        }

        //metodo para eliminar un registro
        public static int Area_Eliminar(int id)
        {
            //Modulos modulos = new Modulos();
            string[] nomb_parametros = { "@operacion", "@id" };
            return Modulos.Ejecutar("sp_area_se", nomb_parametros, 'E', id);
        }

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

    }
}
