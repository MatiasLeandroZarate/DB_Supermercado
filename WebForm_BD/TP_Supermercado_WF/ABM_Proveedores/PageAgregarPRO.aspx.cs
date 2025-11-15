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
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageProveedores.aspx", false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Proveedores nuevo = new Proveedores();
            ProveedoresNegocio negocio = new ProveedoresNegocio();

            try
            {
                nuevo.RazonSocial = txtRazonSocial.Text;
                nuevo.Cuit = txtCuit.Text;
                nuevo.Telefono = txtTelefono.Text;
                nuevo.Email = txtEmail.Text;
                nuevo.Direccion = txtDireccion.Text;
                nuevo.Activo = true;

                negocio.Agregar(nuevo);
                Response.Redirect("PageProveedores.aspx", false);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}