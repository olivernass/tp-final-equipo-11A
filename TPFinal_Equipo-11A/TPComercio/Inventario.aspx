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
        <table class="tableProductos">
            <thead>
               <tr>           
                  <th scope="col">ID</th>
                  <th scope="col">Nombre</th>
                  <th scope="col">Descripción</th>
                  <th scope="col">Activo</th>
               </tr>
            </thead>
            <tbody>
             <asp:Repeater ID="rptProductos" runat="server" OnItemCommand="rptProductos_ItemCommand"> 
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Id") %></td>
                            <td><%# Eval("Nombre") %></td>
                            <td><%# Eval("Descripcion") %></td>
                            <td><%# Eval("Activo") %></td>
                            <td>
                                <!-- DIRIGIRSE A VER DETALLE DONDE TE MUESTRA TAMBIEN LOS PROVEEDORES -->
                                <button type="button" class="btn btn-acciones btn-sm">
                                    <img src="Content/Iconos/settings.png" alt="Detalle">
                                </button>
                                <!-- Botón Inactivar -->
                                <asp:Button ID="btnInactivar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Inactivar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas inactivar este Producto?');"
                                    CommandName="Inactivar" CommandArgument='<%# Eval("Id") %>' />

                                <!-- Se deben bloquear uno o el otro al momento de estar ya inactivos o activos -->

                                <!-- Botón Activar -->
                                <asp:Button ID="btnActivar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Activar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas activar este Producto?');"
                                    CommandName="Activar" CommandArgument='<%# Eval("Id") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</asp:Content>
