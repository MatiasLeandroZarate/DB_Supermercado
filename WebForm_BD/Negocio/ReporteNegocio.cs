using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ReporteNegocio
    {
        public List<Reporte> ListarReporteCLI()
        {
            List<Reporte> lista = new List<Reporte>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearStoreProcedure("sp_ReporteGeneral");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Reporte aux = new Reporte();

                    aux.IDCliente = (int)datos.Lector["IdCliente"];
                    aux.ApellidoNombre = (string)datos.Lector["Cliente"];
                    aux.CantidadVentas = (int)datos.Lector["CantidadVentas"];
                    aux.TotalFacturado = (decimal)datos.Lector["TotalFacturado"];
                    aux.UltimaCompraCLI = (DateTime)datos.Lector["UltimaCompra"];


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

        public List<Reporte> ListarReportePRO()
        {
            List<Reporte> lista = new List<Reporte>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearStoreProcedure("sp_ReporteGeneral");
                datos.ejecutarLectura();
                datos.Lector.NextResult();

                while (datos.Lector.Read())
                {
                    Reporte aux = new Reporte();

                    aux.IdProveedor = (int)datos.Lector["IdProveedor"];
                    aux.RazonSocial = (string)datos.Lector["Proveedor"];
                    aux.CantidadComprasPRO = (int)datos.Lector["CantidadCompras"];
                    aux.TotalComprado = (decimal)datos.Lector["TotalComprado"];
                    aux.UltimaCompraPRO = (DateTime)datos.Lector["UltimaCompra"];


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
        public List<Reporte> ListarReporteSUEL()
        {
            List<Reporte> lista = new List<Reporte>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearStoreProcedure("sp_ReporteGeneral");
                datos.ejecutarLectura();
                datos.Lector.NextResult();
                datos.Lector.NextResult();

                while (datos.Lector.Read())
                {
                    Reporte aux = new Reporte();

                    aux.IdEmpleado = (int)datos.Lector["IdEmpleado"];
                    aux.Empleado = (string)datos.Lector["Empleado"];
                    aux.TotalPagado = (decimal)datos.Lector["TotalPagado"];
                    aux.UltimoPago = (DateTime)datos.Lector["UltimoPago"];


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
        public List<Reporte> ListarReporteSTOCK()
        {
            List<Reporte> lista = new List<Reporte>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearStoreProcedure("sp_ReporteGeneral");
                datos.ejecutarLectura();
                datos.Lector.NextResult();
                datos.Lector.NextResult();
                datos.Lector.NextResult();

                while (datos.Lector.Read())
                {
                    Reporte aux = new Reporte();

                    aux.IdArticulo = (int)datos.Lector["IdArticulo"];
                    aux.Articulo = (string)datos.Lector["Articulo"];
                    aux.Stock = (int)datos.Lector["stock"];
                    aux.Precio = (decimal)datos.Lector["precio"];
                    aux.ValorInventario = (decimal)datos.Lector["valorinventario"];
                    aux.Categoria = (string)datos.Lector["Categoria"];


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

        public List<Reporte> ListarReporteMOVI()
        {
            List<Reporte> lista = new List<Reporte>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearStoreProcedure("sp_ReporteGeneral");
                datos.ejecutarLectura();
                datos.Lector.NextResult();
                datos.Lector.NextResult();
                datos.Lector.NextResult();
                datos.Lector.NextResult();

                while (datos.Lector.Read())
                {
                    Reporte aux = new Reporte();

                    aux.IdMovimientoART = (int)datos.Lector["IdMovimientoART"];
                    aux.FechaMovimiento = (DateTime)datos.Lector["FechaMovimiento"];
                    aux.TipoMovimiento = (string)datos.Lector["TipoMovimiento"];
                    aux.Articulo = (string)datos.Lector["Articulo"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.PrecioVenta = (decimal)datos.Lector["PrecioVenta"];


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
    }
}
