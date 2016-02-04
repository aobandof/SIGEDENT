using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public sealed class DEmpleado
    {
        public static SqlCommand cmd;
        
        private static void instanciar_cmd(string nombre_procedimiento){
            cmd = new SqlCommand(nombre_procedimiento, Conexion.Conexion_Instanciar().con);
            cmd.CommandType = CommandType.StoredProcedure;
        }
        //METODO PARA INSERTAR y ACTUALIZAR REGISTRO
        public static int Empleado_Grabar(Entidades.Empleado pe){
            instanciar_cmd("sp_empleado_grabar");
            string[] nombres_parametros =   { "@codigo", "@apellidos","@nombres","@rut","id_area" }; //SIEMPRE HAY QUE VERIFICAR QUE AMBOS ARREGLOS TENGAN LA MISMA LONGITUD
            Object[] valores_parametros =   { pe.codigo, pe.apellidos, pe.nombres, pe.rut, pe.area.id};
            int i = 0;
            foreach (string nombre_parametro in nombres_parametros) {
                cmd.Parameters.Add(new SqlParameter(nombre_parametro, valores_parametros[i++]));
            }
            try {   return cmd.ExecuteNonQuery(); }
            catch (SqlException e)  { throw new Exception("Error encontrado: " + e.Message); }
        }
        //METODO PARA ELIMINAR REGISTRO
        public static int Empleado_Eliminar(string codigo)
        {
            instanciar_cmd("sp_empleado_eliminar");
            cmd.Parameters.Add(new SqlParameter("@valor", codigo));
            try { return cmd.ExecuteNonQuery(); }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }
        }
         //METODO PARA SELECCIONAR UN REGISTRO
        public static Entidades.Empleado Empleado_Seleccionar_Registro(string codigo) {
            instanciar_cmd("sp_empleado_seleccionar_registro");            
            Entidades.Empleado empleado = new Entidades.Empleado();
            cmd.Parameters.Add(new SqlParameter("@codigo", codigo));
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    empleado.codigo = dr.GetString(0);
                    empleado.nombres = dr.GetString(1);
                    empleado.nombres = dr.GetString(1);
                }
            }
            catch (Exception e){ throw new Exception("Error Encontrado: " + e.Message);  }            
            return empleado;
        }
        //METODO PARA SELECCIONAR TODOS REGISTRO
        public static DataTable Empleado_Seleccionar_Tabla()
        {
            instanciar_cmd("sp_empleado_seleccionar_tabla");
            DataTable dt = new DataTable();
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
            }
            catch (SqlException e) { throw new Exception("Error Encontrado: " + e.Message); }
            return dt;            
        }      
        //METODO PARA SELECCIONAR UN FILTRO DE REGISTROS
        public static DataTable Empleado_Seleccionar_Filtro(string nombre_columna, object valor_columna)
        {
            if(nombre_columna=="nombre")
                instanciar_cmd("sp_empleado_filtrar_nombre");
            //si hubieran mas columnas posibles a filtrar, crear mas CONDICIONALES con su respectivo nombre de columna y sp
            DataTable dt = new DataTable();
            cmd.Parameters.Add(new SqlParameter("@valor", valor_columna));
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
                return dt;
            }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }
        }
        //METOD PARA BUSCAR UN REGISTRO ya sea ID, CODIGO U OTRA COLUMNA, el metodo determinar que proedimiento tomar
        public static int Empleado_Buscar(string nombre_columna, object valor_columna)
        {           
            if (nombre_columna == "codigo") //parece que para los codigo autoincrementables, nadie busca por codigo. Y PARA aquellas key con otro nombre cambiar el campo
                instanciar_cmd("sp_empleado_buscar_id");//el nombre de parametro varía segun el nombre de la columna y la tabla a buscar                         
            if (nombre_columna == "nombre")
                instanciar_cmd("sp_empleado_buscar_nombre");                        
            //si hubieran otras columnas a buscar, agregarlas tanto aca y crear su respectivo procedimiento                        
            cmd.Parameters.Add(new SqlParameter("@valor", valor_columna));
            SqlParameter pencontrado = new SqlParameter("@encontrado", 0);
            pencontrado.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(pencontrado);
            try { return cmd.ExecuteNonQuery(); }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }   
        }
    }
}
