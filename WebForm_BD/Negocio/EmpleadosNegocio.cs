using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class EmpleadosNegocio
    {
        public List<Empleados> ListarEmpleados()
        {
            List<Empleados> lista = new List<Empleados>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IdEmpleado, IDCargo,IdPersona,Antiguedad FROM Empleados");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Empleados aux = new Empleados();

                    aux.IdEmpleados= (int)datos.Lector["IdEmpleado"];
                    aux.IdCargo = (int)datos.Lector["IDCargo"];
                    aux.IdPersona= (int)datos.Lector["IdPersona"];
                    aux.Antiguedad = (int)datos.Lector["Antiguedad"];

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

        public void Agregar(Empleados nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO Empleados (IDCargo,IdPersona, Antiguedad) VALUES (@IDCargo,@IdPersona, @Antiguedad)");
                datos.setearParametro("@IDCargo", nuevo.IdCargo);
                datos.setearParametro("@IdPersona", nuevo.IdPersona);
                datos.setearParametro("@Antiguedad", nuevo.Antiguedad);
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

        public void Modificar(Empleados modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE Empleados SET IDCargo = @IDCargo , IdPersona =@IdPersona, Antiguedad = @Antiguedad WHERE IdEmpleado = @IdEmpleado");
                datos.setearParametro("@IDCargo", modificado.IdCargo);
                datos.setearParametro("@IdPersona", modificado.IdPersona);
                datos.setearParametro("@Antiguedad", modificado.Antiguedad);
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
