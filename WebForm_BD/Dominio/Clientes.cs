using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Clientes
    {
        public int IdCliente { get; set; }
        public int IDPersona { get; set; }
        public Personas Personas { get; set; }
        public string FranjaHoraria { get; set; }

        public Clientes() { Personas = new Personas(); }

    }
}
