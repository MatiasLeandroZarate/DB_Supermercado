using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ComprasNegocio
    {
        public List<Compras> ListarCompras()
        {
            List<Compras> lista = new List<Compras>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IDCompra, IDProveedor, IDTipoFactura, NumComprobante,Fecha,Descuentos,Subtotal,total,Observaciones, condicionIVA,IIBB,IdEmpleado,IdFormaPago FROM Compras");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Compras aux = new Compras();

                    aux.IDCompra = (int)datos.Lector["IDCompra"];
                    aux.IDProveedor = (int)datos.Lector["Proveedor"];
                    aux.IDTipoFactura = (int)datos.Lector["IDTipoFactura"];
                    aux.NumComprobante= (int)datos.Lector["NumComprabante"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Descuentos = (decimal)datos.Lector["Descuentos"];
                    aux.Subtotal = (decimal)datos.Lector["Subtotal"];
                    aux.Total = (decimal)datos.Lector["Total"];
                    aux.Observaciones = (string)datos.Lector["Observaciones"];
                    aux.IIBB = (string)datos.Lector["IIBB"];
                    aux.IDEmpleado = (int)datos.Lector["IDEmpleado"];
                    aux.IDFormaPago = (int)datos.Lector["IDFormaPago"];

                    lista.Add(aux);
                }
                datos.cerrarLector();

                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(Compras nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO Compras (IDProveedor, IDTipoFactura, NumComprobante,Fecha,Descuentos,Subtotal,total,Observaciones, condicionIVA,IIBB,IdEmpleado,IdFormaPago) VALUES (@IDProveedor, @IDTipoFactura, @NumComprobante,@Fecha,@Descuentos,@Subtotal,@total,@Observaciones, @condicionIVA,@IIBB,@IdEmpleado,@IdFormaPago)");
                datos.setearParametro("@IDProveedor", nuevo.IDProveedor);
                datos.setearParametro("@IDTipoFactura", nuevo.IDTipoFactura);
                datos.setearParametro("@NumComprobante", nuevo.NumComprobante);
                datos.setearParametro("@Fecha", nuevo.Fecha);
                datos.setearParametro("@Descuentos", nuevo.Descuentos);
                datos.setearParametro("@Subtotal", nuevo.Subtotal);
                datos.setearParametro("@total", nuevo.Total);
                datos.setearParametro("@Observaciones", nuevo.Observaciones);
                datos.setearParametro("@condicionIVA", nuevo.CondicionIVA);
                datos.setearParametro("@IIBB", nuevo.IIBB);
                datos.setearParametro("@IdEmpleados", nuevo.IDEmpleado);
                datos.setearParametro("@IdFormaPago", nuevo.IDFormaPago);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Modificar(Compras modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE Compras SET IDProveedor = @IDProveedor, IDTipoFactura = @IDTipoFactura, NumComprobante =@NumComprobante ,Descuentos =@Descuentos ,Subtotal =@Subtotal,total=@total,Observaciones = @Observaciones, condicionIVA = @condicionIVA,IIBB = @IIBB, IdEmpleado = @IdEmpleado,IdFormaPago =@IdFormaPago WHERE IDCompra = @IDCompra");
                datos.setearParametro("@IDProveedor", modificado.IDProveedor);
                datos.setearParametro("@IDTipoFactura", modificado.IDTipoFactura);
                datos.setearParametro("@NumComprobante", modificado.NumComprobante);
                datos.setearParametro("@Descuentos", modificado.Descuentos);
                datos.setearParametro("@Subtotal", modificado.Subtotal);
                datos.setearParametro("@total", modificado.Total);
                datos.setearParametro("@Observaciones", modificado.Observaciones);
                datos.setearParametro("@condicionIVA", modificado.CondicionIVA);
                datos.setearParametro("@IIBB", modificado.IIBB);
                datos.setearParametro("@IdEmpleados", modificado.IDEmpleado);
                datos.setearParametro("@IdFormaPago", modificado.IDFormaPago);
                datos.ejecutarAccion();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

       
    }
}
