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
    public partial class PageModificarPRO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }
        protected void txtIdProveedor_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIdProveedor.Text))
            {
                return;
            }

            var pro = ProveedorEncontrado(txtIdProveedor.Text);

            if (pro == null)
            {
                LimpiarFormulario();
                return;
            }

            txtRazonSocial.Text = pro.RazonSocial ?? string.Empty;
            txtCuit.Text = pro.Cuit ?? string.Empty;
            txtTelefono.Text = pro.Telefono ?? string.Empty;
            txtEmail.Text = pro.Email ?? string.Empty;
            txtDireccion.Text = pro.Direccion ?? string.Empty;


            
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageProveedores.aspx", false);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Proveedores modificado = new Proveedores();
            ProveedoresNegocio negocio = new ProveedoresNegocio();

            try
            {
                modificado.IdProveedor = int.Parse(txtIdProveedor.Text);
                modificado.RazonSocial = txtRazonSocial.Text;
                modificado.Cuit = txtCuit.Text;
                modificado.Telefono = txtTelefono.Text;
                modificado.Email = txtEmail.Text;
                modificado.Direccion = txtDireccion.Text;
                

                negocio.Modificar(modificado);
                Response.Redirect("PageProveedores.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx");
            }
        }

        public Proveedores ProveedorEncontrado(string IdProveedor)
        {
            AccesoBD datos = new AccesoBD();
            try
            {
                datos.setearQuery("SELECT IdProveedor, RazonSocial, Cuit,Telefono,  Email, Direccion  FROM Proveedores WHERE IdProveedor = @IdProveedor");
                datos.setearParametro("@IdProveedor", IdProveedor);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    var a = new Proveedores();

                    a.IdProveedor = Convert.ToInt32(datos.Lector["IdProveedor"]);
                    a.RazonSocial = datos.Lector["RazonSocial"] == DBNull.Value ? string.Empty : (string)datos.Lector["RazonSocial"];
                    a.Cuit = datos.Lector["Cuit"] == DBNull.Value ? string.Empty : (string)datos.Lector["Cuit"];
                    a.Telefono = datos.Lector["Telefono"] == DBNull.Value ? string.Empty : (string)(datos.Lector["Telefono"]);
                    a.Email = datos.Lector["Email"] == DBNull.Value ? string.Empty : (string)(datos.Lector["Email"]);
                    a.Direccion = datos.Lector["Direccion"] == DBNull.Value ? string.Empty : (string)(datos.Lector["Direccion"]);

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

            txtIdProveedor.Text = "";
            txtRazonSocial.Text = "";
            txtCuit.Text = "";
            txtTelefono.Text = "";
            txtEmail.Text = "";
            txtDireccion.Text = "";
        }
    }
}