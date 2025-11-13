using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class MovimientosArtNegocio
    {
        public List<MovimientosArticulos> ListarMovimientosArticulos()
        {
            List<MovimientosArticulos> lista = new List<MovimientosArticulos>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IdMovimientoArt, FechaMovimiento, IdArticulo, Cantidad, Precio, PrecioVente, IdTipoMovimiento FROM MovimientosArticulos");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    MovimientosArticulos aux = new MovimientosArticulos();

                    aux.IdMovimientoART = (int)datos.Lector["IdMovimientoArt"];
                    aux.FechaMovimiento = (DateTime)datos.Lector["FechaMovimiento"];
                    aux.IdArticulo = (int)datos.Lector["IdArticulo"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.PrecioVenta = (decimal)datos.Lector["PrecioVente"];
                    aux.IdTipoMovimiento = (int)datos.Lector["IdTipoMovimiento"];

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

        public void Agregar(MovimientosArticulos nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO MovimientosArticulos (IdArticulo,Cantidad,Precio,PrecioVente,IdTipoMovimiento) VALUES (@IdArticulo,@Cantidad,@Precio,@PrecioVente,@IdTipoMovimiento)");
                datos.setearParametro("@IdArticulo", nuevo.IdArticulo);
                datos.setearParametro("@Cantidad", nuevo.Cantidad);
                datos.setearParametro("@Precio", nuevo.Precio);
                datos.setearParametro("@Preciovente", nuevo.PrecioVenta);
                datos.setearParametro("@IdTipoMovimiento", nuevo.IdTipoMovimiento);
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

       
    }
}
