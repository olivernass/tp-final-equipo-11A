using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Detalle_Compra
    {
        public int Id { get; set; }

        public Compra Compra { get; set; }

        public Producto Producto { get; set; }

        public int Cantidad { get; set; }

        public decimal Precio_Compra_Unitario { get; set; }

        public decimal Subtotal { get; set; }
    }
}
