using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class CargosNegocio
    {
        public List<Cargos> ListarCargos()
        {
            List<Cargos> lista = new List<Cargos>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IDCargo, Nombre FROM Cargos");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Cargos aux = new Cargos();

                    aux.IdCargo = (int)datos.Lector["IDCargo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];

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

        public void Agregar(Cargos nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO Cargos (Nombre) VALUES (@Nombre)");
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

        public void Modificar(Cargos modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE Cargos SET Nombre = @Nombre WHERE IDCargo = @IDCargo");
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

    }
}
