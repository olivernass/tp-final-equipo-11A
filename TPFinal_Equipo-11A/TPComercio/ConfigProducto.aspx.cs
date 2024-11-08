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
    public partial class ConfigProducto : System.Web.UI.Page
    {
        public string codigo { get; set; }
        public Producto producto { get; set; }
        public List<Proveedor> listaproveedores { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["Id"] != null)
                {
                    ProductoNegocio negocioProducto = new ProductoNegocio();
                    ProveedorNegocio negocioProveedor = new ProveedorNegocio();
                    codigo = Request.QueryString["Id"].ToString();
                    long numeroProducto = long.Parse(codigo);
                    producto = negocioProducto.verDetalle(numeroProducto);
                    listaproveedores = negocioProveedor.listarxid(numeroProducto);
                    ddlProveedorProducto.DataSource = listaproveedores;
                    ddlProveedorProducto.DataTextField = "Siglas";
                    ddlProveedorProducto.DataValueField = "Id";
                    ddlProveedorProducto.DataBind();
                }
            }
        }
    }
}