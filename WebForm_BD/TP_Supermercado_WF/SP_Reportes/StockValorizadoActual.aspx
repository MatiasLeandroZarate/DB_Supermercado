<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaster.Master" AutoEventWireup="true" CodeBehind="StockValorizadoActual.aspx.cs" Inherits="TP_Supermercado_WF.SP_Reportes.StockValorizadoActual" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container text-center">
     <h1 class="text-primary ">Stock Valorizado Actual</h1>
 </div>
 <div class="container">
     <table class="table table-hover table-sm table-bordered border-primary-subtle">
         <thead>
             <tr>
                 <th scope="col">ID</th>
                 <th scope="col">Articulo</th>
                 <th scope="col">Stock</th>
                 <th scope="col">Precio</th>
                 <th scope="col">Valor Inventario</th>
                 <th scope="col">Categoria</th>
             </tr>
         </thead>
         <tbody>
             <asp:Repeater ID="rptREPArticulos" runat="server">
                 <ItemTemplate>
                     <tr>
                         <th scope="row"><%# Eval("IdArticulo") %></th>
                         <td><%# Eval("Articulo") %></td>
                         <td><%# Eval("Stock") %></td>
                         <td><%# Eval("Precio", "{0:C}") %></td>
                         <td><%# Eval("ValorInventario") %></td>
                         <td><%# Eval("Categoria") %></td>
                     </tr>
                 </ItemTemplate>
             </asp:Repeater>
         </tbody>
     </table>
 </div>

</asp:Content>
