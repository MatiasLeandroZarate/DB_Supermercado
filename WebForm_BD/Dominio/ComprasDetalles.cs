using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ComprasDetalles
    {
        public int IDCompraDetalle { get; set; }
        public int IDArticulo{ get; set; }
        Articulos Articulos { get; set; }
        public int IDCompra { get; set; }
        Compras Compras { get; set; }
        public int Cantidad{ get; set; }
        public DateTime Fecha{ get; set; }
        public decimal PrecioUnitario{ get; set; }

        public ComprasDetalles()
        {
            Articulos = new Articulos();
            Compras = new Compras();
        }
}
}
