﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Inventario.aspx.cs" Inherits="TPComercio.Inventario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containerProductos">
        <h2 class="h2listado">Mantenimiento de Productos</h2>
        <!-- Botón Agregar Producto -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarProducto">
            Agregar Producto    
        </button>
        <!-- Tabla de Productos -->
        <div class="card-container">
            <asp:Repeater ID="rptProductos" runat="server" OnItemCommand="rptProductos_ItemCommand"> 
               <ItemTemplate>
                   <div class="card">
                    <div class="card-header">
                        <h5>ID: <%# Eval("Id") %></h5>
                        <label ></label>
                    </div>
                    <div class="card-body">
                        <h6><%# Eval("Nombre") %></h6>
                        <p><%# Eval("Descripcion") %></p>
                        <p><strong>Stock actual:</strong> <%# Eval("StockActual") %></p>   
                        <p><strong>Estado:</strong> <%# Eval("Activo") %></p>
                        <img src='<%# Eval("Imagen.ImagenUrl") %>' alt="Imagen del producto" width="175px" />     
                    </div>
                    <div class="card-footer">
                        <asp:Button ID="btnConfiguracion" runat="server" CssClass="btn btn-secondary btn-sm" Text="+ Info"
                            CommandName="Configurar" CommandArgument='<%# Eval("Id") %>' />
                        <asp:Button ID="btnInactivar" runat="server" CssClass="btn btn-danger btn-sm" Text="Inactivar"
                            OnClientClick="return confirm('¿Inactivar Producto?');"
                            CommandName="Inactivar" CommandArgument='<%# Eval("Id") %>' />
                        <asp:Button ID="btnActivar" runat="server" CssClass="btn btn-success btn-sm" Text="Activar"
                            OnClientClick="return confirm('¿Activar Producto?');"
                            CommandName="Activar" CommandArgument='<%# Eval("Id") %>' />
                    </div>
                </div>
               </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Modal para agregar producto -->
    <div class="modal fade" id="modalAgregarProducto" tabindex="-1" aria-labelledby="modalAgregarProductoLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarProductoLabel">Agregar Nuevo Producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                
                    <span class="error-message" id="errorNombreProducto"></span>
                    <asp:TextBox ID="txtNombreProducto" runat="server" CssClass="form-control mb-2" placeholder="Nombre del Producto"></asp:TextBox>

                    <span class="error-message" id="errorDescripcionProducto"></span>
                    <asp:TextBox ID="txtDescripcionProducto" runat="server" CssClass="form-control mb-2" placeholder="Descripción del Producto"></asp:TextBox>

                    <span class="error-message" id="errorMarcaProducto"></span>
                    <asp:DropDownList ID="ddlMarcaProducto" runat="server" CssClass="form-control mb-2">
                    </asp:DropDownList>

                    <span class="error-message" id="errorCategoriaProducto"></span>
                    <asp:DropDownList ID="ddlCategoriaProducto" runat="server" CssClass="form-control mb-2">
                    </asp:DropDownList>

                    <span class="error-message" id="errorStockActual"></span>
                    <asp:TextBox ID="txtStockActual" runat="server" CssClass="form-control mb-2" placeholder="Stock Actual" TextMode="Number"></asp:TextBox>

                    <span class="error-message" id="errorStockMinimo"></span>
                    <asp:TextBox ID="txtStockMinimo" runat="server" CssClass="form-control mb-2" placeholder="Stock Mínimo" TextMode="Number"></asp:TextBox>

                    <span class="error-message" id="errorPrecioCompra"></span>
                    <asp:TextBox ID="txtPrecioCompra" runat="server" CssClass="form-control mb-2" placeholder="Precio de Compra"></asp:TextBox>

                    <span class="error-message" id="errorPrecioVenta"></span>
                    <asp:TextBox ID="txtPrecioVenta" runat="server" CssClass="form-control mb-2" placeholder="Precio de Venta"></asp:TextBox>

                    <span class="error-message" id="errorPorcentajeGanancia"></span>
                    <asp:TextBox ID="txtPorcentajeGanancia" runat="server" CssClass="form-control mb-2" placeholder="Porcentaje de Ganancia" TextMode="Number"></asp:TextBox>

                    <span class="error-message" id="errorImagenProducto"></span>
                    <asp:TextBox ID="txtImagenProducto" runat="server" CssClass="form-control mb-2" placeholder="Ingrese el nombre o ruta de la imagen" />
                
                    <span class="error-message" id="errorProveedores"></span>
                    <asp:DropDownList ID="ddlProveedorProducto" runat="server" CssClass="form-control mb-2">
                    </asp:DropDownList>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarProducto');">Cerrar</button>
                    <asp:Button ID="btnGuardarProducto" runat="server" CssClass="btn btn-primary" Text="Guardar Producto" OnClientClick="return validarAgregarProducto();" OnClick="btnGuardarProducto_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Agregar Proveedor -->
    <div class="modal fade" id="modalAgregarProveedor" tabindex="-1" aria-labelledby="modalAgregarProveedorLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarProveedorLabel">Agregar nuevo proveedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                <p><strong>ID del Producto:</strong> <span id="modalProveedorId"></span></p>
                </div>
                <div class="modal-body">
                    <asp:DropDownList ID="ddlProveedorNuevo" runat="server" CssClass="form-control mb-2">
                    </asp:DropDownList>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarProveedor');">Cerrar</button>
                    <asp:HiddenField ID="hfIdProducto" runat="server" />
                    <asp:Button ID="btnGuardarProveedor" runat="server" CssClass="btn btn-primary" Text="Guardar proveedor"
                        OnClientClick="enviarIdProducto(); return validarAgregarProveedor();" OnClick="btnGuardarProveedor_Click" />
                </div>
            </div>
        </div>
    </div>


    <script>
        <%--function mostrarDetalles(button) {
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const descripcion = button.getAttribute('data-descripcion');
            const nombreMarca = button.getAttribute('data-nombreMarca');
            const nombreCategoria = button.getAttribute('data-nombreCategoria');
            const stockMinimo = button.getAttribute('data-stockMinimo');
            const stockActual = button.getAttribute('data-stockActual');
            const precioCompra = button.getAttribute('data-precio_compra');
            const precioVenta = button.getAttribute('data-precio_venta');
            const porcentajeGanancia = button.getAttribute('data-porcentaje_ganancia');
            const estado = button.getAttribute('data-activo') === 'True' ? 'Activo' : 'Inactivo';
            const imagen = button.getAttribute('data-ImagenUrl');

            document.getElementById('modalId').innerText = id;
            document.getElementById('modalNombre').innerText = nombre;
            document.getElementById('modalDescripcion').innerText = descripcion;
            document.getElementById('modalNombreMarca').innerText = nombreMarca;
            document.getElementById('modalNombreCategoria').innerText = nombreCategoria;
            document.getElementById('modalStockMinimo').innerText = stockMinimo;
            document.getElementById('modalStockActual').innerText = stockActual;
            document.getElementById('modalPrecioCompra').innerText = precioCompra;
            document.getElementById('modalPrecioVenta').innerText = precioVenta;
            document.getElementById('modalPorcentajeGanancia').innerText = porcentajeGanancia;
            document.getElementById('modalEstado').innerText = estado;
            document.getElementById('modalImagen').src = imagen;

            var modal = new bootstrap.Modal(document.getElementById('modalProducto'));
            modal.show();
        }

        function enviarIdProducto() {
            const idProducto = document.getElementById('modalId').textContent;
            document.getElementById('<%= hfIdProducto.ClientID %>').value = idProducto;
        }--%>
    </script>
    

</asp:Content>
