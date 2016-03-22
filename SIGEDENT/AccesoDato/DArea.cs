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
        public static Conexion conec = Conexion.Conexion_Instanciar();

        private static void instanciar_cmd(string nombre_procedimiento){
            //cmd = new SqlCommand(nombre_procedimiento, Conexion.Conexion_Instanciar().con);
            cmd = new SqlCommand(nombre_procedimiento, conec.con);
            cmd.CommandType = CommandType.StoredProcedure;
        }
        //METODO PARA INSERTAR y ACTUALIZAR REGISTRO
        public static int Area_Grabar(Entidades.Area pa){
            instanciar_cmd("sp_area_grabar");
            string[] nombres_parametros =   { "@id", "@nombre" }; //SIEMPRE HAY QUE VERIFICAR QUE AMBOS ARREGLOS TENGAN LA MISMA LONGITUD
            Object[] valores_parametros =   { pa.id, pa.nombre };
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
         //METODO PARA SELECCIONAR UN REGISTRO
        public static Entidades.Area Area_Seleccionar_Id(int id) {
            instanciar_cmd("sp_area_seleccionar_id");            
            Entidades.Area area = new Entidades.Area();
            cmd.Parameters.Add(new SqlParameter("@id", id));
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    area.id = dr.GetInt16(0);
                    area.nombre = dr.GetString(1);
                }
                dr.Close();
            }
            catch (Exception e){ throw new Exception("Error Encontrado: " + e.Message);  }                        
            return area;
        }
        //METODO PARA SELECCIONAR TODOS REGISTRO en un Datatable
        public static DataTable Area_Seleccionar_Tabla()
        {
            instanciar_cmd("sp_area_seleccionar_tabla");
            DataTable dt = new DataTable();
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
                dr.Close();
            }
            catch (SqlException e) { throw new Exception("Error Encontrado: " + e.Message); }
            return dt;            
        }
        //METODO PARA SELECCIONAR TODOS REGISTRO en una Lista de Objetos
        public static List<Entidades.Area> Area_Seleccionar_Lista()
        {
            instanciar_cmd("sp_area_seleccionar_tabla");
            var lista=new List<Entidades.Area>();            
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()){
                    var area = new Entidades.Area();
                    area.id = dr.GetInt16(0);
                    area.nombre = dr.GetString(1);
                    lista.Add(area);
                    area=null;
                }
                dr.Close();
            }
            catch (SqlException e) { throw new Exception("Error Encontrado: " + e.Message); }
            return lista;
        }  
        //METODO PARA SELECCIONAR UN FILTRO DE REGISTROS en un Datatable
        public static DataTable Area_Seleccionar_Filtro_Tabla(string nombre_columna, object valor_columna)
        {
            if (nombre_columna == "nombre")
            {
                instanciar_cmd("sp_area_filtrar_nombre");
                cmd.Parameters.Add(new SqlParameter("@nombre", valor_columna));
            }
            //si hubieran mas columnas posibles a filtrar, crear mas CONDICIONALES con su respectivo nombre de columna y sp
            DataTable dt = new DataTable();
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
                dr.Close();
                return dt;
            }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }
        }

        //METODO PARA SELECCIONAR UN FILTRO DE REGISTROS en una lista de objetos
        public static List<Entidades.Area> Area_Seleccionar_Filtro_Lista(string nombre_columna, object valor_columna)
        {
            var lista=new List<Entidades.Area>();
                
            if (nombre_columna == "nombre")
            {
                instanciar_cmd("sp_area_filtrar_nombre");
                cmd.Parameters.Add(new SqlParameter("@nombre", valor_columna));
            }
            //si hubieran mas columnas posibles a filtrar, crear mas CONDICIONALES con su respectivo nombre de columna y sp
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()){
                    var area = new Entidades.Area();
                    area.id=dr.GetInt16(0);
                    //area.id=Convert.ToInt16(dr[dr.GetOrdinal("id")]);
                    area.nombre=dr.GetString(1);
                    //area.nombre=dr[dr.GetOrdinal("nombre")].ToString();
                    lista.Add(area);
                    area=null;
                }
                dr.Close();
            }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }
            return lista;
        }

        //METOD PARA BUSCAR UN REGISTRO ya sea ID, CODIGO U OTRA COLUMNA, el metodo determinar que proedimiento tomar
        public static int Area_Buscar(string nombre_columna, object valor_columna)
        {
            if (nombre_columna == "id")
            { //parece que para los id autoincrementables, nadie busca por id. Y PARA aquellas key con otro nombre cambiar el campo
                instanciar_cmd("sp_area_buscar_id");//el nombre de parametro varía segun el nombre de la columna y la tabla a buscar   
                cmd.Parameters.Add(new SqlParameter("@id", valor_columna));
            }
            if (nombre_columna == "nombre")
            {
                instanciar_cmd("sp_area_buscar_nombre");
                cmd.Parameters.Add(new SqlParameter("@nombre", valor_columna));
            }
            //si hubieran otras columnas a buscar, agregarlas tanto aca y crear su respectivo procedimiento                        
            SqlParameter pencontrado = new SqlParameter("@encontrado", 0);
            pencontrado.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(pencontrado);
            try { return cmd.ExecuteNonQuery(); }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }   
        }
    }
}
