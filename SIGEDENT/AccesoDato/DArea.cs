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

        //metodo para guardar nuevo registro en la base de datos
        public static int Area_Insertar(Entidades.Area a)
        {
            //Modulos modulos = new Modulos();
            string[] nomb_parametros = { "@operacion", "@nombre" };
            return Modulos.Ejecutar("sp_area_ia", nomb_parametros, 'I', a.nombre);
        }

        //metodo para actualizar un registro en la base de datos
        public static int Area_Actualizar(Entidades.Area a)
        {
            //Modulos modulos = new Modulos();
            string[] nomb_parametros = { "@operacion", "@id", "@nombre" };
            return Modulos.Ejecutar("sp_area_ia", nomb_parametros, 'A', a.id, a.nombre);
        }

        //metodo para seleccionar una tabla de registros
        public static DataTable Area_Seleccionar_Todos_Registros()
        {
            //DataTable dt =new DataTable;
            //Modulos modulos = new Modulos();
            string[] nomb_parametros = { "@operacion", "@id" };
            return Modulos.Obtener_Registros("sp_area_se", nomb_parametros, 'W', 0);
        }

        //metodo para seleccionar un registro
        public static Entidades.Area Area_Seleccionar_Registro(string id)
        {
            DataTable dt = new DataTable();
            Entidades.Area area = new Entidades.Area();
            //Modulos modulos = new Modulos();
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
        public static int Eliminar_Area(string id)
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
