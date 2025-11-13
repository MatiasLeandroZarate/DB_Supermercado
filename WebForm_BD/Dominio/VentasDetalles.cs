using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class VentasDetalles
    {
        public int IDVentaDetalle { get; set; }
        public int IDArticulo { get; set; }
        public Articulos Articulos { get; set; }
        public int IdVenta { get; set; }
        public Ventas Venta { get; set; }
        public int Cantidad { get; set; }
        public DateTime Fecha { get; set; }
        public decimal PrecioUnitario { get; set; }

        public VentasDetalles()
        {
            Articulos = new Articulos();
            Venta = new Ventas();
        }
    }
}
