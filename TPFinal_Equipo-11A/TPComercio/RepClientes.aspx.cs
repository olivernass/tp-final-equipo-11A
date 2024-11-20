using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPComercio.Utils;

namespace TPComercio
{
    public partial class RepClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);

            if (!IsPostBack)
            {
                MostrarPrimerCliente();

                MostrarUltimoCliente();

                MostrarReporteClientesPorEstado();

                MostrarPromedioAntiguedadClientes();
            }
        }

        private void MostrarPrimerCliente()
        {
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes primerCliente = clienteNegocio.ObtenerPrimerCliente();

            if (primerCliente != null)
            {
                string dropdownContent = $@"
            <h6 class='dropdown-header'>Datos del cliente</h6>
            <a class='dropdown-item'>ID: {primerCliente.Id}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Nombre: {primerCliente.Nombre} {primerCliente.Apellido}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>DNI: {primerCliente.DNI}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Dirección: {primerCliente.Direccion}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Teléfono: {primerCliente.Telefono}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Correo: {primerCliente.Correo}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Fecha de alta: {primerCliente.Fecha_Alta:dd/MM/yyyy HH:mm:ss}</a>";

                divPrimerCliente.InnerHtml = dropdownContent;
            }
            else
            {
                divPrimerCliente.InnerHtml = "<a class='dropdown-item'>No se encontró ningún cliente registrado.</a>";
            }
        }

        private void MostrarUltimoCliente()
        {
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes ultimoCliente = clienteNegocio.ObtenerUltimoCliente();

            if (ultimoCliente != null)
            {

                string dropdownContent = $@"
            <h6 class='dropdown-header'>Datos del cliente</h6>
            <a class='dropdown-item'>ID: {ultimoCliente.Id}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Nombre: {ultimoCliente.Nombre} {ultimoCliente.Apellido}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>DNI: {ultimoCliente.DNI}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Dirección: {ultimoCliente.Direccion}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Teléfono: {ultimoCliente.Telefono}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Correo: {ultimoCliente.Correo}</a>
            <div class='dropdown-divider'></div>
            <a class='dropdown-item'>Fecha de alta: {ultimoCliente.Fecha_Alta:dd/MM/yyyy HH:mm:ss}</a>";


                divUltimoCliente.InnerHtml = dropdownContent;
            }
            else
            {
                divUltimoCliente.InnerHtml = "<a class='dropdown-item'>No se encontró ningún cliente registrado.</a>";
            }
        }


        private void MostrarReporteClientesPorEstado()
        {
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes reporte = clienteNegocio.ObtenerReporteClientesPorEstado();

            if (reporte != null)
            {

                string listGroupContent = $@"
            <li class='list-group-item d-flex justify-content-between align-items-center'>
                Clientes Activos
                <span class='badge bg-primary badge-pill'>{reporte.TotalActivos}</span>
            </li>
            <li class='list-group-item d-flex justify-content-between align-items-center'>
                Clientes Inactivos
                <span class='badge bg-danger badge-pill'>{reporte.TotalInactivos}</span>
            </li>";


                divReporteClientes.InnerHtml = listGroupContent;
            }
            else
            {
                divReporteClientes.InnerHtml = "<li class='list-group-item'>No se pudo generar el reporte.</li>";
            }
        }

        private void MostrarPromedioAntiguedadClientes()
        {
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes reporte = clienteNegocio.ObtenerPromedioAntiguedadClientes();

            if (reporte != null)
            {
                string listGroupContent = $@"
            <li class='list-group-item d-flex justify-content-between align-items-center'>
                Promedio de antigüedad de los clientes
                <span class='badge bg-success badge-pill'>{reporte.PromedioAntiguedadDias:N2} días</span>
            </li>";

                divPromedioAntiguedadClientes.InnerHtml = listGroupContent;
            }
            else
            {
                divPromedioAntiguedadClientes.InnerHtml = "<li class='list-group-item'>No se pudo calcular el promedio de antigüedad.</li>";
            }
        }

    }
}