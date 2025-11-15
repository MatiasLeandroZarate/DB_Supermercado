<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="PageEliminarART.aspx.cs" Inherits="TP_Supermercado_WF.ABM_Articulos.PageEliminarART" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center">
        <h1 class="text-primary ">Eliminar Artículo </h1>
    </div>

    <hr />

    <div class="container">
        <div>
            <div class="row mb-3">
                <label for="txtIdArticulo" class="col-sm-2 col-form-label">ID Artículo:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtIdArticulo" runat="server" CssClass="form-control" TextMode="Number" AutoPostBack="true" OnTextChanged="txtIdArticulo_TextChanged" />
                </div>
            </div>


            <div class="text-center">
                <asp:Button Text="Volver" ID="btnVolver" OnClick="btnVolver_Click" CssClass="btn btn-primary mx-2" runat="server" />
                <asp:Button Text="Eliminar" ID="btnEliminar" OnClick="btnEliminar_Click" CssClass="btn btn-primary mx-2" runat="server" />
            </div>
        </div>
    </div>

</asp:Content>
