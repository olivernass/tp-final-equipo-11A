<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="TPComercio.Ventas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label Text="Ingrese el documento del cliente" runat="server" />
    <asp:TextBox runat="server" ID="txtFiltroDNIClientes" CssClass="form-control" AutoPostBack="false" OnTextChanged="txtFiltroDNIClientes_TextChanged" />
    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click" />

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <asp:Repeater ID="rptVentasClientes" runat="server">
                    <HeaderTemplate>
                        <table class="table tableVentasClientes table-hover mt-3">
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
                                    <th scope="col">Activo</th>
                                    <th scope="col" class="acciones">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
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
                            <td><%# (bool)Eval("Activo") ? "Sí" : "No"%></td>
                            <td>
                                <!-- Botón Facturar -->
                                <asp:Button Text="Facturar" runat="server" CssClass="btn btn-primary" CommandArgument='<%# Eval("Id") %>' ID="btnFactuar" OnCommand="btnFactuar_Command" />
                            </td>
                        </tr>
                        <script type="text/javascript">
                            function redirigirFormularioVenta(clienteId) {
                                window.location.href = "FormularioVenta.aspx?idCliente=" + clienteId;
                            }
                        </script>

                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
    </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <br />
    <asp:Button ID="btnVolver" runat="server" Text="Volver" OnClick="btnVolver_Click" />

    <script type="text/javascript">
        $(document).ready(function () {
            // Evento keyup para filtrar clientes por DNI en tiempo real
            $('#<%= txtFiltroDNIClientes.ClientID %>').on('keyup', function () {
            var filtro = $(this).val(); // Obtener el texto ingresado en el campo de búsqueda

            $.ajax({
                type: "POST",
                url: "Ventas.aspx/FiltrarClientes", // Asegúrate de usar el nombre correcto del método WebMethod
                data: JSON.stringify({ filtro: filtro }), // Enviar el filtro como JSON al servidor
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Actualizar el contenido del cuerpo de la tabla con los datos filtrados
                    $('tbody', '.tableVentasClientes').html(response.d); // response.d contiene el HTML generado
                },
                error: function (error) {
                    console.error("Error al filtrar los clientes:", error);
                }
            });
        });
    });
    </script>


</asp:Content>
