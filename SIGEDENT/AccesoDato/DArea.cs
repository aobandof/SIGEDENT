﻿using System;
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
            cmd.Parameters.Add(new SqlParameter("@valor", id));
            try { return cmd.ExecuteNonQuery(); }
            catch (SqlException e) { throw new Exception("Error encontrado: " + e.Message); }
        }
         //METODO PARA SELECCIONAR UN REGISTRO
        public static Entidades.Area Area_Seleccionar_Registro(int id) {
            instanciar_cmd("sp_area_seleccionar_registro");            
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
        //METODO PARA SELECCIONAR TODOS REGISTRO
        public static DataTable Area_Seleccionar_Tabla()
        {
            instanciar_cmd("sp_area_seleccionar_tabla");
            DataTable dt = new DataTable();
            try {
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
            }
            catch (SqlException e) { throw new Exception("Error Encontrado: " + e.Message); }
            return dt;            
        }      
        //METODO PARA SELECCIONAR UN FILTRO DE REGISTROS
        public static DataTable Area_Seleccionar_Filtro(string nombre_columna, object valor_columna)
        {
            if(nombre_columna=="nombre")
                instanciar_cmd("sp_area_filtrar_nombre");
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
        public static int Area_Buscar(string nombre_columna, object valor_columna)
        {           
            if (nombre_columna == "id") //parece que para los id autoincrementables, nadie busca por id. Y PARA aquellas key con otro nombre cambiar el campo
                instanciar_cmd("sp_area_buscar_id");//el nombre de parametro varía segun el nombre de la columna y la tabla a buscar                         
            if (nombre_columna == "nombre")
                instanciar_cmd("sp_area_buscar_nombre");                        
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
