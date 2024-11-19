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
    public partial class RepMarcas : System.Web.UI.Page
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

                MostrarReporteCompletoDeMarcas();
            }
        }




        private void MostrarMarcasConMasProductos()
        {
            MarcaReportesNegocio marcaRepoNegocio = new MarcaReportesNegocio();
            List<MarcaReportes> marcasConMasProductos = marcaRepoNegocio.ObtenerMarcasConMasProductos();

            if (marcasConMasProductos != null && marcasConMasProductos.Count > 0)
            {
                // Construir datos en formato JSON
                var jsonData = new System.Text.StringBuilder();
                jsonData.Append("[['Marca', 'Cantidad de Productos'],");

                foreach (var marca in marcasConMasProductos)
                {
                    jsonData.Append($"['{marca.NombreMarca}', {marca.CantidadProductos}],");
                }

                // Elimina la última coma y cierra el JSON
                jsonData.Length--;
                jsonData.Append("]");

                // Pasar el JSON al cliente usando un control oculto o literal
                ClientScript.RegisterStartupScript(this.GetType(), "chartData", $"var chartData = {jsonData};", true);

            }
            else
            {
                //lblMarcaNombre.Text = "No se encontró ninguna marca con productos.";
            }
        }

        //private void MostrarMarcasConProductoMasCostoso()
        //{
        //    var negocio = new MarcaReportesNegocio();
        //    var marcasConProductoMasCostoso = negocio.ObtenerMarcasConProductoMasCostoso();

        //    if (marcasConProductoMasCostoso != null && marcasConProductoMasCostoso.Count > 0)
        //    {
        //        string texto = "Marcas con el/los producto(s) más costoso(s):<br />";
        //        foreach (var item in marcasConProductoMasCostoso)
        //        {
        //            texto += $"Marca: {item.NombreMarca} (ID: {item.Id})<br />";
        //            texto += $"Producto: {item.NombreProducto} (ID: {item.ProductoID}) - Precio: {item.PrecioVenta:C}<br />";
        //            texto += $"Cantidad de productos en la marca: {item.CantidadProductos}<br /><br />";
        //        }

        //        lblReporteMarcas.Text = texto;
        //    }
        //    else
        //    {
        //        lblReporteMarcas.Text = "No se encontraron marcas con productos activos.";
        //    }
        //}

        private void MostrarMarcasConProductoMasCostoso()
        {
            var negocio = new MarcaReportesNegocio();
            var marcasConProductoMasCostoso = negocio.ObtenerMarcasConProductoMasCostoso();

            if (marcasConProductoMasCostoso != null && marcasConProductoMasCostoso.Count > 0)
            {
                // Generar contenido HTML para las filas de la tabla
                var tableRows = new System.Text.StringBuilder();
                foreach (var item in marcasConProductoMasCostoso)
                {
                    tableRows.Append("<tr>");
                    tableRows.Append($"<td>{item.NombreMarca}</td>");
                    tableRows.Append($"<td>{item.NombreProducto}</td>");
                    tableRows.Append($"<td>{item.ProductoID}</td>");
                    tableRows.Append($"<td>{item.PrecioVenta:C}</td>");
                    tableRows.Append($"<td>{item.CantidadProductos}</td>");
                    tableRows.Append("</tr>");
                }

                // Pasar las filas al cliente
                ClientScript.RegisterStartupScript(this.GetType(), "tableData",
                    $"document.getElementById('tableBody').innerHTML = `{tableRows}`;", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "tableData",
                    "document.getElementById('tableBody').innerHTML = '<tr><td colspan=\"5\">No se encontraron marcas con productos activos.</td></tr>';", true);
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
                    texto += $"{item.NombreMarca} (ID: {item.Id})<br />";
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
                // Generar JSON para Google Charts
                var chartData = new List<object[]>();
                chartData.Add(new object[] { "Marca", "Cantidad de Productos con Bajo Stock" }); // Cabecera

                foreach (var item in marcasConBajoStock)
                {
                    chartData.Add(new object[] { item.NombreMarca, item.StockActual });
                }

                // Serializar datos a JSON
                string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(chartData);

                // Registrar el JSON en el cliente
                ClientScript.RegisterStartupScript(this.GetType(), "chartData",
                    $"var chartData = {jsonData};", true);
            }
            else
            {
                //lblMarcasProductosBajoStock.Text = "No se encontraron marcas con productos bajo stock.";
            }
        }

        private void MostrarReporteMarcasPorEstado()
        {
            MarcaReportesNegocio marcaNegocio = new MarcaReportesNegocio();
            MarcaReportes reporte = marcaNegocio.ObtenerReporteMarcasPorEstado();

            //if (reporte != null)
            //{
            //    lblMarcasActivasInactivas.Text = $"Marcas Activas: {reporte.TotalActivos}<br />Marcas Inactivas: {reporte.TotalInactivos}";
            //}
            //else
            //{
            //    lblMarcasActivasInactivas.Text = "No se pudo generar el reporte.";
            //}
        }

        private void MostrarReporteCompletoDeMarcas()
        {
            MarcaReportesNegocio marcaNegocio = new MarcaReportesNegocio();
            MarcaReportes reporte = marcaNegocio.ObtenerReporteCompletoDeMarcas();

            if (reporte != null)
            {
                // Generar contenido HTML para las filas de la tabla
                var tableRows = new System.Text.StringBuilder();
                tableRows.Append("<tr>");
                tableRows.Append("<td>Marcas Activas</td>");
                tableRows.Append($"<td>{reporte.TotalActivos}</td>");
                tableRows.Append("</tr>");

                tableRows.Append("<tr>");
                tableRows.Append("<td>Marcas Inactivas</td>");
                tableRows.Append($"<td>{reporte.TotalInactivos}</td>");
                tableRows.Append("</tr>");

                tableRows.Append("<tr>");
                tableRows.Append("<td>Marcas Sin Productos</td>");
                tableRows.Append($"<td>{reporte.TotalSinProductos}</td>");
                tableRows.Append("</tr>");

                // Insertar las filas en el cliente
                ClientScript.RegisterStartupScript(this.GetType(), "tableDataReporte",
                    $"document.getElementById('tableBodyReporteMarcas').innerHTML = `{tableRows}`;", true);
            }
            else
            {
                // Si no hay datos, muestra un mensaje en la tabla
                ClientScript.RegisterStartupScript(this.GetType(), "tableDataReporte",
                    "document.getElementById('tableBodyReporteMarcas').innerHTML = '<tr><td colspan=\"2\">No se pudo generar el reporte.</td></tr>';", true);
            }
        }




    }
}