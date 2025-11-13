using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP_Supermercado_WF.ABM_Articulos
{
    public partial class PageEliminarART : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }
    

    protected void txtIdArticulo_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIdArticulo.Text))
            {
                return;
            }

            var art = ArticuloEncontrado(txtIdArticulo.Text);

        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageArticulos.aspx", false);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            ArticulosNegocio negocio = new ArticulosNegocio();

            try
            {
                negocio.Eliminar(int.Parse(txtIdArticulo.Text), false);
                Response.Redirect("PageArticulos.aspx", false);
            }
            catch (Exception)
            {

                throw;
            }

        }



        public Articulos ArticuloEncontrado(string IdArticulo)
        {
            AccesoBD datos = new AccesoBD();
            try
            {
                datos.setearQuery("SELECT IDArticulo, Nombre, Descripcion, Precio, Stock, IDCategoria, Activo  FROM Articulos");
                datos.setearParametro("@IDArticulo", IdArticulo);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    var a = new Articulos();

                    a.IdArticulo = Convert.ToInt32(datos.Lector["IDArticulo"]);
                    a.Nombre = datos.Lector["Nombre"] == DBNull.Value ? string.Empty : (string)datos.Lector["Nombre"];
                    a.Descripcion = datos.Lector["Descripcion"] == DBNull.Value ? string.Empty : (string)datos.Lector["Descripcion"];
                    a.Precio = datos.Lector["Precio"] == DBNull.Value ? 0m : Convert.ToDecimal(datos.Lector["Precio"]);
                    a.Stock = datos.Lector["Stock"] == DBNull.Value ? 0 : Convert.ToInt32(datos.Lector["Stock"]);
                    a.IDCategoria = datos.Lector["IDCategoria"] == DBNull.Value ? 0 : Convert.ToInt32(datos.Lector["IDCategoria"]);

                    return a;
                }
                else
                {
                    return null;
                }
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

