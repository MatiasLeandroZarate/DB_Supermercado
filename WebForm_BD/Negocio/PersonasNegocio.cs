using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class PersonasNegocio
    {
       public List<Personas> ListarPersonas()
            {
                List<Personas> lista = new List<Personas>();

                AccesoBD datos = new AccesoBD();

                try
                {
                    datos.setearQuery("SELECT idPersona, DNI, Apellido, Nombre, Direccion, Email,Telefono, Activo , FechaAlta, FechaUltimaModificacion, Cuit FROM Personas");
                    datos.ejecutarLectura();
                    while (datos.Lector.Read())
                    {
                        Personas aux = new Personas();

                        aux.IdPersona = (int)datos.Lector["idPersona"];
                        aux.DNI = (string)datos.Lector["DNI"];
                        aux.Apellido = (string)datos.Lector["Apellido"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Direccion = (string)datos.Lector["Direccion"];
                        aux.Email = (string)datos.Lector["Email"];
                        aux.Telefono = (string)datos.Lector["Telefono"];
                        aux.Activo = (bool)datos.Lector["Activo"];
                        aux.FechaAlta= (DateTime)datos.Lector["FechaAlta"];
                        aux.FechaUltimaModificacion = (DateTime)datos.Lector["FechaUltimaModificacion"];
                        aux.Cuit = (string)datos.Lector["Cuit"];

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

            public void Agregar(Personas nuevo)
            {
                AccesoBD datos = new AccesoBD();

                try
                {
                    datos.setearQuery("INSERT INTO Personas (DNI, Apellido, Nombre, Direccion, Email,Telefono,Cuit) VALUES (@DNI, @Apellido, @Nombre, @Direccion, @Email,@Telefono,@Cuit)");
                    datos.setearParametro("@DNI", nuevo.DNI);
                    datos.setearParametro("@Apellido", nuevo.Apellido);
                    datos.setearParametro("@Nombre", nuevo.Nombre);
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

            public void Modificar(Personas modificado)
            {
                AccesoBD datos = new AccesoBD();

                try
                {
                    datos.setearQuery("UPDATE Personas SET DNI= @DNI, Apellido = @Apellido, Nombre = @Nombre, Direccion = @Direccion, Email = @Email,Telefono = @Telefono,Cuit = @Cuit WHERE idPersona = @idPersona");
                datos.setearParametro("@DNI", modificado.DNI);
                datos.setearParametro("@Apellido", modificado.Apellido);
                datos.setearParametro("@Nombre", modificado.Nombre);
                datos.setearParametro("@Direccion", modificado.Direccion);
                datos.setearParametro("@Email", modificado.Email);
                datos.setearParametro("@Telefono", modificado.Telefono);
                datos.setearParametro("@Cuit", modificado.Cuit);
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
                    datos.setearQuery("UPDATE Personas SET Activo = @Activo WHERE idPersona = @idPersona");
                    datos.setearParametro("@Activo", Estado);
                    datos.setearParametro("@idPersona", Id);
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

