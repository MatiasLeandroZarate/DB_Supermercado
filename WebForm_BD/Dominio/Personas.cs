using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Personas
    {
        public int IdPersona{ get; set; }
        public string DNI{ get; set; }
        public string Apellido { get; set; }
        public string Nombre { get; set; }
        public string Direccion { get; set; }
        public string Email { get; set; }
        public string Telefono{ get; set; }
        public bool Activo { get; set; }
        public DateTime FechaAlta{ get; set; }
        public DateTime FechaUltimaModificacion{ get; set; }
        public string Cuit { get; set; }

}
}
