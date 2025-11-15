<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="ComprasPorProveedor.aspx.cs" Inherits="TP_Supermercado_WF.SP_Reportes.ComprasPorProveedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container text-center">
        <h1 class="text-primary ">Compras por Proveedor </h1>
    </div>
    <div class="container">
        <table class="table table-hover table-sm table-bordered border-primary-subtle">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Razon Social</th>
                    <th scope="col">Cantidad Compras</th>
                    <th scope="col">Total Comprado</th>
                    <th scope="col">Ultima Compra</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptREPComprasPro" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("IDProveedor") %></th>
                            <td><%# Eval("RazonSocial") %></td>
                            <td><%# Eval("CantidadComprasPRO") %></td>
                            <td><%# Eval("TotalComprado", "{0:C}") %></td>
                            <td><%# Eval("UltimaCompraPRO", "{0:dd/MM/yyyy HH:mm:ss}") %></td>
                        </tr>

                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</asp:Content>

