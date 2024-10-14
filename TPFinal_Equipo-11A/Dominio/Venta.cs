using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Venta
    {
        public int Id { get; set; }
        public Cliente Cliente { get; set; }

        //public List<ProductoVenta> Productos { get; set; } -- Se podria hacer algo asi
        public decimal PrecioTotal { get; set; }
        public DateTime FechaVenta { get; set; }
        public Factura Factura { get; set; }
    }
}
