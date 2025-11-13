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
    public partial class PageEliminarPRO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }

        }
        protected void txtIdProveedores_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIdProveedores.Text))
            {
                return;
            }
            var pro = ProveedorEncontrado(txtIdProveedores.Text);


        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageProveedores.aspx", false);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            ProveedoresNegocio negocio = new ProveedoresNegocio();

            try
            {
                negocio.Eliminar(int.Parse(txtIdProveedores.Text));
                Response.Redirect("PageProveedores.aspx", false);
            }
            catch (Exception)
            {

                throw;
            }

        }
        public Proveedores ProveedorEncontrado(string IdProveedor)
        {
            AccesoBD datos = new AccesoBD();
            try
            {
                datos.setearQuery("SELECT IdProveedor FROM Proveedores");
                datos.setearParametro("@IdProveedor", IdProveedor);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    var a = new Proveedores();

                    a.IdProveedor = Convert.ToInt32(datos.Lector["IdProveedor"]);
                    
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