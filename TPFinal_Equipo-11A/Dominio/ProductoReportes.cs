using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ProductoReportes : Producto
    {
        public int CantidadProveedores { get; set; }
        public List<ProveedorReportes> ProveedoresAsociados { get; set; }
        public string NombreMarca { get; set; }
        public string NombreCategoria { get; set; }
        public string Proveedores2 { get; set; } // Lista de proveedores, separados por comas
        public Proveedor ProveedorExclusivo { get; set; } // Proveedor único del producto
    }
}
