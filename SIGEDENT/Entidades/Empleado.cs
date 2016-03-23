using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Empleado
    {
        public string codigo { get; set; }
        public string apellidos { get; set; }
        public string nombres { get; set; }
        public string rut { get; set; }
        public string email { get; set; }
        public Area area { get; set; }
        public Usuario usuario { get; set; }

        //propiedad de solo lectura para obtener el nombre del Area
        public string nombre_area
        {
            get { return area.nombre; }
        }

        //propiedad de solo lectura para obtener el user de usuario
        public string user_usuario
        {
            get { return usuario.user; }
        }

    }
}
