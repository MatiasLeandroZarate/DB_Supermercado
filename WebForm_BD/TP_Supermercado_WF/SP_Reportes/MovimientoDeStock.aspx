<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="MovimientoDeStock.aspx.cs" Inherits="TP_Supermercado_WF.SP_Reportes.MovimientoDeStock" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="container text-center">
    <h1 class="text-primary ">Movimientos de Stock</h1>
</div>
<div class="container">
    <table class="table table-hover table-sm table-bordered border-primary-subtle">
        <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Fecha de Movimiento</th>
                <th scope="col">Tipo de Movimiento</th>
                <th scope="col">Articulo</th>
                <th scope="col">Cantidad</th>
                <th scope="col">Precio</th>
                <th scope="col">Precio Venta</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptREMovimientosART" runat="server">
                <ItemTemplate>
                    <tr>
                        <th scope="row"><%# Eval("IdMovimientoART") %></th>
                        <td><%# Eval("FechaMovimiento") %></td>
                        <td><%# Eval("TipoMovimiento") %></td>
                        <td><%# Eval("Articulo") %></td>
                        <td><%# Eval("Cantidad") %></td>
                        <td><%# Eval("Precio", "{0:C}") %></td>
                        <td><%# Eval("PrecioVenta", "{0:C}") %></td>
                    
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
</div>
</asp:Content>
