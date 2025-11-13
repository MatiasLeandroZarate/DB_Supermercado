<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="PageModificarPRO.aspx.cs" Inherits="TP_Supermercado_WF.ABM_Proveedores.PageModificarPRO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container text-center">
        <h1 class="text-primary ">Modificar Proveedor </h1>
    </div>

    <hr />

    <div class="container">
        <div>
            <div class="row mb-3">
                <label for="txtIdProveedor" class="col-sm-2 col-form-label">ID Proveedor:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtIdProveedor" runat="server" CssClass="form-control" TextMode="Number" AutoPostBack="true" OnTextChanged="txtIdProveedor_TextChanged" />
                </div>
            </div>

            <div class="row mb-3">
                <label for="txtRazonSocial" class="col-sm-2 col-form-label">Razon Social:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mb-3">
                <label for="txtCuit" class="col-sm-2 col-form-label">Cuit:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtCuit" runat="server" CssClass="form-control"  Rows="1" />
                </div>
            </div>

            <div class="row mb-3">
                <label for="txtTelefono" class="col-sm-2 col-form-label">Telefono:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" TextMode="Number" />
                </div>
            </div>


            <div class="row mb-3">
                <label for="txtEmail" class="col-sm-2 col-form-label">Email:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                </div>
            </div>
            <div class="row mb-3">
                <label for="txtDireccion" class="col-sm-2 col-form-label">Direccion:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>

        <div class="text-center">
            <asp:Button Text="Volver" ID="btnVolver" OnClick="btnVolver_Click" CssClass="btn btn-primary mx-2" runat="server" />
            <asp:Button Text="Modificar" ID="btnModificar" OnClick="btnModificar_Click" CssClass="btn btn-primary mx-2" runat="server" />
        </div>
    </div>
</asp:Content>
