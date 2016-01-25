using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LogicaNegocio
{
    public class LNUsuario
    {
        public static Entidades.Usuario LNUsuario_Loguear(string pnickname, string ppassword)
        {
            return AccesoDato.ADUsuario.Usuario_Loguear(pnickname, ppassword);
        }

    }
}
