<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPComercio.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

       <div class="containerProveedores">
   <asp:GridView ID="gvProveedores" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table">
       <columns>
           <asp:BoundField DataField="Id" HeaderText="ID" />
           <asp:BoundField DataField="Siglas" HeaderText="Siglas" />
           <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
           <asp:BoundField DataField="Direccion" HeaderText="Direccion" />
           <asp:BoundField DataField="Correo" HeaderText="Correo" />
           <asp:BoundField DataField="Telefono" HeaderText="Telefono" />
       </columns>
   </asp:GridView>
</div>

</asp:Content>
