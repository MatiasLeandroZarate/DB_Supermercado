using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class TiposMovimientosNegocio
    {
        public List<TiposMovimientos> ListarTiposMovimientos()
        {
            List<TiposMovimientos> lista = new List<TiposMovimientos>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT idTipoMovimiento, Descripcion FROM TiposMovimientos");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    TiposMovimientos aux = new TiposMovimientos();

                    aux.IdTipoMovimientos = (int)datos.Lector["idTiposMovimientos"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];

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

        public void Agregar(TiposMovimientos nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO TiposMovimientos (Descripcion) VALUES (@Descripcion)");
                datos.setearParametro("@Descripcion", nuevo.Descripcion);
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

        public void Modificar(TiposMovimientos modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE TiposMovimientos SET Descripcion= @Descripcion WHERE idTiposMovimientos = @idTiposMovimientos");
                datos.setearParametro("@Descripcion", modificado.Descripcion);
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
