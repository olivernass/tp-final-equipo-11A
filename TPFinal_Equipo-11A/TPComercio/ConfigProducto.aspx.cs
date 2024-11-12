using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
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
            ProductoNegocio negocioProducto = new ProductoNegocio();
            codigo = Request.QueryString["Id"].ToString();
            long numeroProducto = long.Parse(codigo);
            producto = negocioProducto.verDetalle(numeroProducto);
            if (!IsPostBack)
            {
                if (Request.QueryString["Id"] != null)
                {
                    ProveedorNegocio negocioProveedor = new ProveedorNegocio();
                    MarcaNegocio negocioMarca = new MarcaNegocio();
                    List<Marca> listaMarca = negocioMarca.listar();
                    CategoriaNegocio negocioCategoria = new CategoriaNegocio();
                    List<Categoria> listaCategoria = negocioCategoria.listar();
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
                    txtPorcentajeGanancia.Text = producto.Porcentaje_Ganancia.ToString("F0");
                    lblActivo.Text = producto.Activo.ToString();
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
                    if (producto.Activo)
                    {
                        btnInactivarActivar.Text = "Desactivar";
                    }
                    else
                    {
                        btnInactivarActivar.Text = "Activar";
                    }
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
            Response.Redirect("ConfigProducto.aspx?id=" + producto.Id);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            ProductoNegocio negocio = new ProductoNegocio();
            Producto producto = new Producto();
            producto.Marca = new Marca();
            producto.Categoria = new Categoria();
            producto.Id = long.Parse(txtCodigo.Text);
            producto.Nombre = txtNombre.Text;
            producto.Descripcion = txtDescripcion.Text;
            producto.Marca.Id = int.Parse(ddlMarca.SelectedValue);
            producto.Categoria.Id = int.Parse(ddlCategoria.SelectedValue);
            producto.StockActual = int.Parse(txtStockActual.Text);
            producto.StockMinimo = int.Parse(txtStockMinimo.Text);
            producto.Precio_Compra = decimal.Parse(txtPrecioCompra.Text);
            decimal precioc, porcentaje;
            precioc = decimal.Parse(txtPrecioCompra.Text);
            porcentaje = decimal.Parse(txtPorcentajeGanancia.Text);
            producto.Precio_Venta = precioc * (1 + porcentaje / 100);
            producto.Porcentaje_Ganancia = decimal.Parse(txtPorcentajeGanancia.Text);
            negocio.modificar(producto);
            Response.Redirect("ConfigProducto.aspx?id=" + producto.Id);
        }

        protected void btnInactivarActivar_Click(object sender, EventArgs e)
        {
            ProductoNegocio negocio = new ProductoNegocio();
            Producto producto = new Producto();
            producto.Activo = bool.Parse(lblActivo.Text.ToString());
            if (producto.Activo)
            {
                producto.Id = long.Parse(txtCodigo.Text);
                negocio.eliminarL(producto);
                Response.Redirect("ConfigProducto.aspx?id=" + producto.Id);
            }
            else
            {
                producto.Id = long.Parse(txtCodigo.Text);
                negocio.activar(producto);
                Response.Redirect("ConfigProducto.aspx?id=" + producto.Id);
            }
        }
        protected void txtPorcentajeGanancia_TextChanged(object sender, EventArgs e)
        {
            decimal precioCompra = decimal.Parse(txtPrecioCompra.Text);
            decimal porcentajeGanancia = decimal.Parse(txtPorcentajeGanancia.Text);
            txtPrecioVenta.Text = Convert.ToString(precioCompra * (1 + porcentajeGanancia / 100));
        }

        protected void txtPrecioCompra_TextChanged(object sender, EventArgs e)
        {
            decimal precioCompra = decimal.Parse(txtPrecioCompra.Text);
            decimal porcentajeGanancia = decimal.Parse(txtPorcentajeGanancia.Text);
            txtPrecioVenta.Text = Convert.ToString(precioCompra * (1 + porcentajeGanancia / 100));
        }
    }
}