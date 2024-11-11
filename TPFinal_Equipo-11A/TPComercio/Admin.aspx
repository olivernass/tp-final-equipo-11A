<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="TPComercio.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
    <div class="row">
        <!-- Barra lateral -->
        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar position-fixed">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="Usuarios.aspx">
                            Usuarios
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Clientes.aspx">
                            Clientes
                        </a>
                    </li>                  
                </ul>
            </div>
        </nav>

        <!-- Contenido principal -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <h1>Panel de Administración</h1>
            <p>Aquí puedes administrar las configuraciones y otros elementos.</p>          
        </main>
    </div>
</div>
</asp:Content>


