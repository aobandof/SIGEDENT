using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class LNUsuario
    {
        public static int Usuario_Iniciar(string pnickname, string ppassword)
        {
            return AccesoDato.ADUsuario.Usuario_Iniciar(pnickname, ppassword);
        }
    }
}
