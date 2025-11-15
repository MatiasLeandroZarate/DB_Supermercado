using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class VentasDetallesNegocio
    {
        public List<VentasDetalles> ListarVentasDetalles()
        {
            List<VentasDetalles> lista = new List<VentasDetalles>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IDVentaDetalle, IDArticulo, IDVenta, Cantidad, Fecha, Preciounitario FROM VentasDetalles");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    VentasDetalles aux = new VentasDetalles();

                    aux.IDVentaDetalle = (int)datos.Lector["IDVentaDetalle"];
                    aux.IDArticulo = (int)datos.Lector["IDArticulo"];
                    aux.IdVenta = (int)datos.Lector["IDVenta"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.PrecioUnitario = (decimal)datos.Lector["Preciounitario"];

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

        public void Agregar(VentasDetalles nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO VentasDetalles ( IDArticulo, IDVenta, Cantidad, Fecha, Preciounitario) VALUES (@IDVentaDetalle, @IDArticulo, @IDVenta, @Cantidad, @Fecha, @Preciounitario)");
                datos.setearParametro("@IDArticulo", nuevo.IDArticulo);
                datos.setearParametro("@IDVenta", nuevo.IdVenta);
                datos.setearParametro("@Cantidad", nuevo.Cantidad);
                datos.setearParametro("@Fecha", nuevo.Fecha);
                datos.setearParametro("@Preciounitario", nuevo.PrecioUnitario);
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

        public void Modificar(VentasDetalles modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE VentasDetalles SET VentasDetalles  IDArticulo = @IDArticulo, IDVenta = @IDVenta, Cantidad = @Cantidad, Fecha = @Fecha, Preciounitario = @Preciounitario WHERE IDVentaDetalle = @IDVentaDetalle");
                datos.setearParametro("@IDArticulo", modificado.IDArticulo);
                datos.setearParametro("@IDVenta", modificado.IdVenta);
                datos.setearParametro("@Cantidad", modificado.Cantidad);
                datos.setearParametro("@Fecha", modificado.Fecha);
                datos.setearParametro("@PrecioUnitario", modificado.PrecioUnitario);
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

