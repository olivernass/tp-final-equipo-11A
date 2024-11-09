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
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarProveedor"
                data-id="<%= producto.Id %>" onclick="guardarIdProductoEnModal(this)">
                Agregar Proveedor
            </button>
        </div>
    </div>

    <!-- Modal de agregar proveedor -->
    <div class="modal fade" id="modalAgregarProveedor" tabindex="-1" aria-labelledby="modalAgregarProveedorLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarProveedorLabel">Agregar Proveedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Aquí puedes tener otros campos para agregar proveedor -->
                    <asp:DropDownList ID="ddlProveedorNuevo" runat="server" CssClass="form-control mb-2">
                    </asp:DropDownList>
                    <!-- Campo oculto para almacenar el ID del producto -->
                    <asp:HiddenField ID="hfIdProducto" runat="server" />
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <!-- Botón para guardar el proveedor y usar el ID del producto -->
                <asp:Button ID="btnGuardarProveedor" runat="server" CssClass="btn btn-primary" Text="Guardar proveedor"
                    OnClientClick="return guardarIdProductoEnModal();"
                    OnClick="btnGuardarProveedor_Click" />
                </div>
            </div>
        </div>
    </div>

    <script>
            function guardarIdProductoEnModal(button) {
                // Obtener el ID del producto desde el atributo data-id
                var idProducto = button.getAttribute('data-id');

                // Establecer el valor en un campo oculto en el modal (si lo prefieres)
                document.getElementById('<%= hfIdProducto.ClientID %>').value = idProducto;
            }
    </script>
</asp:Content>
