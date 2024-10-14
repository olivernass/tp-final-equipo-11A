using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Proveedor
    {
        public int Id { get; set; }

        //public string Codigo { get; set; } DUDA
        public string Nombre { get; set; }
        public string Contacto { get; set; }
        public string Direccion { get; set; }

        public string Email { get; set; }

        public string Telefono { get; set; }
        //public List<Producto> Productos { get; set; } DUDA

        public bool Activo { get; set; }
    }
}
