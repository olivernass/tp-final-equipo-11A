<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RepProductos.aspx.cs" Inherits="TPComercio.RepProductos" %>

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
                            <a class="nav-link" href="RepClientes.aspx">Clientes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepProductos.aspx">Productos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepProveedores.aspx">Proveedores
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <div class="reporteClientes">
        <asp:Label runat="server" ID="lblProductosMasCaros"></asp:Label>
        <asp:Label runat="server" ID="lblProductosConProveedores"></asp:Label>
        <%--<asp:Label runat="server" ID="lblProductosBajoStock"></asp:Label>--%>
        <asp:Label runat="server" ID="lblProductosSinStock"></asp:Label>
        <asp:Label runat="server" ID="lblProductosMasRentables"></asp:Label>
        <asp:Label runat="server" ID="lblProductosConProveedoresExclusivos"></asp:Label>
        <asp:Label runat="server" ID="lblProductosPrecioBajo"></asp:Label>
    </div>

</asp:Content>
