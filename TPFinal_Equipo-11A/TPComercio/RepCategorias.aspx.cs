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
    public partial class RepCategorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);

            if (!IsPostBack)
            {       
                
                //CATEGORIAS
                MostrarCategoriasConMasProductos();

                MostrarCategoriasConProductoMasCostoso();

                MostrarCategoriasSinProductos();

                MostrarCategoriasConProductosBajoStock();

                MostrarReporteCategoriasPorEstado();

                MostrarReporteCompletoDeCategorias();

            }
        }

        private void MostrarCategoriasConMasProductos()
        {
            CategoriaReportesNegocio categoriaRepoNegocio = new CategoriaReportesNegocio();
            List<CategoriaReportes> categoriasConMasProductos = categoriaRepoNegocio.ObtenerCategoriasConMasProductos();

            if (categoriasConMasProductos != null && categoriasConMasProductos.Count > 0)
            {

                var jsonData = new System.Text.StringBuilder();
                jsonData.Append("[['Categoría', 'Cantidad de Productos'],");

                foreach (var categoria in categoriasConMasProductos)
                {
                    jsonData.Append($"['{categoria.NombreCategoria}', {categoria.CantidadProductos}],");
                }

  
                jsonData.Length--;
                jsonData.Append("]");


                ClientScript.RegisterStartupScript(this.GetType(), "chartDataCategorias", $"var chartDataCategorias = {jsonData};", true);
            }
            else
            {              
                //lblCategoriaNombre.Text = "No se encontró ninguna categoría con productos.";
            }
        }

        private void MostrarCategoriasConProductoMasCostoso()
        {
            var negocio = new CategoriaReportesNegocio();
            var categoriasConProductoMasCostoso = negocio.ObtenerCategoriasConProductoMasCostoso();

            if (categoriasConProductoMasCostoso != null && categoriasConProductoMasCostoso.Count > 0)
            {

                var tableRows = new System.Text.StringBuilder();
                foreach (var item in categoriasConProductoMasCostoso)
                {
                    tableRows.Append("<tr>");
                    tableRows.Append($"<td>{item.NombreCategoria}</td>");
                    tableRows.Append($"<td>{item.NombreProducto}</td>");
                    tableRows.Append($"<td>{item.ProductoID}</td>");
                    tableRows.Append($"<td>{item.PrecioVenta:C}</td>");
                    tableRows.Append($"<td>{item.CantidadProductos}</td>");
                    tableRows.Append("</tr>");
                }

                ClientScript.RegisterStartupScript(this.GetType(), "tableDataCategorias",
                    $"document.getElementById('tableBodyCategorias').innerHTML = `{tableRows}`;", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "tableDataCategorias",
                    "document.getElementById('tableBodyCategorias').innerHTML = '<tr><td colspan=\"5\">No se encontraron categorías con productos activos.</td></tr>';", true);
            }
        }

        private void MostrarCategoriasConProductosBajoStock()
        {
            var negocio = new CategoriaReportesNegocio();
            var categoriasConBajoStock = negocio.ObtenerCategoriasConProductosBajoStock();

            if (categoriasConBajoStock != null && categoriasConBajoStock.Count > 0)
            {

                var chartData = new List<object[]>();
                chartData.Add(new object[] { "Categoría", "Cantidad de Productos con Bajo Stock" }); 

                foreach (var item in categoriasConBajoStock)
                {
                    chartData.Add(new object[] { item.NombreCategoria, item.StockActual });
                }

                
                string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(chartData);

           
                ClientScript.RegisterStartupScript(this.GetType(), "chartDataCategorias",
                    $"var chartDataCategorias = {jsonData};", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "chartDataCategorias",
                    "document.getElementById('chart_div_bajo_stock').innerHTML = '<p>No se encontraron categorías con productos bajo stock.</p>';", true);
            }
        }

        private void MostrarCategoriasSinProductos()
        {
            var negocio = new CategoriaReportesNegocio(); 
            var categoriasSinProductos = negocio.ObtenerCategoriasSinProductos();

            if (categoriasSinProductos != null && categoriasSinProductos.Count > 0)
            {
                string texto = "Categorías sin productos asociados:<br />";
                foreach (var item in categoriasSinProductos)
                {
                    texto += $"{item.NombreCategoria} (ID: {item.Id})<br />";
                }

                lblCategoriasSinProductos.Text = texto;
            }
            else
            {
                //lblCategoriasSinProductos.Text = "No se encontraron categorías sin productos.";
            }
        }


        private void MostrarReporteCategoriasPorEstado()
        {
            CategoriaReportesNegocio categoriaNegocio = new CategoriaReportesNegocio();
            CategoriaReportes reporte = categoriaNegocio.ObtenerReporteCategoriasPorEstado();
          
        }

        private void MostrarReporteCompletoDeCategorias()
        {
            CategoriaReportesNegocio categoriaNegocio = new CategoriaReportesNegocio();
            CategoriaReportes reporte = categoriaNegocio.ObtenerReporteCompletoDeCategorias();

            if (reporte != null)
            {
       
                var tableRows = new System.Text.StringBuilder();
                tableRows.Append("<tr>");
                tableRows.Append("<td>Categorías Activas</td>");
                tableRows.Append($"<td>{reporte.TotalActivos}</td>");
                tableRows.Append("</tr>");

                tableRows.Append("<tr>");
                tableRows.Append("<td>Categorías Inactivas</td>");
                tableRows.Append($"<td>{reporte.TotalInactivos}</td>");
                tableRows.Append("</tr>");

                tableRows.Append("<tr>");
                tableRows.Append("<td>Categorías Sin Productos</td>");
                tableRows.Append($"<td>{reporte.TotalSinProductos}</td>");
                tableRows.Append("</tr>");


                ClientScript.RegisterStartupScript(this.GetType(), "tableDataReporteCategorias",
                    $"document.getElementById('tableBodyReporteCategorias').innerHTML = `{tableRows}`;", true);
            }
            else
            {
       
                ClientScript.RegisterStartupScript(this.GetType(), "tableDataReporteCategorias",
                    "document.getElementById('tableBodyReporteCategorias').innerHTML = '<tr><td colspan=\"2\">No se pudo generar el reporte.</td></tr>';", true);
            }
        }


    }
}