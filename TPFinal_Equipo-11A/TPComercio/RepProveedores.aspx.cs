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
    public partial class RepProveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarProveedoresConMasProductos();

                MostrarProveedoresConProductoMasCostoso();

                MostrarProveedoresSinProductos();

                MostrarProveedoresConProductosBajoStock();

                MostrarReporteProveedoresPorEstado();
            }
        }

        private void MostrarProveedoresConMasProductos()
        {
            ProveedorReportesNegocio proveedorRepoNegocio = new ProveedorReportesNegocio();
            List<ProveedorReportes> proveedoresConMasProductos = proveedorRepoNegocio.ObtenerProveedoresConMasProductos();

            if (proveedoresConMasProductos != null && proveedoresConMasProductos.Count > 0)
            {

                string proveedoresTexto = "Proveedores con más productos: <br />";
                foreach (var proveedor in proveedoresConMasProductos)
                {
                    proveedoresTexto += $"ID: {proveedor.Id}, Nombre: {proveedor.Nombre}, Cantidad de productos: {proveedor.CantidadProductos}<br />";
                }

                lblProveedorConMasProductos.Text = proveedoresTexto;
                lblProveedorConMasProductosID.Text = string.Empty; 
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
    }
}