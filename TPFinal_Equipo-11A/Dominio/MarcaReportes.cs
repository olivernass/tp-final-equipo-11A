using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class MarcaReportes : Marca
    {
        public int CantidadProductos { get; set; }
        public long ProductoID { get; set; }       // ID del producto más costoso
        public string NombreProducto { get; set; } // Nombre del producto más costoso
        public decimal PrecioVenta { get; set; }   // Precio de venta del producto más costoso
    }
}
