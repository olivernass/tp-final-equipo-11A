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

        public string Siglas { get; set; }
        public string Nombre { get; set; }
        public string Contacto { get; set; }
        public string Direccion { get; set; }

        public string Correo { get; set; }

        public string Telefono { get; set; }
        //public List<Producto> Productos { get; set; } DUDA

        public bool Activo { get; set; }
    }
}
