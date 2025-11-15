using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Proveedores
    {
        public int IdProveedor { get; set; }
        public string RazonSocial{ get; set; }
        public string Cuit{ get; set; }
        public string Telefono{ get; set; }
        public string Email{ get; set; }
        public string Direccion{ get; set; }
        public DateTime FechaAlta { get; set; }
        public DateTime FechaUltimaModificacion { get; set; }
        public bool Activo { get; set; }

}
}
