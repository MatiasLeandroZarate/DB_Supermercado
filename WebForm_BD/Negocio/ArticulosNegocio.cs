using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ArticulosNegocio
    {
        public List<Articulos> ListarArticulos()
        {
            List<Articulos> lista = new List<Articulos>();

            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("SELECT IDArticulo, Nombre, Descripcion, Precio, Stock, IDCategoria, Activo  FROM Articulos");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Articulos aux = new Articulos();

                    aux.IdArticulo = (int)datos.Lector["IDArticulo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"]: "-";
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.Stock = (int)datos.Lector["Stock"];
                    aux.IDCategoria = (int)datos.Lector["IDCategoria"];
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

        public void Agregar(Articulos nuevo)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("INSERT INTO Articulos (Nombre, Descripcion, Precio, Stock, IDCategoria, Activo) VALUES (@Nombre, @Descripcion, @Precio, @Stock,@IDCategoria, @Activo)");
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Descripcion", nuevo.Descripcion);
                datos.setearParametro("@Precio", nuevo.Precio);
                datos.setearParametro("@Stock", nuevo.Stock);
                datos.setearParametro("@IDCategoria", nuevo.IDCategoria);
                datos.setearParametro("@Activo", 1);
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

        public void Modificar(Articulos modificado)
        {
            AccesoBD datos = new AccesoBD();

            try
            {
                datos.setearQuery("UPDATE Articulos SET Nombre = @Nombre, Descripcion = @Descripcion, Precio = @Precio, Stock = @Stock, IDCategoria = @IDCategoria, Activo = @Activo WHERE IDArticulo = @IDArticulo");
                datos.setearParametro("@Nombre", modificado.Nombre);
                datos.setearParametro("@Descripcion", modificado.Descripcion);
                datos.setearParametro("@Precio", modificado.Precio);
                datos.setearParametro("@Stock", modificado.Stock);
                datos.setearParametro("@IDCategoria", modificado.IDCategoria);
                datos.setearParametro("@Activo", modificado.Activo);
                datos.setearParametro("@IDArticulo", modificado.IdArticulo);
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
                datos.setearQuery("UPDATE Articulos SET Activo = @Activo WHERE IDArticulo = @IDArticulo");
                datos.setearParametro("@Activo", Estado);
                datos.setearParametro("@IDArticulo", Id);
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
