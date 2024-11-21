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
    public partial class RepProductos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);

            if (!IsPostBack)
            {
                MostrarProductosMasCaros();

                MostrarProductosConMasProveedoresYDetalles();

                MostrarProductosConBajoStock();

                MostrarProductosSinStock();

                MostrarProductosMasRentables();

                MostrarProductosConProveedoresExclusivos();

                MostrarProductosConPrecioMasBajo();
            }
        }

        private void MostrarProductosMasCaros()
        {
            ProductoReportesNegocio productoNegocio = new ProductoReportesNegocio();
            List<ProductoReportes> productosMasCaros = productoNegocio.ObtenerProductosMasCaros();

            if (productosMasCaros != null && productosMasCaros.Count > 0)
            {
                string texto = "Productos más caros:<br />";
                foreach (var producto in productosMasCaros)
                {
                    texto += $"Producto: {producto.Nombre} (ID: {producto.Id})<br />";
                    texto += $"Descripción: {producto.Descripcion ?? "Sin descripción"}<br />";
                    texto += $"Precio: {producto.Precio_Venta:C}<br />";
                    texto += $"Marca: {producto.Marca.NombreMarca}, Categoría: {producto.Categoria.NombreCategoria}<br />";
                    texto += "Proveedores:<br />";

                    if (producto.Proveedores != null && producto.Proveedores.Count > 0)
                    {
                        foreach (var proveedor in producto.Proveedores)
                        {
                            texto += $"- {proveedor.Nombre} (ID: {proveedor.Id})<br />";
                        }
                    }
                    else
                    {
                        texto += "- Sin proveedores asociados.<br />";
                    }

                    texto += "<br />";
                }

                lblProductosMasCaros.Text = texto;
            }
            else
            {
                lblProductosMasCaros.Text = "No se encontraron productos activos.";
            }
        }

        private void MostrarProductosConMasProveedoresYDetalles()
        {
            ProductoReportesNegocio productoNegocio = new ProductoReportesNegocio();
            List<ProductoReportes> productosConProveedores = productoNegocio.ObtenerProductosConMasProveedoresYDetalles();

            if (productosConProveedores != null && productosConProveedores.Count > 0)
            {
                string texto = "Productos con mayor cantidad de proveedores asociados:<br />";
                foreach (var producto in productosConProveedores)
                {
                    texto += $"<strong>Producto:</strong> {producto.Nombre} (ID: {producto.Id})<br />";
                    texto += $"<strong>Descripción:</strong> {producto.Descripcion ?? "Sin descripción"}<br />";
                    texto += $"<strong>Cantidad de Proveedores:</strong> {producto.CantidadProveedores}<br />";
                    texto += $"<strong>Proveedores:</strong><br />";

                    foreach (var proveedor in producto.ProveedoresAsociados)
                    {
                        texto += $"- {proveedor.Nombre} (ID: {proveedor.Id})<br />";
                        texto += $"  CUIT: {proveedor.CUIT}, Teléfono: {proveedor.Telefono}, Correo: {proveedor.Correo}<br />";
                    }

                    texto += "<br />";
                }

                lblProductosConProveedores.Text = texto;
            }
            else
            {
                lblProductosConProveedores.Text = "No se encontraron productos con proveedores asociados.";
            }
        }
        private void MostrarProductosConBajoStock()
        {
            ProductoReportesNegocio productoNegocio = new ProductoReportesNegocio();
            List<ProductoReportes> productosBajoStock = productoNegocio.ObtenerProductosConBajoStock();

            if (productosBajoStock != null && productosBajoStock.Count > 0)
            {
                string texto = "Productos con bajo stock:<br />";
                foreach (var item in productosBajoStock)
                {
                    texto += $"Producto: {item.Nombre} (ID: {item.Id})<br />";
                    texto += $"Marca: {item.NombreMarca}<br />";
                    texto += $"Categoría: {item.NombreCategoria}<br />";
                    texto += $"Stock Actual: {item.StockActual} - Stock Mínimo: {item.StockMinimo}<br />";
                    texto += $"Precio Venta: {item.Precio_Venta:C} - Precio Compra: {item.Precio_Compra:C}<br />";
                    texto += $"Proveedores Asociados: {item.Proveedores2}<br /><br />";
                }

                //lblProductosBajoStock.Text = texto;
            }
            else
            {
                //lblProductosBajoStock.Text = "No se encontraron productos con bajo stock.";
            }
        }
        private void MostrarProductosSinStock()
        {
            ProductoReportesNegocio productoNegocio = new ProductoReportesNegocio();
            List<ProductoReportes> productosSinStock = productoNegocio.ObtenerProductosSinStock();

            if (productosSinStock != null && productosSinStock.Count > 0)
            {
                string texto = "Productos sin stock:<br />";
                foreach (var item in productosSinStock)
                {
                    texto += $"Producto: {item.Nombre} (ID: {item.Id})<br />";
                    texto += $"Marca: {item.Marca.NombreMarca}<br />";
                    texto += $"Categoría: {item.Categoria.NombreCategoria}<br />";
                    texto += $"Stock Actual: {item.StockActual}<br />";
                    texto += $"Precio Compra: {item.Precio_Compra:C} - Precio Venta: {item.Precio_Venta:C}<br />";

                    // Proveedores asociados
                    texto += "Proveedores: ";
                    if (item.Proveedores.Count > 0)
                    {
                        texto += string.Join(", ", item.Proveedores.Select(p => p.Nombre));
                    }
                    else
                    {
                        texto += "Sin proveedores asociados.";
                    }
                    texto += "<br /><br />";
                }

                lblProductosSinStock.Text = texto;
            }
            else
            {
                lblProductosSinStock.Text = "No se encontraron productos sin stock.";
            }
        }
        private void MostrarProductosMasRentables()
        {
            ProductoReportesNegocio productoNegocio = new ProductoReportesNegocio();
            List<ProductoReportes> productosRentables = productoNegocio.ObtenerProductosMasRentables();

            if (productosRentables != null && productosRentables.Count > 0)
            {
                string texto = "Productos Más Rentables:<br />";
                foreach (var producto in productosRentables)
                {
                    texto += $"Producto: {producto.Nombre} (ID: {producto.Id})<br />";
                    texto += $"Precio Compra: {producto.Precio_Compra:C}, Precio Venta: {producto.Precio_Venta:C}<br />";
                    texto += $"Margen de Ganancia: {producto.Porcentaje_Ganancia:C}<br />";
                    texto += $"Marca: {producto.Marca.NombreMarca}, Categoría: {producto.Categoria.NombreCategoria}<br /><br />";
                }

                lblProductosMasRentables.Text = texto;
            }
            else
            {
                lblProductosMasRentables.Text = "No se encontraron productos rentables.";
            }
        }
        private void MostrarProductosConProveedoresExclusivos()
        {
            ProductoReportesNegocio productoNegocio = new ProductoReportesNegocio();
            List<ProductoReportes> productosExclusivos = productoNegocio.ObtenerProductosConProveedoresExclusivos();

            if (productosExclusivos != null && productosExclusivos.Count > 0)
            {
                string texto = "Productos con Proveedores Exclusivos:<br />";
                foreach (var producto in productosExclusivos)
                {
                    texto += $"Producto: {producto.Nombre} (ID: {producto.Id})<br />";
                    texto += $"Marca: {producto.Marca.NombreMarca}, Categoría: {producto.Categoria.NombreCategoria}<br />";
                    texto += $"Proveedor Exclusivo: {producto.ProveedorExclusivo.Nombre} (ID: {producto.ProveedorExclusivo.Id})<br />";
                    texto += $"Stock Actual: {producto.StockActual}, Stock Mínimo: {producto.StockMinimo}<br /><br />";
                }

                lblProductosConProveedoresExclusivos.Text = texto;
            }
            else
            {
                lblProductosConProveedoresExclusivos.Text = "No se encontraron productos con proveedores exclusivos.";
            }
        }
        private void MostrarProductosConPrecioMasBajo()
        {
            ProductoReportesNegocio negocio = new ProductoReportesNegocio();
            var productos = negocio.ObtenerProductosConPrecioMasBajo();

            if (productos != null && productos.Count > 0)
            {
                string texto = "Productos con Precio Más Bajo:<br />";
                foreach (var item in productos)
                {
                    texto += $"Producto: {item.Nombre} (ID: {item.Id})<br />";
                    texto += $"Precio Venta: {item.Precio_Venta:C}<br />";
                    texto += $"Marca: {item.Marca.NombreMarca}, Categoría: {item.Categoria.NombreCategoria}, Stock: {item.StockActual}<br />";
                    texto += "Proveedores:<br />";

                    if (item.Proveedores != null && item.Proveedores.Count > 0)
                    {
                        foreach (var proveedor in item.Proveedores)
                        {
                            texto += $"- {proveedor.Nombre} (ID: {proveedor.Id})<br />";
                        }
                    }
                    else
                    {
                        texto += "- Sin proveedores asociados.<br />";
                    }

                    texto += "<br />";
                }

                lblProductosPrecioBajo.Text = texto;
            }
            else
            {
                lblProductosPrecioBajo.Text = "No se encontraron productos con precio bajo.";
            }
        }
    }
}