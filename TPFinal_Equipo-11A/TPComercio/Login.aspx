<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPComercio.Login" %>

<%--<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containerLogin mt-5">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title text-center">Inicio de Sesión</h3>

                        <!-- Campo de Usuario -->
                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" Placeholder="Usuario"></asp:TextBox>
                            <label for="txtUser">Usuario</label>
                        </div>

                        <!-- Campo de Contraseña -->
                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Contraseña"></asp:TextBox>
                            <label for="txtPassword">Contraseña</label>
                        </div>

                        <!-- Botón de Loguearse -->
                        <asp:Button ID="btnIngresar" runat="server" CssClass="btn btn-primary w-100" Text="Loguearse" OnClick="btnIngresar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containerLogin mt-5">
        <img src="Content/Iconos/login.png" alt="Login" class="mb-3 mx-auto d-block" style="width: 150px; height: auto;">
        <div class="row justify-content-center">
            <div class="col-md-4 col-lg-3 mx-auto">
                <div class="card">
                    <div class="card-body">
                        
                        <h3 class="card-title text-center">Inicio de Sesión</h3>

                        <!-- Campo de Usuario -->
                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" Placeholder="Usuario"></asp:TextBox>
                            <label for="txtUser">Usuario</label>
                        </div>

                        <!-- Campo de Contraseña -->
                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Contraseña"></asp:TextBox>
                            <label for="txtPassword">Contraseña</label>
                        </div>

                        <!-- Botón de Loguearse -->
                        <asp:Button ID="btnIngresar" runat="server" CssClass="btn btn-primary w-100" Text="Loguearse" OnClick="btnIngresar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

