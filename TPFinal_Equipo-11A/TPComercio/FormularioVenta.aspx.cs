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
    public partial class FormularioVenta : System.Web.UI.Page
    {
        public List<Detalle_Venta> listaDetalleVenta { get; set; }
        public string codigo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);

            codigo = Request.QueryString["idCliente"].ToString();
            int codigoprov = int.Parse(codigo);
            if (!IsPostBack)
            {
                cargarProductos();
            }
        }

        private void cargarProductos()
        {
            Detalle_Venta_Negocio negocio = new Detalle_Venta_Negocio();
            listaDetalleVenta = negocio.listarProductos();
            rptDetalleVenta.DataSource = listaDetalleVenta;
            rptDetalleVenta.DataBind();
        }

        protected void rptDetalleVenta_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int idventa = Convert.ToInt32(Session["idVenta"]);
                TextBox txtCantidad = (TextBox)e.Item.FindControl("txtCantidad");
                if (idventa == 1)
                {
                    txtCantidad.Enabled = false;

                }
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Session.Remove("ListaDetalleVenta");
            Session.Remove("idVenta");
            Response.Redirect("Ventas.aspx");
        }

        protected void btnGenerarVenta_Click(object sender, EventArgs e)
        {
            List<Detalle_Venta> listaDetalleVenta = Session["ListaDetalleVenta"] as List<Detalle_Venta>;
            Detalle_Venta_Negocio negocioDetail = new Detalle_Venta_Negocio();
            if (listaDetalleVenta != null)
            {
                negocioDetail.agregarProductos(listaDetalleVenta);
            }
            Session.Remove("ListaDetalleVenta");
            Session.Remove("idVenta");
            Response.Redirect("Ventas.aspx");
        }
        protected void btnActualizarMontos_Click(object sender, EventArgs e)
        {
            int codigoCliente = int.Parse(codigo);
            Venta venta = new Venta
            {
                Cliente = new Cliente { Id = int.Parse(codigo) },
                PrecioTotal = 0
            };
            VentaNegocio ventaNegocio = new VentaNegocio();
            ventaNegocio.agregarVenta(venta);
            long ultimaventa = ventaNegocio.TraerUltimo();
            if (ultimaventa == 0)
            {
                return;
            }
            foreach (RepeaterItem item in rptDetalleVenta.Items)
            {
                TextBox txtCantidad = (TextBox)item.FindControl("txtCantidad");
                Label lblProductoId = (Label)item.FindControl("lblProductoId");
                Label lblProductoPrecioVenta = (Label)item.FindControl("lblProductoPrecioVenta");
                Label lblProductoStockActual = (Label)item.FindControl("lblProductoStockActual");
                Label lblProductoStockMinimo = (Label)item.FindControl("lblProductoStockMinimo");
                if (txtCantidad != null && !string.IsNullOrEmpty(txtCantidad.Text))
                {
                    long productoId = long.Parse(lblProductoId.Text);
                    int stockactual = int.Parse(lblProductoStockActual.Text);
                    int stockminimo = int.Parse(lblProductoStockMinimo.Text);
                    string precioTexto = lblProductoPrecioVenta.Text.Replace("$", "").Replace("€", "");

                    // Convertir a decimal de forma segura
                    decimal precioVenta = 0;
                    if (Decimal.TryParse(precioTexto, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out precioVenta))
                    {
                        int cantidad = 0;
                        if (int.TryParse(txtCantidad.Text, out cantidad))
                        {   
                            if(cantidad > stockactual)
                            {
                                //PATEA SI LA CANTIDAD ES A VENDER ES MAYOR AL STOCK ACTUAL, DEBERIA DE MOSTRAR ALERTA.
                                Response.Redirect("Ventas.aspx");
                            }
                            decimal subtotal = Math.Round(precioVenta * cantidad, 2);
                            if (listaDetalleVenta == null)
                            {
                                Detalle_Venta_Negocio detailneg = new Detalle_Venta_Negocio();
                                listaDetalleVenta = new List<Detalle_Venta>();
                                listaDetalleVenta = detailneg.listarProductos();
                            }
                            Detalle_Venta detalle_Venta = listaDetalleVenta.FirstOrDefault(d => d.Producto.Id == productoId);
                            if (detalle_Venta != null)
                            {
                                detalle_Venta.Producto.Id = productoId;
                                detalle_Venta.Cantidad = cantidad;
                                detalle_Venta.SubTotal = subtotal;
                                detalle_Venta.Precio_Venta_Unitario = precioVenta;
                                detalle_Venta.Venta = new Venta();
                                detalle_Venta.Venta.Cliente = new Cliente();
                                detalle_Venta.Venta.Cliente.Id = codigoCliente;
                                detalle_Venta.Venta.Id = ultimaventa;
                            }
                            else
                            {
                                detalle_Venta = new Detalle_Venta
                                {
                                    Producto = new Producto { Id = productoId },
                                    Precio_Venta_Unitario = precioVenta,
                                    Cantidad = cantidad,
                                    SubTotal = subtotal,
                                    Venta = new Venta { Id = ultimaventa, Cliente = new Cliente { Id = codigoCliente } }
                                };
                                listaDetalleVenta.Add(detalle_Venta);
                            }
                        }
                    }
                }
            }
            Session["ListaDetalleVenta"] = listaDetalleVenta;
            Session["idVenta"] = 1;
            rptDetalleVenta.DataSource = listaDetalleVenta;
            rptDetalleVenta.DataBind();
            btnGenerarVenta.Visible = true;
            btnActualizarMontos.Visible = false;
            btnVolver.Visible = false;
        }
    }
}