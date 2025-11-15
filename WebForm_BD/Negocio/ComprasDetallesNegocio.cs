using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ComprasDetallesNegocio
    {
        public List<ComprasDetalles> ListarComprasDetalles()
        {
            List<ComprasDetalles> lista = new List<ComprasDetalles>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IdCompraDetalle, IDArticulo, IDCompra, Cantidad, Fecha, Preciounitario FROM ComprasDetalles");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    ComprasDetalles aux = new ComprasDetalles();

                    aux.IDCompraDetalle = (int)datos.Lector["IdCompraDetalle"];
                    aux.IDArticulo = (int)datos.Lector["IDArticulo"];
                    aux.IDCompra = (int)datos.Lector["IDCompra"];
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

        public void Agregar(ComprasDetalles nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO ComprasDetalles ( IDArticulo, IDCompra, Cantidad, Fecha, Preciounitario) VALUES (@IdCompraDetalle, @IDArticulo, @IDCompra, @Cantidad, @Fecha, @Preciounitario)");
                datos.setearParametro("@IDArticulo", nuevo.IDArticulo);
                datos.setearParametro("@IDCompra", nuevo.IDCompra);
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

        public void Modificar(ComprasDetalles modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE ComprasDetalles SET ComprasDetalles  IDArticulo = @IDArticulo, IDCompra = @IDCompra, Cantidad = @Cantidad, Fecha = @Fecha, Preciounitario = @Preciounitario WHERE IdCompraDetalle = @IdCompraDetalle");
                datos.setearParametro("@IDArticulo", modificado.IDArticulo);
                datos.setearParametro("@IDCompra", modificado.IDCompra);
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
