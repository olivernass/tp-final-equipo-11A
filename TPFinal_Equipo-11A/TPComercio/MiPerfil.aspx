<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MiPerfil.aspx.cs" Inherits="TPComercio.MiPerfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containerPerfil mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-center bg-secondary text-white">
                        <h3>Mi Perfil</h3>
                    </div>
                    <div class="card-body">
                        <p><strong>Nombre de usuario:</strong> <span id="lblNombreUsuario" runat="server"></span></p>
                        <p><strong>Tipo de permiso:</strong> <span id="lblTipoPermiso" runat="server"></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
