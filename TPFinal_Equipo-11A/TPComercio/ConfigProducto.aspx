<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ConfigProducto.aspx.cs" Inherits="TPComercio.ConfigProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display: flex; flex-direction: row; padding: 20px; font-family: Arial, sans-serif;">
    <!-- Columna de la imagen -->
        <div style="flex: 0 0 auto; margin-right: 20px;">
            <!-- Mostrar imagen del producto -->
            <strong>Imagen del Producto:</strong><br>
            <img src="<%= producto.Imagen.ImagenUrl %>" alt="Imagen del Producto" style="max-width: 300px; height: auto;">
        </div>

    <!-- Columna del contenido (p y dropdown) alineados a la derecha de la imagen -->
        <div style="flex: 1; text-align: left;">
            <h2 style="font-size: 24px; margin-bottom: 15px;">Información del Artículo</h2>

            <p style="font-size: 20px; margin: 5px 0;"><strong>Codigo:</strong> <%= producto.Id %></p>
            <p style="font-size: 18px; margin: 5px 0;"><strong>Título del Artículo:</strong> <%= producto.Nombre %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Descripción:</strong> <%= producto.Descripcion %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Marca:</strong> <%= producto.Marca.NombreMarca %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Categoria:</strong> <%= producto.Categoria.NombreCategoria %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Stock actual:</strong> <%= producto.StockActual %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Stock minimo:</strong> <%= producto.StockMinimo %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Precio compra:</strong> <%= producto.Precio_Compra %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Precio venta:</strong> <%= producto.Precio_Venta %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Porcentaje ganancia:</strong> <%= producto.Porcentaje_Ganancia %></p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Estado:</strong> <%= producto.Activo %></p>

            <h5>Proveedores:</h5>
            <asp:DropDownList ID="ddlProveedorProducto" runat="server" CssClass="form-control mb-2">
            </asp:DropDownList>

             
        </div>
    </div>
</asp:Content>
