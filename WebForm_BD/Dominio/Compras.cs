using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Compras
    {
        public int IDCompra { get; set; }
        public int IDProveedor { get; set; }
        public Proveedores Proveedor { get; set; }
        public int IDTipoFactura { get; set; }
        public TiposFacturas TipoFacturas { get; set; }
        public int NumComprobante { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Descuentos { get; set; }
        public decimal Subtotal { get; set; }
        public decimal Total { get; set; }
        public string Observaciones { get; set; }
        public string CondicionIVA { get; set; }
        public string IIBB { get; set; }
        public int IDEmpleado { get; set; }
        public Empleados Empleado { get; set; }
        public int IDFormaPago { get; set; }
        public FormasPagos FormasPagos { get; set; }

        public Compras()
        {
            Proveedor = new Proveedores();
            TipoFacturas = new TiposFacturas();
            Empleado = new Empleados();
            FormasPagos = new FormasPagos();
        }
    }
}
