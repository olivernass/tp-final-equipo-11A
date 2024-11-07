using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.IO;
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
                cargarMarcas();
                cargarCategorias();
                cargarProveedores();

            }
        }
        private void cargarProductos()
        {
            ProductoNegocio negocio = new ProductoNegocio();
            List<Producto> listaProducto = negocio.listar();
            rptProductos.DataSource = listaProducto;
            rptProductos.DataBind();
        }
        private void cargarMarcas()
        {
            MarcaNegocio negocio = new MarcaNegocio();
            List<Marca> listaMarca = negocio.listar();
            ddlMarcaProducto.DataSource = listaMarca;
            ddlMarcaProducto.DataTextField = "NombreMarca";
            ddlMarcaProducto.DataValueField = "Id";
            ddlMarcaProducto.DataBind();

        }
        private void cargarCategorias()
        {
            CategoriaNegocio negocio = new CategoriaNegocio();
            List<Categoria> listaCategoria = negocio.listar();
            ddlCategoriaProducto.DataSource = listaCategoria;
            ddlCategoriaProducto.DataTextField = "NombreCategoria";
            ddlCategoriaProducto.DataValueField = "Id";
            ddlCategoriaProducto.DataBind();

        }
        private void cargarProveedores()
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            List<Proveedor> listaProveedor = negocio.listar();
            ddlProveedorProducto.DataSource = listaProveedor;
            ddlProveedorProducto.DataTextField = "Siglas";
            ddlProveedorProducto.DataValueField = "Id"; 
            ddlProveedorProducto.DataBind();
            ddlProveedorNuevo.DataSource = listaProveedor;
            ddlProveedorNuevo.DataTextField = "Siglas";
            ddlProveedorNuevo.DataValueField = "Id";
            ddlProveedorNuevo.DataBind();

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
            else if (e.CommandName == "Detalle")
            {
                long idProducto = Convert.ToInt64(e.CommandArgument);
                Producto productodetalle = new Producto();
                {
                    productodetalle.Id = idProducto;
                }
                ProductoNegocio negocio = new ProductoNegocio();
                negocio.verDetalle(idProducto);
                cargarProductos();
            }
        }
        private void limpiarCampos()
        {
            // Limpiar los campos de texto
            txtNombreProducto.Text = string.Empty;
            txtDescripcionProducto.Text = string.Empty;
            txtStockActual.Text = string.Empty;
            txtStockMinimo.Text = string.Empty;
            txtPrecioCompra.Text = string.Empty;
            txtPrecioVenta.Text = string.Empty;
            txtPorcentajeGanancia.Text = string.Empty;
            txtImagenProducto.Text = string.Empty;

            // Limpiar los controles DropDownList
            ddlMarcaProducto.SelectedIndex = 0;
            ddlCategoriaProducto.SelectedIndex = 0;
            ddlProveedorProducto.SelectedIndex=0;
        }
        protected void btnGuardarProducto_Click(object sender, EventArgs e)
        {
            // Validar que todos los campos estén llenos
            if (string.IsNullOrEmpty(txtNombreProducto.Text) ||
                string.IsNullOrEmpty(txtDescripcionProducto.Text) || 
                string.IsNullOrEmpty(txtStockActual.Text) ||
                string.IsNullOrEmpty(txtStockMinimo.Text) ||
                string.IsNullOrEmpty(txtPrecioCompra.Text) ||
                string.IsNullOrEmpty(txtPrecioVenta.Text) ||
                string.IsNullOrEmpty(txtPorcentajeGanancia.Text) ||
                string.IsNullOrEmpty(txtImagenProducto.Text.Trim()) ||
                ddlProveedorProducto.SelectedIndex == -1) 
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }

            if (!decimal.TryParse(txtPrecioCompra.Text, out decimal precioCompra) || precioCompra <= 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El precio de compra debe ser un número positivo.');", true);
                return;
            }

            if (!decimal.TryParse(txtPrecioVenta.Text, out decimal precioVenta) || precioVenta <= 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El precio de venta debe ser un número positivo.');", true);
                return;
            }

            if (!decimal.TryParse(txtPorcentajeGanancia.Text, out decimal porcentajeGanancia) || porcentajeGanancia < 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El porcentaje de ganancia debe ser un número positivo.');", true);
                return;
            }

            if (!int.TryParse(txtStockActual.Text, out int stockActual) || stockActual < 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El stock actual debe ser un número entero positivo.');", true);
                return;
            }

            if (!int.TryParse(txtStockMinimo.Text, out int stockMinimo) || stockMinimo < 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El stock mínimo debe ser un número entero positivo.');", true);
                return;
            }

            if (string.IsNullOrEmpty(txtImagenProducto.Text.Trim()))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Debe ingresar una ruta o nombre de imagen para el producto.');", true);
                return;
            }

            string[] imagenExtensionesValidas = { ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff" };
            string extensionImagen = Path.GetExtension(txtImagenProducto.Text).ToLower();

            if (!imagenExtensionesValidas.Contains(extensionImagen))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('La ruta o nombre de la imagen debe tener una extensión válida (.jpg, .jpeg, .png, .gif, .bmp, .tiff).');", true);
                return;
            }


            Producto nuevoProducto = new Producto
            {
                Nombre = txtNombreProducto.Text,
                Descripcion = txtDescripcionProducto.Text,
                Marca = new Marca { Id = int.Parse(ddlMarcaProducto.SelectedValue) },
                Categoria = new Categoria { Id = int.Parse(ddlCategoriaProducto.SelectedValue) },
                StockActual = stockActual,
                StockMinimo = stockMinimo,
                Precio_Compra = precioCompra,
                Precio_Venta = precioVenta,
                Porcentaje_Ganancia = porcentajeGanancia,
                Imagen = new Imagen { ImagenUrl = txtImagenProducto.Text },
                Proveedores = ddlProveedorProducto.Items.Cast<ListItem>()
                               .Where(item => item.Selected)
                               .Select(item => new Proveedor { Id = int.Parse(item.Value) })
                               .ToList()
            };

            ProductoNegocio negocio = new ProductoNegocio();
            negocio.agregar(nuevoProducto);
            cargarProductos();
            limpiarCampos();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarProducto').modal('hide');", true);

        }

        protected void btnGuardarProveedor_Click(object sender, EventArgs e)
        {
            int idProducto = Convert.ToInt32(hfIdProducto.Value);
            int idproveedor = Convert.ToInt32(ddlProveedorNuevo.SelectedValue);
            ProveedorNegocio negocio = new ProveedorNegocio();
            negocio.agregarProducto(idProducto,idproveedor);

        }
    }
}