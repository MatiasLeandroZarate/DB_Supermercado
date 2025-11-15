using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Reporte
    {
        public int IDCliente { get; set; }
        public string ApellidoNombre { get; set; }
        public int CantidadVentas { get; set; }
        public decimal TotalFacturado { get; set; }
        public DateTime UltimaCompraCLI { get; set; }
        //----------------------------------------------//
        public int IdProveedor { get; set; }
        public string RazonSocial { get; set; }
        public int CantidadComprasPRO { get; set; }
        public decimal TotalComprado { get; set; }
        public DateTime UltimaCompraPRO { get; set; }
        //----------------------------------------------//
        public int IdEmpleado { get; set; }
        public string Empleado { get; set; }
        public decimal TotalPagado { get; set; }
        public DateTime UltimoPago { get; set; }
        //----------------------------------------------//
        public int IdArticulo { get; set; }
        public string Articulo { get; set; }
        public int Stock { get; set; }
        public decimal Precio { get; set; }
        public decimal ValorInventario { get; set; }
        public string Categoria { get; set; }
        //----------------------------------------------//
        public int IdMovimientoART { get; set; }
        public DateTime FechaMovimiento { get; set; }
        public string TipoMovimiento { get; set; }
        //Articulo//
        public int Cantidad { get; set; }
        //PRECIO//
        public decimal PrecioVenta { get; set; }
    }
}

