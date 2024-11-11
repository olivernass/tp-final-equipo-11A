<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPComercio.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <div class="coldf">
            <button type="button" class="btn btn-light btn-default">
                <img src="Content/Iconos/barcode.png" alt="Compras">
                <div>Compras</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default">
                <img src="Content/Iconos/ecommerce.png" alt="Ventas">
                <div>Ventas</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Marcas.aspx';">
                <img src="Content/Iconos/shipping.png" alt="Marcas">
                <div>Marcas</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Inventario.aspx';">
                <img src="Content/Iconos/warehouse.png" alt="Inventario">
                <div>Inventario</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Usuarios.aspx';">
                <img src="Content/Iconos/usuario.png" alt="Usuarios">
                <div>Usuarios</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Clientes.aspx';">
                <img src="Content/Iconos/ecommerce.png" alt="Clientes">
                <div>Clientes</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Proveedores.aspx';">
                <img src="Content/Iconos/delivery-courier.png" alt="Proveedores">
                <div>Proveedores</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Reportes.aspx';">
                <img src="Content/Iconos/bar-chart.png" alt="Balances">
                <div>Reportes</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Categorias.aspx';">
                <img src="Content/Iconos/categorias.png" alt="Categorias">
                <div>Categorias</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Admin.aspx';">
                <img src="Content/Iconos/admin.png" alt="Admin Panel">
                <div>Admin Panel</div>
            </button>
        </div>

    </div>

</asp:Content>
