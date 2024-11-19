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
    public partial class FormularioCompra : System.Web.UI.Page
    {
        public List<Detalle_Compra> listaDetalle { get; set; }

        public List<Detalle_Compra> productosdeOC { get; set; }
        public string codigo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            codigo = Request.QueryString["id"].ToString();
            int codigoprov = int.Parse(codigo);
            if (!IsPostBack)
            {
                if (Session["idCompra"] != null)
                {
                    int confirmada = Convert.ToInt32(Session["confirmada"]);
                    if(confirmada==1)
                    {
                       
                       long compraId = Convert.ToInt64(Session["idCompra"]);
                       Detalle_Compra_Negocio negoc1o = new Detalle_Compra_Negocio();
                       listaDetalle = negoc1o.listar2(compraId);
                       rptDetalleCompra.DataSource = listaDetalle;
                       rptDetalleCompra.DataBind();
                       btnActualizar.Visible = false;
                       btnNuevaOC.Visible = false;
                       btnConfirmarDescarga.Visible = false;
                       Session.Remove("confirmada");
                       Session.Remove("idCompra");
                       Session.Remove("ListaDetalleCompra");
                    }
                    else
                    {
                        long compraId = Convert.ToInt64(Session["idCompra"]);
                        Detalle_Compra_Negocio negoc1o = new Detalle_Compra_Negocio();
                        listaDetalle = negoc1o.listar(compraId);
                        rptDetalleCompra.DataSource = listaDetalle;
                        rptDetalleCompra.DataBind();
                        Session["ListaDetalleCompra"] = listaDetalle;
                        btnActualizar.Visible = false;
                        btnNuevaOC.Visible = false;
                        btnConfirmarDescarga.Visible = true;
                        Session.Remove("idCompra");
                    }
                }
                else
                {
                    Detalle_Compra_Negocio negocio = new Detalle_Compra_Negocio();
                    listaDetalle = negocio.listarProductos(codigoprov);
                    rptDetalleCompra.DataSource = listaDetalle;
                    rptDetalleCompra.DataBind();
                    btnNuevaOC.Visible = false;
                    btnConfirmarDescarga.Visible = false;
                }
            }
            VerificarCantidades();
        }

        private void VerificarCantidades()
        {
            bool cantidadesValidas = true;

            foreach (RepeaterItem item in rptDetalleCompra.Items)
            {
                TextBox txtCantidad = (TextBox)item.FindControl("txtCantidad");

                if (txtCantidad != null)
                {
                    int cantidad = 0;
                    if (!int.TryParse(txtCantidad.Text, out cantidad) || cantidad < 0)
                    {
                        cantidadesValidas = false;
                        break;
                    }
                }
            }
            btnActualizar.Enabled = cantidadesValidas;
        }

        protected void btnNuevaOC_Click(object sender, EventArgs e)
        {
            List<Detalle_Compra> listaDetalleCompra = Session["ListaDetalleCompra"] as List<Detalle_Compra>;
            Detalle_Compra_Negocio negocioDetail = new Detalle_Compra_Negocio();
            if (listaDetalleCompra != null)
            {
                negocioDetail.agregarProductos(listaDetalleCompra);
            }
            Response.Redirect("Compras.aspx");
            Session.Remove("ListaDetalleCompra");
        }
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            int codigoprov = int.Parse(codigo);
            Compra compra = new Compra
            {
                Proveedor = new Proveedor { Id = int.Parse(codigo) },
                PrecioTotal = 0
            };
            CompraNegocio compraNegocio = new CompraNegocio();
            compraNegocio.agregarCompra(compra);
            long ultimacompra = compraNegocio.TraerUltimo();
            if (ultimacompra == 0)
            {
                return;
            }
            foreach (RepeaterItem item in rptDetalleCompra.Items)
            {
                TextBox txtCantidad = (TextBox)item.FindControl("txtCantidad");
                Label lblProductoId = (Label)item.FindControl("lblProductoId");
                Label lblPrecioCompra = (Label)item.FindControl("lblProductoPrecioCompra");
                Label lblProductoStockActual = (Label)item.FindControl("lblProductoStockActual");
                if (txtCantidad != null && !string.IsNullOrEmpty(txtCantidad.Text))
                {
                    long productoId = long.Parse(lblProductoId.Text);
                    int cantidadvieja = int.Parse(lblProductoStockActual.Text);
                    string precioTexto = lblPrecioCompra.Text.Replace("$", "").Replace("€", "");

                    // Convertir a decimal de forma segura
                    decimal precioCompra = 0;
                    if (Decimal.TryParse(precioTexto, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out precioCompra))
                    {
                        int cantidad = 0;
                        if (int.TryParse(txtCantidad.Text, out cantidad))
                        {
                            decimal subtotal = Math.Round(precioCompra * cantidad, 2);
                            if (listaDetalle == null)
                            {
                                Detalle_Compra_Negocio detailneg = new Detalle_Compra_Negocio();
                                listaDetalle = new List<Detalle_Compra>(); // Inicializa una lista vacía si es null
                                listaDetalle = detailneg.listarProductos(codigoprov);
                            }
                            Detalle_Compra detalleCompra = listaDetalle.FirstOrDefault(d => d.Producto.Id == productoId);
                            if (detalleCompra != null)
                            {
                                detalleCompra.Producto.Id = productoId;
                                detalleCompra.Cantidad = cantidad;
                                detalleCompra.CantidadVieja = cantidadvieja;
                                detalleCompra.Subtotal = subtotal;
                                detalleCompra.Precio_Compra_Unitario = precioCompra;
                                detalleCompra.Compra = new Compra();
                                detalleCompra.Compra.Proveedor = new Proveedor();
                                detalleCompra.Compra.Proveedor.Id = codigoprov;
                                detalleCompra.Compra.Id = ultimacompra;
                            }
                            else
                            {
                                detalleCompra = new Detalle_Compra
                                {
                                    Producto = new Producto { Id = productoId },
                                    Precio_Compra_Unitario = precioCompra,
                                    Cantidad = cantidad,
                                    Subtotal = subtotal,
                                    Compra = new Compra { Id = ultimacompra, Proveedor = new Proveedor { Id = codigoprov } }
                                };
                                listaDetalle.Add(detalleCompra);
                            }   
                        }     
                    }
                }
            }
            Session["ListaDetalleCompra"] = listaDetalle;
            rptDetalleCompra.DataSource = listaDetalle;
            rptDetalleCompra.DataBind();
            btnNuevaOC.Visible = true;
            btnActualizar.Visible = false;

        }

        protected void rptDetalleCompra_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                TextBox txtCantidad = (TextBox)e.Item.FindControl("txtCantidad");
                if (Session["idCompra"] != null)
                {
                    txtCantidad.Enabled = false;
                    
                }
            }
        }

        protected void btnConfirmarDescarga_Click(object sender, EventArgs e)
        {
            List<Detalle_Compra> listaDetalleCompra = Session["ListaDetalleCompra"] as List<Detalle_Compra>;
            Detalle_Compra_Negocio negocioDetail = new Detalle_Compra_Negocio();
            CompraNegocio compraNegocio = new CompraNegocio();
            long codigoCompra = 0;
            if (listaDetalleCompra != null)
            {
                foreach (Detalle_Compra detalle in listaDetalleCompra)
                {
                    negocioDetail.actualizarStock(detalle);
                    codigoCompra = detalle.Compra.Id;
                }
            }
            compraNegocio.confirmarCompra(codigoCompra);
            Response.Redirect("Compras.aspx");
            Session.Remove("ListaDetalleCompra");
            Session.Remove("idCompra");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Compras.aspx");
            Session.Remove("ListaDetalleCompra");
            Session.Remove("idCompra");
        }
    }
}


