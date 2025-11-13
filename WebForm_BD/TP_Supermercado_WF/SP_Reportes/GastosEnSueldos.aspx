<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="GastosEnSueldos.aspx.cs" Inherits="TP_Supermercado_WF.SP_Reportes.GastosEnSueldos" %>

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
                    <th scope="col">Empleado</th>
                    <th scope="col">Total Pagado</th>
                    <th scope="col">Ultimo Pago</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptREPPagoSueldo" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("IdEmpleado") %></th>
                            <td><%# Eval("Empleado") %></td>
                            <td><%# Eval("TotalPagado", "{0:C}") %></td>
                            <td><%# Eval("UltimoPago", "{0:dd/MM/yyyy HH:mm:ss}") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</asp:Content>
