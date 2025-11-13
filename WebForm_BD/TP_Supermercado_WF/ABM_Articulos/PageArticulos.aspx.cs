using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP_Supermercado_WF
{
    public partial class PageArticulos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArticulosNegocio negocio = new ArticulosNegocio();
            List<Articulos> lista = new List<Articulos>();
            if (!IsPostBack)
            {
                try
                {
                    lista = negocio.ListarArticulos();

                    rptAriculos.DataSource = lista;
                    rptAriculos.DataBind();

                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex);
                    Response.Redirect("Error.aspx");
                }
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageAgregarART.aspx", false);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageModificarART.aspx", false);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageEliminarART.aspx", false);
        }
    }
}