using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class TiposFacturasNegocio
    {
        public List<TiposFacturas> ListarTiposFacturas()
        {
            List<TiposFacturas> lista = new List<TiposFacturas>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT idTipoFactura, Descripcion FROM TiposFacturas");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    TiposFacturas aux = new TiposFacturas();

                    aux.IdTipoFactura= (int)datos.Lector["idTiposFacturas"];
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

        public void Agregar(TiposFacturas nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO TiposFacturas (Descripcion) VALUES (@Descripcion)");
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

        public void Modificar(TiposFacturas modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE TiposFacturas SET Descripcion= @Descripcion WHERE idTiposFacturas = @idTiposFacturas");
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

