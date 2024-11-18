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
                Detalle_Compra_Negocio negocio = new Detalle_Compra_Negocio();
                listaDetalle = negocio.listarProductos(codigoprov);
                rptDetalleCompra.DataSource = listaDetalle;
                rptDetalleCompra.DataBind();
                
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
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal", "mostrarModal();", true);
            }
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
                if (txtCantidad != null && !string.IsNullOrEmpty(txtCantidad.Text))
                {
                    long productoId = long.Parse(lblProductoId.Text);
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
                                detalleCompra.Cantidad = cantidad;
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

        }
    }
}


