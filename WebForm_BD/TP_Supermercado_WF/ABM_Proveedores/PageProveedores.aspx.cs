using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP_Supermercado_WF.ABM_Proveedores
{
    public partial class PageProveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ProveedoresNegocio negocio = new ProveedoresNegocio();
            List<Proveedores> lista = new List<Proveedores>();
            if (!IsPostBack)
            {
                try
                {
                    lista = negocio.ListarProveedores();

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
            Response.Redirect("PageAgregarPRO.aspx", false);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageModificarPRO.aspx", false);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageEliminarPRO.aspx", false);
        }
    }
}