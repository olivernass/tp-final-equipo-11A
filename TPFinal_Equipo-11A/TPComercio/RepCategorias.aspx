<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RepCategorias.aspx.cs" Inherits="TPComercio.RepCategorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar position-fixed">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="RepMarcas.aspx">Marcas
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepCategorias.aspx">Categorías
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepProveedores.aspx">Proveedores
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepClientes.aspx">Clientes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepProductos.aspx">Productos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepVentas.aspx">Ventas
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="RepCompras.aspx">Compras
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>


    <div class="containerRepMarcas">
        <div style="padding-left: 65px;">
            <h2 class="mb-4 text-center">Categorías con Mayor Cantidad de Productos</h2>
            <div id="chart_div_categorias" class="chart-section"></div>
        </div>
        <div>
            <h2 class="mb-4">Top 10 Categorías con Productos Más Costosos</h2>
            <div style="padding-top: 35px;">
                <table class="table table-primary table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>Categoría</th>
                            <th>Producto</th>
                            <th>ID Producto</th>
                            <th>Precio</th>
                            <th>Cantidad de Productos</th>
                        </tr>
                    </thead>
                    <tbody id="tableBodyCategorias">
                        <!-- El contenido dinámico se llenará aquí -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="containerRepMarcas1">
        <div>
            <h2 class="mb-4 text-center">Categorías con Productos Bajo Stock</h2>
            <div id="chart_div_bajo_stock" class="chart-section"></div>
            <%-- <asp:Label runat="server" ID="lblCategoriasProductosBajoStock"></asp:Label>--%>
        </div>
        <div>
            <div style="padding-top: 170px; padding-left: 3px;">
                <table class="table table-primary table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>Descripción</th>
                            <th>Cantidad</th>
                        </tr>
                    </thead>
                    <tbody id="tableBodyReporteCategorias">
                        <!-- El contenido dinámico se llenará aquí -->
                    </tbody>
                </table>
                <asp:Label runat="server" ID="lblCategoriasSinProductos"></asp:Label>
            </div>
        </div>
    </div>




    <%--<asp:Label runat="server" ID="lblCategoriaNombre"></asp:Label>--%>
    <asp:Label runat="server" ID="lblCategoriaID"></asp:Label>
    <asp:Label runat="server" ID="lblReporteCategorias"></asp:Label>
    
    <asp:Label runat="server" ID="lblCategoriasProductosBajoStock"></asp:Label>
    <asp:Label runat="server" ID="lblCategoriasActivasInactivas"></asp:Label>


    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawCategoryChart);

        function drawCategoryChart() {
            // Usa los datos del servidor
            var data = google.visualization.arrayToDataTable(chartDataCategorias);

            // Configuración del gráfico
            var options = {
                hAxis: { title: 'Categorías' },
                vAxis: { title: 'Cantidad de Productos' },
                legend: { position: 'none' },
                colors: ['#4BB0EA'],
                width: 800,
                height: 600
            };

            // Dibujar el gráfico en el contenedor
            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div_categorias'));
            chart.draw(data, options);
        }
</script>

    <script type="text/javascript">
        // Cargar la API de Google Charts
        google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(drawChartCategorias);

        function drawChartCategorias() {
            // Verificar que los datos existen
            if (typeof chartDataCategorias !== 'undefined') {
                // Crear el DataTable para Google Charts
                var data = google.visualization.arrayToDataTable(chartDataCategorias);

                // Configurar las opciones del gráfico
                var options = {
                    hAxis: {
                        title: 'Cantidad de Productos con Bajo Stock',
                        minValue: 0
                    },
                    vAxis: {
                        title: 'Categorías'
                    },
                    colors: ['#4BB0EA'], // Color personalizado
                    width: 800,
                    height: 500,
                    legend: { position: 'none' }
                };

                // Dibujar el gráfico
                var chart = new google.visualization.BarChart(document.getElementById('chart_div_bajo_stock'));
                chart.draw(data, options);
            }
        }
</script>


</asp:Content>
