﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPComercio.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerClientes">
        <h2 class="h2listado">Listado de Clientes</h2>

        <!-- Botón Agregar Cliente -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarCliente">
            Agregar Cliente       
        </button>

        <!-- Tabla de Clientes -->
        <table class="table tableClientes table-hover mt-3">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">DNI</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Apellido</th>
                    <th scope="col">Direccion</th>
                    <th scope="col">Telefono</th>
                    <th scope="col">Correo</th>
                    <th scope="col">Fecha de Registro</th>
                    <th scope="col" class="acciones">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptClientes" runat="server" OnItemCommand="rptClientes_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("Id") %></th>
                            <td><%# Eval("DNI") %></td>
                            <td><%# Eval("Nombre") %></td>
                            <td><%# Eval("Apellido") %></td>
                            <td><%# Eval("Direccion") %></td>
                            <td><%# Eval("Telefono") %></td>
                            <td><%# Eval("Correo") %></td>
                            <td><%# Eval("Fecha_Alta", "{0:dd/MM/yyyy HH:mm}") %></td>
                            <td>
                                <!-- Botón Modificar -->
                                <button type="button" class="btn btn-info btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarCliente"
                                    onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("DNI") %>', '<%# Eval("Nombre") %>', '<%# Eval("Apellido") %>', '<%# Eval("Direccion") %>', '<%# Eval("Telefono") %>', '<%# Eval("Correo") %>')">
                                    Modificar                           
                                </button>

                                <!-- Botón Eliminar -->
                                <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Eliminar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas eliminar este cliente?');"
                                    CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <!-- Modal Agregar Cliente -->
    <div class="modal fade" id="modalAgregarCliente" tabindex="-1" aria-labelledby="modalAgregarClienteLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarClienteLabel">Agregar Nuevo Cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <span class="error-message" id="errorDNI"></span>
                    <asp:TextBox ID="txtDNICliente" runat="server" CssClass="form-control mb-2 validar-DNI" placeholder="DNI"></asp:TextBox>

                    <span class="error-message" id="errorNombre"></span>
                    <asp:TextBox ID="txtNombreCliente" runat="server" CssClass="form-control mb-2 validar-nombre" placeholder="Nombre"></asp:TextBox>

                    <span class="error-message" id="errorApellido"></span>
                    <asp:TextBox ID="txtApellidoCliente" runat="server" CssClass="form-control mb-2 validar-apellido" placeholder="Apellido"></asp:TextBox>

                    <span class="error-message" id="errorDireccion"></span>
                    <asp:TextBox ID="txtDireccionCliente" runat="server" CssClass="form-control mb-2 validar-direccion" placeholder="Dirección"></asp:TextBox>

                    <span class="error-message" id="errorTelefono"></span>
                    <asp:TextBox ID="txtTelefonoCliente" runat="server" CssClass="form-control mb-2 validar-telefono" placeholder="Teléfono"></asp:TextBox>

                    <span class="error-message" id="errorCorreo"></span>
                    <asp:TextBox ID="txtCorreoCliente" runat="server" CssClass="form-control mb-2 validar-correo" placeholder="Correo"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarCliente');">Cerrar</button>
                    <asp:Button ID="btnGuardarCliente" runat="server" CssClass="btn btn-primary" Text="Guardar Cliente" OnClientClick="return validarAgregarCliente();" OnClick="btnGuardarCliente_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Modificar Cliente -->
    <div class="modal fade" id="modalModificarCliente" tabindex="-1" aria-labelledby="modalModificarClienteLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalModificarClienteLabel">Modificar Cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdnIdCliente" runat="server" />

                    <span class="error-message" id="errorDNIMod"></span>
                    <asp:TextBox ID="txtDNIClienteMod" runat="server" CssClass="form-control mb-2 validar-DNI-mod" placeholder="DNI"></asp:TextBox>

                    <span class="error-message" id="errorNombreMod"></span>
                    <asp:TextBox ID="txtNombreClienteMod" runat="server" CssClass="form-control mb-2 validar-nombre-mod" placeholder="Nombre del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorApellidoMod"></span>
                    <asp:TextBox ID="txtApellidoClienteMod" runat="server" CssClass="form-control mb-2 validar-apellido-mod" placeholder="Apellido del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorDireccionMod"></span>
                    <asp:TextBox ID="txtDireccionClienteMod" runat="server" CssClass="form-control mb-2 validar-direccion-mod" placeholder="Dirección del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorTelefonoMod"></span>
                    <asp:TextBox ID="txtTelefonoClienteMod" runat="server" CssClass="form-control mb-2 validar-telefono-mod" placeholder="Teléfono del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorCorreoMod"></span>
                    <asp:TextBox ID="txtCorreoClienteMod" runat="server" CssClass="form-control mb-2 validar-correo-mod" placeholder="Correo del Cliente"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarCliente');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" OnClientClick="return validarModificarCliente();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">
        function cargarDatosModal(id, DNI, nombre, apellido, direccion, telefono, correo) {
            document.getElementById('<%= hdnIdCliente.ClientID %>').value = id;
            document.getElementById('<%= txtDNIClienteMod.ClientID %>').value = DNI;
            document.getElementById('<%= txtNombreClienteMod.ClientID %>').value = nombre;
            document.getElementById('<%= txtApellidoClienteMod.ClientID %>').value = apellido;
            document.getElementById('<%= txtDireccionClienteMod.ClientID %>').value = direccion;
            document.getElementById('<%= txtTelefonoClienteMod.ClientID %>').value = telefono;
            document.getElementById('<%= txtCorreoClienteMod.ClientID %>').value = correo;
        }
    </script>

</asp:Content>
