using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class FormasPagosNegocio
    {
        public List<FormasPagos> ListarFormasPagos()
        {
            List<FormasPagos> lista = new List<FormasPagos>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IdFormaPago, Nombre ,Activo FROM FormasPagos");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    FormasPagos aux = new FormasPagos();

                    aux.IdFormaPago = (int)datos.Lector["IdFormaPago"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Activo = (bool)datos.Lector["Activo"];

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

        public void Agregar(FormasPagos nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO FormasPagos (Nombre) VALUES (@Nombre)");
                datos.setearParametro("@Nombre", nuevo.Nombre);
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

        public void Modificar(FormasPagos modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE FormasPagos SET  WHERE IdFormaPago = @IdFormaPago");
                datos.setearParametro("@Nombre", modificado.Nombre);
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
        public void Eliminar(int Id, bool Estado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE FormasPagos SET Activo = @Activo WHERE IDFormaPago = @IDFormaPago");
                datos.setearParametro("@Activo", Estado);
                datos.setearParametro("@IDFormaPago", Id);
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
