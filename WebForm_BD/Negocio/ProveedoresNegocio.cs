using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProveedoresNegocio
    {
        public List<Proveedores> ListarProveedores()
        {
            List<Proveedores> lista = new List<Proveedores>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT idProveedor, RazonSocial, Cuit,Telefono,  Email, Direccion, FechaAlta, FechaUltimaModificacion, Activo FROM Proveedores");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Proveedores aux = new Proveedores();

                    aux.IdProveedor = (int)datos.Lector["idProveedor"];
                    aux.RazonSocial = (string)datos.Lector["RazonSocial"];
                    aux.Cuit = (string)datos.Lector["Cuit"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.FechaAlta = (DateTime)datos.Lector["FechaAlta"];
                    aux.FechaUltimaModificacion = (DateTime)datos.Lector["FechaUltimaModificacion"];
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

        public void Agregar(Proveedores nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO Proveedores (RazonSocial, Direccion, Email,Telefono,Cuit) VALUES (@RazonSocial, @Direccion, @Email,@Telefono,@Cuit)");
                datos.setearParametro("@RazonSocial", nuevo.RazonSocial);
                datos.setearParametro("@Direccion", nuevo.Direccion);
                datos.setearParametro("@Email", nuevo.Email);
                datos.setearParametro("@Telefono", nuevo.Telefono);
                datos.setearParametro("@Cuit", nuevo.Cuit);
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

        public void Modificar(Proveedores modificado)
        {
            AccesoBD datos = new AccesoBD();
          
            try
            {
                datos.setearQuery("UPDATE Proveedores SET RazonSocial= @RazonSocial,Direccion = @Direccion, Email = @Email,Telefono = @Telefono,Cuit = @Cuit WHERE idProveedor = @idProveedor");
                datos.setearParametro("@IdProveedor", modificado.IdProveedor);
                datos.setearParametro("@RazonSocial", modificado.RazonSocial);
                datos.setearParametro("@Cuit", modificado.Cuit);
                datos.setearParametro("@Telefono", modificado.Telefono);
                datos.setearParametro("@Email", modificado.Email);
                datos.setearParametro("@Direccion", modificado.Direccion);
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

        public void Eliminar(int Id)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("DELETE Proveedores WHERE idProveedor = @idProveedor");
                datos.setearParametro("@idProveedor", Id);
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

