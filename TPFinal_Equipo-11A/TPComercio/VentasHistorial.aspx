<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VentasHistorial.aspx.cs" Inherits="TPComercio.VentasHistorial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>

        <div class="containerVolver">
             <h1>Historial de Ventas</h1>
            <asp:Button ID="btnVolver" runat="server" CssClass="btn btn-primary" Text="Volver" OnClick="btnVolver_Click" />
        </div>

        <asp:GridView ID="gvHistorialVentas" runat="server" AutoGenerateColumns="false" CssClass="table">
            <Columns>
                <asp:BoundField DataField="NumeroDocumento" HeaderText="DNI Cliente" />
                <asp:BoundField DataField="NombreCliente" HeaderText="Nombre" />
                <asp:BoundField DataField="ApellidoCliente" HeaderText="Apellido" />
                <asp:BoundField DataField="NumeroFactura" HeaderText="N° Factura" />
                <asp:BoundField DataField="FechaCreacion" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="NombreProducto" HeaderText="Producto" />
                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                <asp:TemplateField HeaderText="Total">
                    <ItemTemplate>
                        <%# Eval("TotalFactura") != null ? string.Format("{0:C}", Eval("TotalFactura")) : "" %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>


    </div>

</asp:Content>
