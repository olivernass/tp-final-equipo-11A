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

                MostrarMarcasConProductoMasCostoso();

                MostrarCategoriasConMasProductos();

                MostrarCategoriasConProductoMasCostoso();

                MostrarPrimerCliente();

                MostrarUltimoCliente();
            }
        }

        private void MostrarMarcasConMasProductos()
        {
            MarcaReportesNegocio marcaRepoNegocio = new MarcaReportesNegocio();
            List<MarcaReportes> marcasConMasProductos = marcaRepoNegocio.ObtenerMarcasConMasProductos();

            if (marcasConMasProductos != null && marcasConMasProductos.Count > 0)
            {
                // Construir un texto para mostrar todas las marcas con la mayor cantidad de productos
                string marcasTexto = "Marcas con más productos: <br />";
                foreach (var marca in marcasConMasProductos)
                {
                    marcasTexto += $"ID: {marca.Id}, Nombre: {marca.NombreMarca}, Cantidad de productos: {marca.CantidadProductos}<br />";
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

        private void MostrarMarcasConProductoMasCostoso()
        {
            var negocio = new MarcaReportesNegocio();
            var marcasConProductoMasCostoso = negocio.ObtenerMarcasConProductoMasCostoso();

            if (marcasConProductoMasCostoso != null && marcasConProductoMasCostoso.Count > 0)
            {
                string texto = "Marcas con el/los producto(s) más costoso(s):<br />";
                foreach (var item in marcasConProductoMasCostoso)
                {
                    texto += $"Marca: {item.NombreMarca} (ID: {item.Id})<br />";
                    texto += $"Producto: {item.NombreProducto} (ID: {item.ProductoID}) - Precio: {item.PrecioVenta:C}<br />";
                    texto += $"Cantidad de productos en la marca: {item.CantidadProductos}<br /><br />";
                }

                lblReporteMarcas.Text = texto;
            }
            else
            {
                lblReporteMarcas.Text = "No se encontraron marcas con productos activos.";
            }
        }


        private void MostrarCategoriasConMasProductos()
        {
            CategoriaReportesNegocio categoriaRepoNegocio = new CategoriaReportesNegocio();
            List<CategoriaReportes> categoriasConMasProductos = categoriaRepoNegocio.ObtenerCategoriasConMasProductos();

            if (categoriasConMasProductos != null && categoriasConMasProductos.Count > 0)
            {
                // Construir un texto para mostrar todas las categorías con la mayor cantidad de productos
                string categoriasTexto = "Categorías con más productos: <br />";
                foreach (var categoria in categoriasConMasProductos)
                {
                    categoriasTexto += $"ID: {categoria.Id}, Nombre: {categoria.NombreCategoria}, Cantidad de productos: {categoria.CantidadProductos}<br />";
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

        private void MostrarCategoriasConProductoMasCostoso()
        {
            var negocio = new CategoriaReportesNegocio();
            var categoriasConProductoMasCostoso = negocio.ObtenerCategoriasConProductoMasCostoso();

            if (categoriasConProductoMasCostoso != null && categoriasConProductoMasCostoso.Count > 0)
            {
                string texto = "Categorias con el/los producto(s) más costoso(s):<br />";
                foreach (var item in categoriasConProductoMasCostoso)
                {
                    texto += $"Categoría: {item.NombreCategoria} (ID: {item.Id})<br />"; // Usando propiedades heredadas
                    texto += $"Producto: {item.NombreProducto} (ID: {item.ProductoID}) - Precio: {item.PrecioVenta:C}<br />";
                    texto += $"Cantidad de productos en la categoría: {item.CantidadProductos}<br /><br />";
                }

                lblReporteCategorias.Text = texto;
            }
            else
            {
                lblReporteCategorias.Text = "No se encontraron categorías con productos activos.";
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