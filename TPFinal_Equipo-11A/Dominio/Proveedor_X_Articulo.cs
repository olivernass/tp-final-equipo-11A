using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Proveedor_X_Articulo
    {
        public Proveedor Id_Proveedor { get; set; }
        public Producto Id_Producto { get; set; }
        public decimal Precio_Compra { get; set; }
    }
}
