<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Inventario.aspx.cs" Inherits="TPComercio.Inventario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containerProductos">
        <h2 class="h2listado">Listado de Productos</h2>
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
                    </div>
                    <div class="card-body">
                        <h6><%# Eval("Nombre") %></h6>
                        <p><%# Eval("Descripcion") %></p>
                        <p><strong>Estado:</strong> <%# Eval("Activo") %></p>
                        <img src='<%# Eval("Imagen.ImagenUrl") %>' alt="Imagen del producto" width="175px" />     
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn btn-secondary btn-sm">
                            <img src="Content/Iconos/settings.png" alt="Detalle">
                        </button>
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
</asp:Content>
