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
                //MARCAS
                MostrarMarcasConMasProductos();

                MostrarMarcasConProductoMasCostoso();

                MostrarMarcasSinProductos();

                MostrarMarcasConProductosBajoStock();

                MostrarReporteMarcasPorEstado();

                //CATEGORIAS
                MostrarCategoriasConMasProductos();

                MostrarCategoriasConProductoMasCostoso();

                MostrarCategoriasSinProductos();

                MostrarCategoriasConProductosBajoStock();

                MostrarReporteCategoriasPorEstado();

                //PROVEEDORES
                MostrarProveedoresConMasProductos();

                MostrarProveedoresConProductoMasCostoso();

                MostrarProveedoresSinProductos();

                MostrarProveedoresConProductosBajoStock();

                MostrarReporteProveedoresPorEstado();

                //CLIENTES
                MostrarPrimerCliente();

                MostrarUltimoCliente();

                MostrarReporteClientesPorEstado();

                MostrarPromedioAntiguedadClientes();

                //PRODUCTOS
                MostrarProductosMasCaros();

                MostrarProductosConMasProveedoresYDetalles();

                MostrarProductosConBajoStock();

                MostrarProductosSinStock();

                MostrarProductosMasRentables();

                MostrarProductosConProveedoresExclusivos();

                MostrarProductosConPrecioMasBajo();
            }
        }

        //-------------------------------------------MARCAS------------------------------------
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

        private void MostrarMarcasSinProductos()
        {
            var negocio = new MarcaReportesNegocio(); // Asegúrate de tener la capa de negocio correcta.
            var marcasSinProductos = negocio.ObtenerMarcasSinProductos();

            if (marcasSinProductos != null && marcasSinProductos.Count > 0)
            {
                string texto = "Marcas sin productos asociados:<br />";
                foreach (var item in marcasSinProductos)
                {
                    texto += $"Marca: {item.NombreMarca} (ID: {item.Id})<br />";
                }

                lblMarcasSinProductos.Text = texto;
            }
            else
            {
                lblMarcasSinProductos.Text = "No se encontraron marcas sin productos.";
            }
        }

        private void MostrarMarcasConProductosBajoStock()
        {
            var negocio = new MarcaReportesNegocio();
            var marcasConBajoStock = negocio.ObtenerMarcasConProductosBajoStock();

            if (marcasConBajoStock != null && marcasConBajoStock.Count > 0)
            {
                string texto = "Marcas con productos bajo stock:<br />";
                foreach (var item in marcasConBajoStock)
                {
                    texto += $"Marca: {item.NombreMarca} (ID: {item.Id})<br />";
                    texto += $"Producto: {item.NombreProducto} (ID: {item.ProductoID}) - Stock Actual: {item.StockActual}, Stock Mínimo: {item.StockMinimo}<br /><br />";
                }

                lblMarcasProductosBajoStock.Text = texto;
            }
            else
            {
                lblMarcasProductosBajoStock.Text = "No se encontraron marcas con productos bajo stock.";
            }
        }
        private void MostrarReporteMarcasPorEstado()
        {
            MarcaReportesNegocio marcaNegocio = new MarcaReportesNegocio();
            MarcaReportes reporte = marcaNegocio.ObtenerReporteMarcasPorEstado();

            if (reporte != null)
            {
                lblMarcasActivasInactivas.Text = $"Marcas Activas: {reporte.TotalActivos}<br />Marcas Inactivas: {reporte.TotalInactivos}";
            }
            else
            {
                lblMarcasActivasInactivas.Text = "No se pudo generar el reporte.";
            }
        }


        //-------------------------------CATEGORIAS-----------------------------------------------------
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

        private void MostrarCategoriasSinProductos()
        {
            var negocio = new CategoriaReportesNegocio(); // Asegúrate de usar la capa de negocio adecuada.
            var categoriasSinProductos = negocio.ObtenerCategoriasSinProductos();

            if (categoriasSinProductos != null && categoriasSinProductos.Count > 0)
            {
                string texto = "Categorías sin productos asociados:<br />";
                foreach (var item in categoriasSinProductos)
                {
                    texto += $"Categoría: {item.NombreCategoria} (ID: {item.Id})<br />";
                }

                lblCategoriasSinProductos.Text = texto;
            }
            else
            {
                lblCategoriasSinProductos.Text = "No se encontraron categorías sin productos.";
            }
        }

        private void MostrarCategoriasConProductosBajoStock()
        {
            var negocio = new CategoriaReportesNegocio();
            var categoriasConBajoStock = negocio.ObtenerCategoriasConProductosBajoStock();

            if (categoriasConBajoStock != null && categoriasConBajoStock.Count > 0)
            {
                string texto = "Categorías con productos bajo stock:<br />";
                foreach (var item in categoriasConBajoStock)
                {
                    texto += $"Categoría: {item.NombreCategoria} (ID: {item.Id})<br />";
                    texto += $"Producto: {item.NombreProducto} (ID: {item.ProductoID}) - Stock Actual: {item.StockActual}, Stock Mínimo: {item.StockMinimo}<br /><br />";
                }

                lblCategoriasProductosBajoStock.Text = texto;
            }
            else
            {
                lblCategoriasProductosBajoStock.Text = "No se encontraron categorías con productos bajo stock.";
            }
        }

        private void MostrarReporteCategoriasPorEstado()
        {
            CategoriaReportesNegocio categoriaNegocio = new CategoriaReportesNegocio();
            CategoriaReportes reporte = categoriaNegocio.ObtenerReporteCategoriasPorEstado();

            if (reporte != null)
            {
                lblCategoriasActivasInactivas.Text = $"Categorías Activas: {reporte.TotalActivos}<br />Categorías Inactivas: {reporte.TotalInactivos}";
            }
            else
            {
                lblCategoriasActivasInactivas.Text = "No se pudo generar el reporte.";
            }
        }


        //----------------------------------PROVEEDORES----------------------------------------------------------
        private void MostrarProveedoresConMasProductos()
        {
            ProveedorReportesNegocio proveedorRepoNegocio = new ProveedorReportesNegocio();
            List<ProveedorReportes> proveedoresConMasProductos = proveedorRepoNegocio.ObtenerProveedoresConMasProductos();

            if (proveedoresConMasProductos != null && proveedoresConMasProductos.Count > 0)
            {
                // Construir un texto para mostrar todos los proveedores con la mayor cantidad de productos
                string proveedoresTexto = "Proveedores con más productos: <br />";
                foreach (var proveedor in proveedoresConMasProductos)
                {
                    proveedoresTexto += $"ID: {proveedor.Id}, Nombre: {proveedor.Nombre}, Cantidad de productos: {proveedor.CantidadProductos}<br />";
                }

                // Mostrar el texto en una etiqueta o control en la página
                lblProveedorConMasProductos.Text = proveedoresTexto;
                lblProveedorConMasProductosID.Text = string.Empty; // Opcional, no necesario en este caso
            }
            else
            {
                lblProveedorConMasProductos.Text = "No se encontró ningún proveedor con productos.";
                lblProveedorConMasProductosID.Text = string.Empty;
            }
        }

        private void MostrarProveedoresConProductoMasCostoso()
        {
            var negocio = new ProveedorReportesNegocio();
            var proveedoresConProductoMasCostoso = negocio.ObtenerProveedoresConProductoMasCostoso();

            if (proveedoresConProductoMasCostoso != null && proveedoresConProductoMasCostoso.Count > 0)
            {
                string texto = "Proveedores con el/los producto(s) más costoso(s):<br />";
                foreach (var item in proveedoresConProductoMasCostoso)
                {
                    texto += $"Proveedor: {item.Nombre} (ID: {item.Id})<br />";
                    texto += $"Producto: {item.NombreProducto} (ID: {item.ProductoID}) - Precio: {item.PrecioVenta:C}<br />";
                    texto += $"Cantidad de productos del proveedor: {item.CantidadProductos}<br /><br />";
                }

                lblReporteProveedores.Text = texto;
            }
            else
            {
                lblReporteProveedores.Text = "No se encontraron proveedores con productos activos.";
            }
        }

        private void MostrarProveedoresSinProductos()
        {
            var negocio = new ProveedorReportesNegocio();
            var proveedoresSinProductos = negocio.ObtenerProveedoresSinProductos();

            if (proveedoresSinProductos != null && proveedoresSinProductos.Count > 0)
            {
                string texto = "Proveedores sin productos asociados:<br />";
                foreach (var item in proveedoresSinProductos)
                {
                    texto += $"Proveedor: {item.Nombre} (ID: {item.Id})<br />";
                }

                lblProveedoresSinProductos.Text = texto;
            }
            else
            {
                lblProveedoresSinProductos.Text = "No se encontraron proveedores sin productos.";
            }
        }
        private void MostrarProveedoresConProductosBajoStock()
        {
            var negocio = new ProveedorReportesNegocio();
            var proveedoresConBajoStock = negocio.ObtenerProveedoresConProductosBajoStock();

            if (proveedoresConBajoStock != null && proveedoresConBajoStock.Count > 0)
            {
                string texto = "Proveedores con productos bajo stock:<br />";
                foreach (var item in proveedoresConBajoStock)
                {
                    texto += $"Proveedor: {item.Nombre} (ID: {item.Id})<br />";
                    texto += $"Producto: {item.NombreProducto} (ID: {item.ProductoID}) - Stock Actual: {item.StockActual}, Stock Mínimo: {item.StockMinimo}<br /><br />";
                }

                lblProveedoresProductosBajoStock.Text = texto;
            }
            else
            {
                lblProveedoresProductosBajoStock.Text = "No se encontraron proveedores con productos bajo stock.";
            }
        }

        private void MostrarReporteProveedoresPorEstado()
        {
            ProveedorReportesNegocio proveedorNegocio = new ProveedorReportesNegocio();
            ProveedorReportes reporte = proveedorNegocio.ObtenerReporteProveedoresPorEstado();

            if (reporte != null)
            {
                lblProveedoresActivosInactivos.Text = $"Proveedores Activos: {reporte.TotalActivos}<br />Proveedores Inactivos: {reporte.TotalInactivos}";
            }
            else
            {
                lblProveedoresActivosInactivos.Text = "No se pudo generar el reporte.";
            }
        }


        //-------------------------------------CLIENTES--------------------------------------------------------
        private void MostrarPrimerCliente()
        {
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes primerCliente = clienteNegocio.ObtenerPrimerCliente(); // Llama al método que obtiene el primer cliente

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
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes ultimoCliente = clienteNegocio.ObtenerUltimoCliente(); // Llama al método que obtiene el último cliente

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

        private void MostrarReporteClientesPorEstado()
        {
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes reporte = clienteNegocio.ObtenerReporteClientesPorEstado();

            if (reporte != null)
            {
                lblClienteActivosInactivos.Text = $"Clientes Activos: {reporte.TotalActivos}<br />Clientes Inactivos: {reporte.TotalInactivos}";
            }
            else
            {
                lblClienteActivosInactivos.Text = "No se pudo generar el reporte.";
            }
        }

        private void MostrarPromedioAntiguedadClientes()
        {
            ClienteReportesNegocio clienteNegocio = new ClienteReportesNegocio();
            ClienteReportes reporte = clienteNegocio.ObtenerPromedioAntiguedadClientes();

            if (reporte != null)
            {
                lblClientePromedioAntiguedad.Text = $"Promedio de antigüedad de los clientes: {reporte.PromedioAntiguedadDias:N2} días.";
            }
            else
            {
                lblClientePromedioAntiguedad.Text = "No se pudo calcular el promedio de antigüedad.";
            }
        }

        //--------------------------------------PRODUCTOS------------------------------
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

                lblProductosBajoStock.Text = texto;
            }
            else
            {
                lblProductosBajoStock.Text = "No se encontraron productos con bajo stock.";
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