using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class Ventas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarClientes();
            }
        }
        private void cargarClientes()
        {
            ClienteNegocio negocio = new ClienteNegocio();
            List<Cliente> listaClientes = negocio.listar();
            Session.Add("listaClientes", negocio.listar());
            rptVentasClientes.DataSource = Session["listaClientes"];
            //rptClientes.DataSource = listaClientes;
            rptVentasClientes.DataBind();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            // Cargar todas las marcas
            cargarClientes();

            // Limpiar los controles de filtro
            txtFiltroDNIClientes.Text = string.Empty;
            
            //// Desactivar los controles de filtro
            //txtFiltroDNIClientes.Enabled = false;
          
        }
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("VentasRedireccion.aspx");
        }

        protected void txtFiltroDNIClientes_TextChanged(object sender, EventArgs e)
        {
            // Recuperar la lista de clientes de la sesión
            List<Cliente> lista = (List<Cliente>)Session["listaClientes"];

            // Filtrar la lista por el valor ingresado en el campo txtFiltroDNIClientes
            List<Cliente> listaFiltrada = lista.FindAll(x => x.DNI.ToString().Contains(txtFiltroDNIClientes.Text));

            // Asignar la lista filtrada al Repeater
            rptVentasClientes.DataSource = listaFiltrada;
            rptVentasClientes.DataBind();
        }



        [System.Web.Services.WebMethod]
        public static string FiltrarClientes(string filtro)
        {
            try
            {
                // Crear la instancia de ClienteNegocio
                ClienteNegocio negocio = new ClienteNegocio();

                List<Cliente> listaFiltrada;

                if (string.IsNullOrEmpty(filtro)) // Si el filtro está vacío, devolver toda la lista
                {
                    listaFiltrada = negocio.listar();
                }
                else
                {
                    // Filtrar la lista de clientes basándonos en el DNI ingresado
                    listaFiltrada = negocio.listar()
                        .Where(x => x.DNI.ToString().StartsWith(filtro)) // Filtrar solo por DNI que comienzan con el filtro
                        .ToList();
                }

                // Generar el HTML para la tabla
                string resultadoHtml = "";

                foreach (var cliente in listaFiltrada)
                {
                    resultadoHtml += $"<tr>" +
                                        $"<th scope='row'>{cliente.Id}</th>" +
                                        $"<td>{cliente.DNI}</td>" +
                                        $"<td>{cliente.Nombre}</td>" +
                                        $"<td>{cliente.Apellido}</td>" +
                                        $"<td>{cliente.Direccion}</td>" +
                                        $"<td>{cliente.Telefono}</td>" +
                                        $"<td>{cliente.Correo}</td>" +
                                        $"<td>{cliente.Fecha_Alta.ToString("dd/MM/yyyy HH:mm")}</td>" +
                                        $"<td>{(cliente.Activo ? "Sí" : "No")}</td>" +
                                        $"<td>" +
                                            // Botón Facturar en HTML
                                            $"<button type='button' class='btn btn-primary' onclick='redirigirFormularioVenta({cliente.Id})'>Facturar</button>" +
                                        $"</td>" +
                                     $"</tr>";
                }


                return resultadoHtml; // Devolver el HTML generado
            }
            catch (Exception ex)
            {
                return "Error al filtrar los clientes: " + ex.Message;
            }
        }

        protected void btnFactuar_Command(object sender, CommandEventArgs e)
        {
            // Capturar el ID del cliente desde el argumento del comando
            long clienteId = Convert.ToInt64(e.CommandArgument);

            // Redirigir a FormularioVentas.aspx pasando el ID del cliente como parámetro en la URL
            Response.Redirect("FormularioVenta.aspx?idCliente=" + clienteId);
        }

    }
}