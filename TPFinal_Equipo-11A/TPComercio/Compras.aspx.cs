using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
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
            if (ddlProveedor.SelectedValue == "")
            {
                lblMensajeProveedor.Visible = true;
                lblMensajeProveedor.Text = "Por favor, selecciona un proveedor.";
                rptCompras.Visible = false;
            }
            else
            {
                long compraId = Convert.ToInt64(Session["idCompra"]);
                if(compraId == 0)
                {
                    int proveedorId = Convert.ToInt32(ddlProveedor.SelectedValue);
                    Response.Redirect("FormularioCompra.aspx?id=" + proveedorId);
                }
                else
                {
                    CompraNegocio compraNegocio = new CompraNegocio();
                    if(compraNegocio.estaConfirmada(compraId))
                    {
                        int proveedorId = Convert.ToInt32(ddlProveedor.SelectedValue);
                        Response.Redirect("FormularioCompra.aspx?id=" + proveedorId);
                    }
                    else
                    {
                        Session.Remove("idCompra");
                        Response.Redirect("Compras.aspx");
                    }
                }
            }   
        }

        protected void lnkSeleccionar_Command(object sender, CommandEventArgs e)
        {
            long compraId = Convert.ToInt64(e.CommandArgument);
            int proveedorId = Convert.ToInt32(ddlProveedor.SelectedValue);
            LinkButton lnkButton = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lnkButton.NamingContainer;
            HiddenField hfEstado = (HiddenField)item.FindControl("hfEstado");
            string estado = hfEstado.Value;
            if (estado == "False")
            {
                Session["idCompra"] = compraId;
                Response.Redirect("FormularioCompra.aspx?id=" + proveedorId);
            }
            else 
            {
                Session["idCompra"] = compraId;
                Session["confirmada"] = 1;
                Response.Redirect("FormularioCompra.aspx?id=" + proveedorId);
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}