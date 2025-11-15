<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="PageArticulos.aspx.cs" Inherits="TP_Supermercado_WF.PageArticulos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container text-center">
        <h1 class="text-primary ">Articulos </h1>
    </div>
    <div class="container">
        <table class="table table-hover table-sm table-bordered border-primary-subtle">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Descripción</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Stock</th>
                    <th scope="col">IDCategoria</th>
                    <th scope="col">Activo</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptAriculos" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("IDArticulo") %></th>
                            <td><%# Eval("Nombre") %></td>
                            <td><%# Eval("Descripcion") %></td>
                            <td><%# Eval("Precio") %></td>
                            <td><%# Eval("Stock") %></td>
                            <td><%# Eval("IDCategoria") %></td>
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
