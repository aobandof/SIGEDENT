using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

//using CapaEntidades;

namespace AccesoDato
{    
    public class ADUsuario
    {
        public static SqlCommand cmd;
        public static Conexion conexion;
        
        public static bool Usuario_Grabar(Entidades.Usuario pUsuario)
        {


            return true; //Convert.ToBoolean(cmd.ExcecuteNonQuery());
        }

        public static Entidades.Usuario Usuario_Loguear(string pnickname, string ppassword)
        {
            Entidades.Usuario usuario_conectado = new Entidades.Usuario();
            conexion = Conexion.Conexion_Instanciar(); //aca es donde se realiza la conexion permanente
            cmd = new SqlCommand("sp_usuario_loguear", conexion.con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@nickname", pnickname));
            cmd.Parameters.Add(new SqlParameter("@password", ppassword));

            //SqlDataAdapter adaptador = new SqlDataAdapter(cmd);
            SqlDataReader data_reader;           
            data_reader=cmd.ExecuteReader();
            while (data_reader.Read())
            {
                usuario_conectado.nickname=data_reader["nickname"].ToString();
                usuario_conectado.password = data_reader["password"].ToString();
                usuario_conectado.apellidos = data_reader["apellidos"].ToString();
                usuario_conectado.nombres = data_reader["nombres"].ToString();
                usuario_conectado.permisos = data_reader["permisos"].ToString();
            }
            data_reader.Close();
            return usuario_conectado;

            //tenemos ademas que enviar una variable output al procemiento almacenado que capture un mensaje que puede indicar:
            // vacio si todo funciona de forma correcta, en este caso se obtiene el objeto usuario a enviar
            // o el mensaje de credenciales incorrectas
            // o el mensaje del Catch si se presentó algun error
            // comparamos si @mensaje!='' lo enviamos como un Throw al formulario Login

        }
        
        //en la siguiente funcion enviamos un ArrayList con valor cantidad del query usuario (1 si encontro al usuario) y el mensaje obtenido del procedimiento almacenado
        //se penso tambien en otro valor que seria el carater de permisos pero despues se optó mejor en devolver el objeto usuario completo
        public static ArrayList Usuario_Loguear_anterior(string pnickname, string ppassword){ // devuelve valor entero indicando la cantidad de filas encontradas

            ArrayList respuestas_bd = new ArrayList();

            conexion = Conexion.Conexion_Instanciar(); //aca es donde se realiza la conexion permanente
            cmd = new SqlCommand("sp_usuario_loguear",conexion.con);
            //cmd.CommandText = "sp_loguear";
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Connection = conexion.con;

            cmd.Parameters.Add(new SqlParameter("@nickname", pnickname));
            cmd.Parameters.Add(new SqlParameter("@password", ppassword));

            SqlParameter plogueado = new SqlParameter("@logueado", 0);
            plogueado.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(plogueado);
            SqlParameter pmensaje = new SqlParameter("@mensaje", SqlDbType.VarChar);
            pmensaje.Direction = ParameterDirection.Output;
            pmensaje.Size = 40;
            cmd.Parameters.Add(pmensaje);
            cmd.ExecuteNonQuery();

            respuestas_bd.Add(cmd.Parameters["@logueado"].Value);
            respuestas_bd.Add(cmd.Parameters["@mensaje"].Value.ToString());
            //return cmd.Parameters["@mensaje"].Value.ToString();

            return respuestas_bd;
        }
    }
}
