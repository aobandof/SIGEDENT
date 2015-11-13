using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Usuario
    {
        //propiedades de lectura y escritura
        public string nickname { get; set; }
        public string password { get; set; }
        public string apellidos { get; set; }
        public string nombres { get; set; }
        public char permisos { get; set; }
    }
}
