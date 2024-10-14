using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Compra
    {
        public int Id { get; set; }
        public Proveedor Proveedor { get; set; }

        //public List<ProductoCompra> Productos { get; set; } -- Se podria hacer algo asi
        public DateTime FechaCompra { get; set; }
    }
}
