<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="VentasPorCliente.aspx.cs" Inherits="TP_Supermercado_WF.SP_Reportes.VentasPorCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container text-center">
        <h1 class="text-primary ">Ventas Por Cliente </h1>
    </div>
    <div class="container">
        <table class="table table-hover table-sm table-bordered border-primary-subtle">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Apellido, Nombre</th>
                    <th scope="col">Cantidad Ventas</th>
                    <th scope="col">Total Facturado</th>
                    <th scope="col">Ultima Compra</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptREPCliente" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("IDCliente") %></th>
                            <td><%# Eval("ApellidoNombre") %></td>
                            <td><%# Eval("CantidadVentas") %></td>
                            <td><%# Eval("TotalFacturado", "{0:C}") %></td>
                            <td><%# Eval("UltimaCompraCLI") %></td>

                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</asp:Content>
