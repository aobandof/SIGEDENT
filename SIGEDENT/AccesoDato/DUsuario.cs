    using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

//using CapaEntidades;

namespace Datos
{    
    public sealed class DUsuario
    {
    /*public static Conexion conexion; //esto ya no es necesario debido a que al invocar el metodo Conexion_instanciar estatico,
    * no es necesario declarar ni isntanciar la clase, y además como es SINGLETON, si no existe la clase CONEXION, el metodo lo constuye
    * para despues poder acceder a su parametro publico con que devuelve un sql conection */
    public static SqlCommand cmd;   //lo declaramos aca para evitar hacerlo en muchas funciones
 
 /* metodo para loguearse, que facilmente podia devolver un entero indicando que encontro el registro,
  * pero mejor devolver un objeto para trabajarlo en una sesion o para mostrar los datos del usuario logueado */
        public static Entidades.Usuario Usuario_Loguear (string user, string password)
        {
            Entidades.Usuario usuario = new Entidades.Usuario();
            //conexion = Conexion.Conexion_Instanciar();
            //SqlCommand cmd = new SqlCommand(); // ya esta declarodo al inicio de la clase   
            cmd=new SqlCommand("sp_usuario_loguear", Conexion.Conexion_Instanciar().con);// esta fila, reemplaza a las 2 siguientes comentadas
            //cmd.Connection = conexion.con;
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.CommandText = "sp_usuario_loguear";
            cmd.Parameters.Add(new SqlParameter("@user", user));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    usuario.id = Convert.ToInt16(dr["id"]);
                    usuario.user = dr["user"].ToString();
                    usuario.password = dr["password"].ToString();// verificar despues, si es necesario este campos, por ser secreto
                    usuario.permisos = dr["permisos"].ToString();
                }
                dr.Close();
            }
            catch (SqlException e)
            {
                throw new Exception("Error encontrado: " + e.Message);
            }
            return usuario;                
        }


        //super flashap spot
        //        public static Entidades.Usuario Usuario_Loguear_antiguo(string pnickname, string ppassword)
        //        {
        //            //throw new Exception("PA VER");
        //            Entidades.Usuario usuario_conectado = new Entidades.Usuario();
        //            conexion = Conexion.Conexion_Instanciar(); //aca es donde se realiza la conexion permanente
        //            cmd = new SqlCommand("sp_usuario_loguear_antiguo", conexion.con);
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.Add(new SqlParameter("@nickname", pnickname));
        //            cmd.Parameters.Add(new SqlParameter("@password", ppassword));

        //            SqlParameter pmensaje = new SqlParameter("@mensaje", SqlDbType.VarChar);
        //            pmensaje.Direction = ParameterDirection.Output;
        //            pmensaje.Size = 200;
        //            cmd.Parameters.Add(pmensaje);

        //            //SqlDataAdapter adaptador = new SqlDataAdapter(cmd);
        //            SqlDataReader data_reader;
        //            cmd.ExecuteNonQuery();//para obtener el parametro de salida @mensaje            

        //            if (cmd.Parameters["@mensaje"].Value.ToString() != "") {
        //                throw new Exception(cmd.Parameters["@mensaje"].Value.ToString());                               
        //            }
        //            else {
        //                data_reader = cmd.ExecuteReader();//para llenar el data_reader con el select realizado
        //                while (data_reader.Read())
        //                {
        //                    usuario_conectado.nick=data_reader["nickname"].ToString();
        //                    usuario_conectado.password = data_reader["password"].ToString();
        //                    usuario_conectado.apellidos = data_reader["apellidos"].ToString();
        //                    usuario_conectado.nombres = data_reader["nombres"].ToString();
        //                    usuario_conectado.permisos = data_reader["permisos"].ToString();
        //                }
        //                data_reader.Close();
        //            }            
        //            return usuario_conectado;
        //        }

        //        /*en la siguiente funcion enviamos un ArrayList con valor cantidad del query usuario (1 si encontro al usuario) y el mensaje obtenido del procedimiento almacenado
        //        se penso tambien en otro valor que seria el carater de permisos pero despues se optó mejor en devolver el objeto usuario completo*/
        //        public static ArrayList Usuario_Loguear_anterior(string pnickname, string ppassword){ // devuelve valor entero indicando la cantidad de filas encontradas

        //            ArrayList respuestas_bd = new ArrayList();

        //            conexion = Conexion.Conexion_Instanciar(); //aca es donde se realiza la conexion permanente
        //            cmd = new SqlCommand("sp_usuario_loguear",conexion.con);
        //            //cmd.CommandText = "sp_loguear";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            //cmd.Connection = conexion.con;

        //            cmd.Parameters.Add(new SqlParameter("@nickname", pnickname));
        //            cmd.Parameters.Add(new SqlParameter("@password", ppassword));

        //            SqlParameter plogueado = new SqlParameter("@logueado", 0);
        //            plogueado.Direction = ParameterDirection.Output;
        //            cmd.Parameters.Add(plogueado);
        //            SqlParameter pmensaje = new SqlParameter("@mensaje", SqlDbType.VarChar);
        //            pmensaje.Direction = ParameterDirection.Output;
        //            pmensaje.Size = 40;
        //            cmd.Parameters.Add(pmensaje);
        //            cmd.ExecuteNonQuery();

        //            respuestas_bd.Add(cmd.Parameters["@logueado"].Value);
        //            respuestas_bd.Add(cmd.Parameters["@mensaje"].Value.ToString());
        //            //return cmd.Parameters["@mensaje"].Value.ToString();

        //            return respuestas_bd;
        //        }
    }
}
