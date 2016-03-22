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
        public int id { get; set; }
        public string user { get; set; }
        public string password { get; set; }
        public string permisos { get; set; }
    }
}
