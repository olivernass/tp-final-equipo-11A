﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="TPComercio.Reportes" %>

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
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        <h1>Reportes</h1>
        <p>Aquí puedes navegar por los distintos reportes.</p>
    </main>


</asp:Content>
