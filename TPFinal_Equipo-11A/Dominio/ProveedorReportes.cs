using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ProveedorReportes : Proveedor
    {
        public int CantidadProductos { get; set; }
        public long ProductoID { get; set; }
        public string NombreProducto { get; set; }
        public decimal PrecioVenta { get; set; }
        public int StockActual { get; set; }
        public int StockMinimo { get; set; }
        public int TotalActivos { get; set; }
        public int TotalInactivos { get; set; }
    }
}
