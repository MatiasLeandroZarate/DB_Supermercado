using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class MovimientosArticulos
    {
        public int IdMovimientoART { get; set; }
        public DateTime FechaMovimiento { get; set; }
        public int IdArticulo { get; set; }
        public Articulos Articulo { get; set; }
        public int Cantidad { get; set; }
        public decimal Precio { get; set; }
        public decimal PrecioVenta { get; set; }
        public int IdTipoMovimiento { get; set; }
        public TiposMovimientos tipoMovimiento { get; set; }
        public MovimientosArticulos()
        {
            Articulos articulo = new Articulos();
            TiposMovimientos tipoMovimiento = new TiposMovimientos();
        }
    }
}
