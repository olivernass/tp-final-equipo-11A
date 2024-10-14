using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    internal class Detalle_Venta
    {
        public int Id { get; set; }

        public Venta Venta { get; set; }

        public Producto Producto { get; set; }

        public int Cantidad { get; set; }

        public decimal Precio_Venta_Unitario { get; set; }

        public decimal SubTotal { get; set; }
    }
}
