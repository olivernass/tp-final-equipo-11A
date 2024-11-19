using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ClienteReportes : Cliente
    {
        public int TotalActivos { get; set; }
        public int TotalInactivos { get; set; }
        public int PromedioAntiguedadDias { get; set; }
    }
}

