<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RepClientes.aspx.cs" Inherits="TPComercio.RepClientes" %>

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
            <ul id="divReporteClientes" class="list-group" runat="server">
                <!-- El contenido del List Group se generará dinámicamente desde el código C# -->
            </ul>
            <ul id="divPromedioAntiguedadClientes" class="list-group" runat="server">
                <!-- Contenido dinámico generado desde el servidor -->
            </ul>
        </div>

        <div class="containerClientes">
            <asp:Label runat="server" ID="lblClientePromedioAntiguedad"></asp:Label>
        </div>

        <div class="primerCliente">
            <ul class="nav me-3">
                <li class="nav-item dropdown">
                    <button class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" type="button" role="button" aria-haspopup="true" aria-expanded="false">
                        Primer cliente
                    </button>
                    <div id="divPrimerCliente" class="dropdown-menu" runat="server">
                        <!-- El contenido se generará dinámicamente desde el código C# -->
                    </div>
                </li>
            </ul>
            <ul class="nav">
                <li class="nav-item dropdown">
                    <button class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" type="button" role="button" aria-haspopup="true" aria-expanded="false">
                        Último cliente
                    </button>
                    <div id="divUltimoCliente" class="dropdown-menu" runat="server">
                        <!-- El contenido se generará dinámicamente desde el código C# -->
                    </div>
                </li>
            </ul>
        </div>

    </asp:Content>
