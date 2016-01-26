using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NUsuario
    {
        public static Entidades.Usuario LNUsuario_Loguear(string pnickname, string ppassword)
        {
            return Datos.DUsuario.Usuario_Loguear(pnickname, ppassword);
        }

    }
}
