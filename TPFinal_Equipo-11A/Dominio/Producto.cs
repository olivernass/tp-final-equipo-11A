﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Producto
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public Marca Marca { get; set; }
        public Categoria Categoria { get; set; }
        public int StockActual { get; set; }
        public int StockMinimo { get; set; }
        public decimal PrecioCompraReciente { get; set; }
        public decimal PorcentajeGanancia { get; set; }
        public List<Proveedor> Proveedores { get; set; }
    }
}
