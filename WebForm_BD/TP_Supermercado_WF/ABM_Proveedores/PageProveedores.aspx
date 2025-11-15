<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="PageProveedores.aspx.cs" Inherits="TP_Supermercado_WF.ABM_Proveedores.PageProveedores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center">
    <h1 class="text-primary ">Lista de Proveedores </h1>
</div>
<div class="container">
    <table class="table table-hover table-sm table-bordered border-primary-subtle">
        <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Razon Social</th>
                <th scope="col">Cuit</th>
                <th scope="col">Telefono</th>
                <th scope="col">Email</th>
                <th scope="col">Direccion</th>
                <th scope="col">Fecha Alta</th>
                <th scope="col">Fecha Ult Mod</th>
                <th scope="col">Activo</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptAriculos" runat="server">
                <ItemTemplate>
                    <tr>
                        <th scope="row"><%# Eval("IDProveedor") %></th>
                        <td><%# Eval("RazonSocial") %></td>
                        <td><%# Eval("Cuit") %></td>
                        <td><%# Eval("Telefono") %></td>
                        <td><%# Eval("Email") %></td>
                        <td><%# Eval("Direccion") %></td>
                        <td><%# Eval("FechaAlta") %></td>
                        <td><%# Eval("FechaUltimaModificacion") %></td>
                        <td><%# Eval("Activo") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
    <div class="text-center">
        <asp:Button Text="Agregar" ID="btnAgregar" OnClick="btnAgregar_Click" CssClass="btn btn-primary mx-2" runat="server" />
        <asp:Button Text="Modificar" ID="btnModificar" OnClick="btnModificar_Click" CssClass="btn btn-primary mx-2" runat="server" />
        <asp:Button Text="Eliminar" ID="btnEliminar" OnClick="btnEliminar_Click" CssClass="btn btn-primary mx-2" runat="server" />
    </div>
</div>
</asp:Content>
