using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP_Supermercado_WF.SP_Reportes
{
    public partial class GastosEnSueldos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReporteNegocio negocio = new ReporteNegocio();
            List<Reporte> lista = new List<Reporte>();
            if (!IsPostBack)
            {
                try
                {
                    rptREPPagoSueldo.DataSource = negocio.ListarReporteSUEL();
                    rptREPPagoSueldo.DataBind();


                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex);
                    Response.Redirect("../Error.aspx");
                }
            }
        }
    }
}