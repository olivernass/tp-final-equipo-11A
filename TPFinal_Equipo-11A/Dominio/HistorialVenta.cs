using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class HistorialVenta
    {
        //public int NumeroDocumento { get; set; }
        //public string NombreCliente { get; set; }
        //public string ApellidoCliente { get; set; }
        //public string NombreProducto { get; set; }
        //public int Cantidad { get; set; }
        //public decimal Subtotal { get; set; }
        //public long NumeroFactura { get; set; }
        //public DateTime FechaCreacion { get; set; }

        public int? NumeroDocumento { get; set; }
        public string NombreCliente { get; set; }
        public string ApellidoCliente { get; set; }
        public string NombreProducto { get; set; }
        public int Cantidad { get; set; }
        public decimal Subtotal { get; set; }
        public long? NumeroFactura { get; set; }
        public DateTime? FechaCreacion { get; set; }
    }
}
