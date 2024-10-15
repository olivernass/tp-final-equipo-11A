<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPComercio.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <div class="col">
            <button type="button" class="btn btn-light">
                <img src="Content/Iconos/barcode.png" alt="Compras">
                <div>Compras</div>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-light">
                <img src="Content/Iconos/ecommerce.png" alt="Ventas">
                <div>Ventas</div>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-light" onclick="window.location.href='Marcas.aspx';">
                <img src="Content/Iconos/shipping.png" alt="Marcas">
                <div>Marcas</div>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-light">
                <img src="Content/Iconos/warehouse.png" alt="Inventario">
                <div>Inventario</div>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-light">
                <img src="Content/Iconos/usuario.png" alt="Usuarios">
                <div>Usuarios</div>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-light">
                <img src="Content/Iconos/ecommerce.png" alt="Clientes">
                <div>Clientes</div>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-light">
                <img src="Content/Iconos/delivery-courier.png" alt="Proveedores">
                <div>Proveedores</div>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-light">
                <img src="Content/Iconos/bar-chart.png" alt="Balances">
                <div>Reportes</div>
            </button>
        </div>

    </div>

</asp:Content>
