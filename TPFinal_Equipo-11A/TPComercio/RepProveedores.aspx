<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RepProveedores.aspx.cs" Inherits="TPComercio.RepProveedores" %>

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
        <asp:Label runat="server" ID="lblProveedorConMasProductos"></asp:Label>
        <asp:Label runat="server" ID="lblProveedorConMasProductosID"></asp:Label>
        <asp:Label runat="server" ID="lblReporteProveedores"></asp:Label>
        <asp:Label runat="server" ID="lblProveedoresSinProductos"></asp:Label>
        <asp:Label runat="server" ID="lblProveedoresProductosBajoStock"></asp:Label>
        <asp:Label runat="server" ID="lblProveedoresActivosInactivos"></asp:Label>
    </div>



</asp:Content>
