using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class PagoSueldos
    {
        public int IdSueldo { get; set; }
        public int IdEmpleado { get; set; }
        public Empleados Empleados { get; set; }
        public DateTime FechaPago { get; set; }
        public string Periodo { get; set; }
        public decimal MontoPagado { get; set; }
        public string MetodoPago { get; set; }
        public PagoSueldos()
        {
            Empleados empleados = new Empleados();
        }
    }
}
