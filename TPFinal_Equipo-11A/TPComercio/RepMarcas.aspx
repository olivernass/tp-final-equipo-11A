<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RepMarcas.aspx.cs" Inherits="TPComercio.RepMarcas" %>

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

    <%--<div class="containerRepMarcas">
    <div id="chart_div" style="width: 100%; height: 700px;"></div>
    <div id="expensive_chart_div" style="width: 100%; height: 500px;"></div>
    </div>--%>


    <div class="containerRepMarcas">
        <div style="padding-left: 15px;">
            <h2 class="mb-4 text-center">Marcas con Mayor Cantidad de Productos</h2>
            <div id="chart_div" class="chart-section"></div>
            <%--<asp:Label runat="server" ID="lblMarcaNombre"></asp:Label>--%>
        </div>
        <div>
            <h2 class="mb-4">Top 10 Marcas con Productos Más Costosos</h2>
            <div style="padding-top: 35px;">
                <table class="table table-primary table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>Marca</th>
                            <th>Producto</th>
                            <th>ID Producto</th>
                            <th>Precio</th>
                            <th>Cantidad de Productos</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- El contenido dinámico se llenará aquí -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="containerRepMarcas1">
        <div>
            <h2 class="mb-4 text-center">Marcas con Productos Bajos de Stock</h2>
            <div id="chart_div_bajo_stock" class="chart-section"></div>
            <%-- <asp:Label runat="server" ID="lblMarcasProductosBajoStock"></asp:Label>--%>
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
                    <tbody id="tableBodyReporteMarcas">
                        <!-- El contenido dinámico se llenará aquí -->
                    </tbody>
                </table>
                <asp:Label runat="server" ID="lblMarcasSinProductos"></asp:Label>
                <%--<asp:Label runat="server" ID="lblMarcasActivasInactivas" style="display: none;"></asp:Label>--%>
            </div>
        </div>
    </div>







    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            // Usa los datos del servidor
            var data = google.visualization.arrayToDataTable(chartData);

            // Configuración del gráfico
            var options = {
                hAxis: { title: 'Marcas' },
                vAxis: { title: 'Cantidad de Productos' },
                legend: { position: 'none' },
                colors: ['#4BB0EA'],
                width: 800,
                height: 600
            };

            // Dibujar el gráfico en el contenedor
            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
            chart.draw(data, options);
        }
    </script>

    <script type="text/javascript">
        // Cargar la API de Google Charts
        google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            // Verificar que los datos existen
            if (typeof chartData !== 'undefined') {
                // Crear el DataTable para Google Charts
                var data = google.visualization.arrayToDataTable(chartData);

                // Configurar las opciones del gráfico
                var options = {
                    hAxis: {
                        title: 'Cantidad de Productos',
                        minValue: 0
                    },
                    vAxis: {
                        title: 'Marcas'
                    },
                    colors: ['#4BB0EA'],
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
