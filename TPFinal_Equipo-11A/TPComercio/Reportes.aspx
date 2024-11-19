<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="TPComercio.Reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar position-fixed">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="RepMarcas.aspx">Marcas
                </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepCategorias.aspx">Categorías
                </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepProveedores.aspx">Proveedores
                </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepClientes.aspx">Clientes
                </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepProductos.aspx">Productos
                </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepVentas.aspx">Ventas
                </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepCompras.aspx">Compras
                </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

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

    <div class="containerProductos">
        <asp:Label runat="server" ID="lblProductosMasCaros"></asp:Label>
    </div>

    <div class="containerProductos">
        <asp:Label runat="server" ID="lblProductosConProveedores"></asp:Label>
    </div>

    <div class="containerProductos">
        <asp:Label runat="server" ID="lblProductosBajoStock"></asp:Label>
    </div>
    <div class="containerProductos">
        <asp:Label runat="server" ID="lblProductosSinStock"></asp:Label>
    </div>
    <div class="containerProductos">
        <asp:Label runat="server" ID="lblProductosMasRentables"></asp:Label>
    </div>
    <div class="containerProductos">
        <asp:Label runat="server" ID="lblProductosConProveedoresExclusivos"></asp:Label>
    </div>

    <div class="containerProductos">
        <asp:Label runat="server" ID="lblProductosPrecioBajo"></asp:Label>
    </div>


</asp:Content>
