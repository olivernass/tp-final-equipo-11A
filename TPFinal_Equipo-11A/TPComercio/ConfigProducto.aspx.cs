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
        public List<Proveedor> listaproveedoressinproducto{ get; set; }
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
                    listaproveedoressinproducto = negocioProveedor.listarProvSinProductoAsociado(numeroProducto);
                    ddlProveedorProducto.DataSource = listaproveedores;
                    ddlProveedorProducto.DataTextField = "Siglas";
                    ddlProveedorProducto.DataValueField = "Id";
                    ddlProveedorProducto.DataBind();
                    ddlProveedorNuevo.DataSource = listaproveedoressinproducto;
                    ddlProveedorNuevo.DataTextField = "Siglas";
                    ddlProveedorNuevo.DataValueField = "Id";
                    ddlProveedorNuevo.DataBind();
                }
            }
        }
        protected void btnGuardarProveedor_Click(object sender, EventArgs e)
        {
            long idProducto = Convert.ToInt64(hfIdProducto.Value);
            // Obtener el ID del proveedor seleccionado
            int idproveedor = Convert.ToInt32(ddlProveedorNuevo.SelectedValue);
            // Lógica para agregar el producto al proveedor
            ProveedorNegocio negocio = new ProveedorNegocio();
            negocio.agregarProducto(idProducto, idproveedor);
            // Redirigir después de guardar
            Response.Redirect("Inventario.aspx");
        }
    }
}