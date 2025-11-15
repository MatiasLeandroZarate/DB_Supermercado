using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Empleados
    {
        public int IdEmpleados{ get; set; }
        public int IdCargo{ get; set; }
        public Cargos Cargo { get; set; }
        public int IdPersona{ get; set; }
        public Personas Persona{ get; set; }

        public int Antiguedad{ get; set; }

}
}
