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
    public partial class PageModificarART : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();
            }

        }
        protected void txtIdArticulo_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIdArticulo.Text))
            {
                return;
            }

            var art = ArticuloEncontrado(txtIdArticulo.Text);

            if (art == null)
            {
                LimpiarFormulario();
                return;
            }

            txtNombre.Text = art.Nombre ?? string.Empty;
            txtDescripcion.Text = art.Descripcion ?? string.Empty;
            txtPrecio.Text = art.Precio.ToString("0.###");
            txtStock.Text = art.Stock.ToString();

            

            if (ddlCategoria.Items.FindByValue(art.IDCategoria.ToString()) != null)
            {
                ddlCategoria.SelectedValue = art.IDCategoria.ToString();
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageArticulos.aspx", false);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Articulos modificado = new Articulos();
            ArticulosNegocio negocio = new ArticulosNegocio();

            try
            {
                modificado.IdArticulo = int.Parse(txtIdArticulo.Text);
                modificado.Nombre = txtNombre.Text;
                modificado.Descripcion = txtDescripcion.Text;
                modificado.Precio = string.IsNullOrWhiteSpace(txtPrecio.Text) ? 0 : decimal.Parse(txtPrecio.Text);
                modificado.Stock = int.Parse(txtStock.Text);
                modificado.IDCategoria = int.Parse(ddlCategoria.SelectedValue);
                modificado.Activo = true;

                negocio.Modificar(modificado);
                Response.Redirect("PageArticulos.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx");
            }
        }


        private void CargarCategorias()
        {
            CategoriasNegocio negocio = new CategoriasNegocio();
            ddlCategoria.DataSource = negocio.ListarCategorias();
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "IdCategoria";
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new ListItem("Seleccione una categoría", ""));
        }

        public Articulos ArticuloEncontrado(string IdArticulo)
        {
            AccesoBD datos = new AccesoBD();
            try
            {
                datos.setearQuery("SELECT IDArticulo, Nombre, Descripcion, Precio, Stock,  IDCategoria FROM Articulos WHERE IDArticulo = @IDArticulo");
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
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx");
                return null;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        private void LimpiarFormulario()
        {
            txtNombre.Text = "";
            txtDescripcion.Text = "";
            txtPrecio.Text = "";
            ddlCategoria.ClearSelection();
        }
    }
}