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
    public partial class Compras : System.Web.UI.Page
    {
        public List<Proveedor> listaproveedores { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                ProveedorNegocio negocioProveedor = new ProveedorNegocio();
                listaproveedores = negocioProveedor.listar();
                ddlProveedor.DataSource = listaproveedores;
                ddlProveedor.DataTextField = "Siglas";
                ddlProveedor.DataValueField = "Id";
                ddlProveedor.DataBind();
                ListItem itemVacio = new ListItem("Selecciona un proveedor", "");
                ddlProveedor.Items.Insert(0, itemVacio);
            }
        }

        protected void ddlProveedor_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlProveedor.SelectedValue == "")
            {
                lblMensajeProveedor.Visible = true;
                lblMensajeProveedor.Text = "Por favor, selecciona un proveedor.";
                rptCompras.Visible = false;
            }
            else
            {
                rptCompras.Visible = true;
                lblMensajeProveedor.Visible=false;
                int proveedorId = Convert.ToInt32(ddlProveedor.SelectedValue);
                List<Compra> compras = new List<Compra>();
                CompraNegocio negocio = new CompraNegocio();
                compras = negocio.listarCompras(proveedorId);
                rptCompras.DataSource = compras;
                rptCompras.DataBind();

            }
        }

        protected void btnGenerarCompra_Click(object sender, EventArgs e)
        {
            int proveedorId = Convert.ToInt32(ddlProveedor.SelectedValue);
            //Compra compra = new Compra();
            //compra.Proveedor = new Proveedor();
            //compra.Proveedor.Id = proveedorId;
            //compra.PrecioTotal = 0;
            //CompraNegocio neg = new CompraNegocio();
            //neg.agregarCompra(compra);
            //long ultimacompra = neg.TraerUltimo();
            //if(ultimacompra == 0 )
            //{
            //    return;
            //}
            Response.Redirect("FormularioCompra.aspx?id=" + proveedorId);
        }

        protected void lnkSeleccionar_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Ver detalle")
            {
                // Obtener el ID de la fila seleccionada desde el CommandArgument
                string id = e.CommandArgument.ToString();

                // Redirigir a la página de detalles pasando el ID como parámetro en la URL
                Response.Redirect("FormularioCompra.aspx?id=" + id);
            }
        }
    }
}