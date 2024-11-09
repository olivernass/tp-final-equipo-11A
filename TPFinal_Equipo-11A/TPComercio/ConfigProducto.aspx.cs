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
                    MarcaNegocio negocioMarca = new MarcaNegocio();
                    List<Marca> listaMarca = negocioMarca.listar();
                    CategoriaNegocio negocioCategoria = new CategoriaNegocio();
                    List<Categoria> listaCategoria = negocioCategoria.listar();
                    codigo = Request.QueryString["Id"].ToString();
                    long numeroProducto = long.Parse(codigo);
                    producto = negocioProducto.verDetalle(numeroProducto);
                    ddlMarca.DataSource = listaMarca;
                    ddlMarca.DataTextField = "NombreMarca";
                    ddlMarca.DataValueField = "Id";
                    ddlMarca.DataBind();
                    ddlMarca.SelectedValue = producto.Marca.Id.ToString();
                    ddlCategoria.DataSource = listaCategoria;
                    ddlCategoria.DataTextField = "NombreCategoria";
                    ddlCategoria.DataValueField = "Id";
                    ddlCategoria.DataBind();
                    ddlCategoria.SelectedValue = producto.Categoria.Id.ToString();
                    txtCodigo.Text = producto.Id.ToString();
                    txtNombre.Text = producto.Nombre;
                    txtDescripcion.Text = producto.Descripcion;
                    txtStockActual.Text = producto.StockActual.ToString();
                    txtStockMinimo.Text = producto.StockMinimo.ToString();
                    txtPrecioCompra.Text = producto.Precio_Compra.ToString("F2");
                    txtPrecioVenta.Text = producto.Precio_Venta.ToString("F2");
                    txtPorcentajeGanancia.Text = producto.Porcentaje_Ganancia.ToString("F2");
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