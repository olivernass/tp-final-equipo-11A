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
    public partial class Inventario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                cargarProductos();
            }
        }
        private void cargarProductos()
        {
            ProductoNegocio negocio = new ProductoNegocio();
            List<Producto> listaProducto = negocio.listar();
            rptProductos.DataSource = listaProducto;
            rptProductos.DataBind();
        }

        protected void rptProductos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Inactivar")
            {
                long idProducto = Convert.ToInt64(e.CommandArgument);
                Producto productoaEliminar = new Producto();
                {
                    productoaEliminar.Id = idProducto;
                }
                ProductoNegocio negocio = new ProductoNegocio();
                negocio.eliminarL(productoaEliminar);
                cargarProductos();
            }
            else if (e.CommandName == "Activar")
            {
                long idProducto = Convert.ToInt64(e.CommandArgument);
                Producto productoaActivar = new Producto();
                {
                    productoaActivar.Id = idProducto;
                }
                ProductoNegocio negocio = new ProductoNegocio();
                negocio.activar(productoaActivar);
                cargarProductos();
            }
        }

    }
}