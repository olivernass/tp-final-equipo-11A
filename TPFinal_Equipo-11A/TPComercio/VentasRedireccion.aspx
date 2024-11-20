<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VentasRedireccion.aspx.cs" Inherits="TPComercio.VentasRedireccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='Ventas.aspx';">
                <img src="Content/Iconos/online-payment.png" alt="Facturar">
                <div>Facturar</div>
            </button>
        </div>
        <div class="coldf">
            <button type="button" class="btn btn-light btn-default" onclick="window.location.href='VentasHistorial.aspx';">
                <img src="Content/Iconos/search.png" alt="Ver historial">
                <div>Ver historial</div>
            </button>
        </div>
    </div>

</asp:Content>
