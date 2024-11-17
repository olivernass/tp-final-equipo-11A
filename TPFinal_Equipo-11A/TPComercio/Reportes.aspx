<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="TPComercio.Reportes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerMarcas">
        
        <asp:Label runat="server" ID="lblMarcaNombre"></asp:Label>
        
        <div>
        <asp:Label runat="server" ID="lblMarcaID"></asp:Label>
            </div>
        </div>

            <div class="containerMarcas">
    <asp:Label runat="server" ID="lblReporteMarcas"></asp:Label>
</div>

                <div class="containerMarcas">
    <asp:Label runat="server" ID="lblMarcasSinProductos"></asp:Label>
</div>

                    <div class="containerMarcas">
    <asp:Label runat="server" ID="lblMarcasProductosBajoStock"></asp:Label>
</div>

                    <div class="containerMarcas">
    <asp:Label runat="server" ID="lblMarcasActivasInactivas"></asp:Label>
</div>

    <div class="containerCategorias">
    <asp:Label runat="server" ID="lblCategoriaNombre"></asp:Label>
    <div>
        <asp:Label runat="server" ID="lblCategoriaID"></asp:Label>
    </div>
</div>

        <div class="containerCategorias">
    <asp:Label runat="server" ID="lblReporteCategorias"></asp:Label>
</div>

            <div class="containerCategorias">
    <asp:Label runat="server" ID="lblCategoriasSinProductos"></asp:Label>
</div>

                <div class="containerCategorias">
    <asp:Label runat="server" ID="lblCategoriasProductosBajoStock"></asp:Label>
</div>

                    <div class="containerCategorias">
    <asp:Label runat="server" ID="lblCategoriasActivasInactivas"></asp:Label>
</div>

                <div class="containerProveedores">
    <asp:Label runat="server" ID="lblProveedorConMasProductos"></asp:Label>
                    <div>
<asp:Label runat="server" ID="lblProveedorConMasProductosID"></asp:Label>
    </div>
</div>

                <div class="containerProveedores">
    <asp:Label runat="server" ID="lblReporteProveedores"></asp:Label>
</div>

                    <div class="containerProveedores">
    <asp:Label runat="server" ID="lblProveedoresSinProductos"></asp:Label>
</div>

                        <div class="containerProveedores">
    <asp:Label runat="server" ID="lblProveedoresProductosBajoStock"></asp:Label>
</div>

                            <div class="containerProveedores">
    <asp:Label runat="server" ID="lblProveedoresActivosInactivos"></asp:Label>
</div>

    <div class="containerClientes">
    <asp:Label runat="server" ID="lblClientePrimero"></asp:Label>
</div>

        <div class="containerClientes">
    <asp:Label runat="server" ID="lblClienteUltimo"></asp:Label>
</div>

            <div class="containerClientes">
    <asp:Label runat="server" ID="lblClienteActivosInactivos"></asp:Label>
</div>

    
            <div class="containerClientes">
    <asp:Label runat="server" ID="lblClientePromedioAntiguedad"></asp:Label>
</div>

</asp:Content>
