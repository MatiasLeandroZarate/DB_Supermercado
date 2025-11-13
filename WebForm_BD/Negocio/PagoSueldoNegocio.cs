using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class PagoSueldosNegocio
    {
        public List<PagoSueldos> ListarPagoSueldos()
        {
            List<PagoSueldos> lista = new List<PagoSueldos>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IdSueldo, IdEmpleado, FechaPago, Periodo, MontoPagado, MetodoPago FROM PagoSueldos");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    PagoSueldos aux = new PagoSueldos();

                    aux.IdSueldo = (int)datos.Lector["IdSueldo"];
                    aux.IdEmpleado = (int)datos.Lector["IdEmpleado"];
                    aux.FechaPago = (DateTime)datos.Lector["FechaPago"];
                    aux.Periodo = (string)datos.Lector["Periodo"];
                    aux.MontoPagado = (decimal)datos.Lector["MotoPagado"];
                    aux.MetodoPago = (string)datos.Lector["MetodoPago"];

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

        public void Agregar(PagoSueldos nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO PagoSueldos (IdEmpleado,Periodo,MontoPagado,MetodoPago) VALUES (@IdEmpleado,@Periodo,@MontoPagado,@MetodoPago)");
                datos.setearParametro("@IdEmpleado", nuevo.IdEmpleado);
                datos.setearParametro("@Periodo", nuevo.Periodo);
                datos.setearParametro("@MotoPagado", nuevo.MontoPagado);
                datos.setearParametro("@MetodoPago", nuevo.MetodoPago);
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

