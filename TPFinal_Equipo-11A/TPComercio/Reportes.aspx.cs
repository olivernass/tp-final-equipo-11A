using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarMarcasConMasProductos();

                MostrarCategoriasConMasProductos();

                MostrarPrimerCliente();

                MostrarUltimoCliente();
            }
        }

        //private void MostrarMarcaConMasProductos()
        //{
        //    MarcaNegocio marcaNegocio = new MarcaNegocio();
        //    Marca marcaConMasProductos = marcaNegocio.ObtenerMarcaConMasProductos();

        //    if (marcaConMasProductos != null)
        //    {
        //        // Muestra los datos en la página, por ejemplo en etiquetas Label
        //        lblMarcaNombre.Text = "Marca con más productos: " + marcaConMasProductos.NombreMarca;
        //        lblMarcaID.Text = "ID de la marca: " + marcaConMasProductos.Id;
        //    }
        //    else
        //    {
        //        lblMarcaNombre.Text = "No se encontró ninguna marca con productos.";
        //        lblMarcaID.Text = string.Empty;
        //    }
        //}

        private void MostrarMarcasConMasProductos()
        {
            MarcaNegocio marcaNegocio = new MarcaNegocio();
            List<Marca> marcasConMasProductos = marcaNegocio.ObtenerMarcasConMasProductos();

            if (marcasConMasProductos != null && marcasConMasProductos.Count > 0)
            {
                // Construir un texto para mostrar todas las marcas con la mayor cantidad de productos
                string marcasTexto = "Marcas con más productos: <br />";
                foreach (var marca in marcasConMasProductos)
                {
                    marcasTexto += $"ID: {marca.Id}, Nombre: {marca.NombreMarca}<br />";
                }

                // Mostrar el texto en una etiqueta o control en la página
                lblMarcaNombre.Text = marcasTexto;
                lblMarcaID.Text = string.Empty; // Opcional, no necesario en este caso
            }
            else
            {
                lblMarcaNombre.Text = "No se encontró ninguna marca con productos.";
                lblMarcaID.Text = string.Empty;
            }
        }

        private void MostrarCategoriasConMasProductos()
        {
            CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
            List<Categoria> categoriasConMasProductos = categoriaNegocio.ObtenerCategoriasConMasProductos();

            if (categoriasConMasProductos != null && categoriasConMasProductos.Count > 0)
            {
                // Construir un texto para mostrar todas las categorías con la mayor cantidad de productos
                string categoriasTexto = "Categorías con más productos: <br />";
                foreach (var categoria in categoriasConMasProductos)
                {
                    categoriasTexto += $"ID: {categoria.Id}, Nombre: {categoria.NombreCategoria}<br />";
                }

                // Mostrar el texto en las etiquetas correspondientes
                lblCategoriaNombre.Text = categoriasTexto;
                lblCategoriaID.Text = string.Empty; // Opcional, si no necesitas mostrar un ID individual
            }
            else
            {
                lblCategoriaNombre.Text = "No se encontró ninguna categoría con productos.";
                lblCategoriaID.Text = string.Empty;
            }
        }

        private void MostrarPrimerCliente()
        {
            ClienteNegocio clienteNegocio = new ClienteNegocio();
            Cliente primerCliente = clienteNegocio.ObtenerPrimerCliente(); // Llama al método que obtiene el primer cliente

            if (primerCliente != null)
            {
                // Construir un texto para mostrar los detalles del primer cliente
                string clienteTexto = "Primer cliente dado de alta: <br />";
                clienteTexto += $"ID: {primerCliente.Id}, Nombre: {primerCliente.Nombre} {primerCliente.Apellido}, DNI: {primerCliente.DNI}, Dirección: {primerCliente.Direccion}, Teléfono: {primerCliente.Telefono}, Correo: {primerCliente.Correo}, Fecha de alta: {primerCliente.Fecha_Alta.ToString("dd/MM/yyyy HH:mm:ss")}<br />";

                // Mostrar el texto en las etiquetas correspondientes
                lblClientePrimero.Text = clienteTexto;
            }
            else
            {
                lblClientePrimero.Text = "No se encontró ningún cliente registrado.";
            }
        }

        private void MostrarUltimoCliente()
        {
            ClienteNegocio clienteNegocio = new ClienteNegocio();
            Cliente ultimoCliente = clienteNegocio.ObtenerUltimoCliente(); // Llama al método que obtiene el último cliente

            if (ultimoCliente != null)
            {
                // Construir un texto para mostrar los detalles del último cliente
                string clienteTexto = "Último cliente dado de alta: <br />";
                clienteTexto += $"ID: {ultimoCliente.Id}, Nombre: {ultimoCliente.Nombre} {ultimoCliente.Apellido}, DNI: {ultimoCliente.DNI}, Dirección: {ultimoCliente.Direccion}, Teléfono: {ultimoCliente.Telefono}, Correo: {ultimoCliente.Correo}, Fecha de alta: {ultimoCliente.Fecha_Alta.ToString("dd/MM/yyyy HH:mm:ss")}<br />";

                // Mostrar el texto en las etiquetas correspondientes
                lblClienteUltimo.Text = clienteTexto;
            }
            else
            {
                lblClienteUltimo.Text = "No se encontró ningún cliente registrado.";
            }
        }

    }
}