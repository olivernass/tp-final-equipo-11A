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
        }
        protected void btnNuevaOC_Click(object sender, EventArgs e)
        {
            // Crear la compra
            Compra compra = new Compra
            {
                Proveedor = new Proveedor { Id = int.Parse(codigo) }, // Suponiendo que 'codigo' es el ID del proveedor
                PrecioTotal = 0 // Este campo será calculado después de agregar todos los detalles
            };

            // Insertar la compra en la base de datos
            CompraNegocio compraNegocio = new CompraNegocio();
            compraNegocio.agregarCompra(compra);

            // Obtener el ID de la última compra insertada
            long ultimacompra = compraNegocio.TraerUltimo();

            // Si no se pudo obtener la última compra, detener el proceso
            if (ultimacompra == 0)
            {
                return;
            }

            // Crear una lista para almacenar los detalles de la compra
            List<Detalle_Compra> listaDetallesCompra = new List<Detalle_Compra>();

            // Recorrer cada item del Repeater
            foreach (RepeaterItem item in rptDetalleCompra.Items)
            {
                // Buscar el control TextBox dentro de cada fila
                TextBox txtCantidad = (TextBox)item.FindControl("txtCantidad");

                // Verificar si el TextBox no es nulo y tiene un valor
                if (txtCantidad != null && !string.IsNullOrEmpty(txtCantidad.Text))
                {
                    // Obtener el valor de la cantidad ingresada
                    int cantidad = 0;
                    if (int.TryParse(txtCantidad.Text, out cantidad))
                    {
                        // Obtener el ID del producto y el precio de compra desde el DataItem
                        long productoId = Convert.ToInt64(DataBinder.Eval(item.DataItem, "Producto.Id"));
                        decimal precioCompra = Convert.ToDecimal(DataBinder.Eval(item.DataItem, "Producto.Precio_Compra"));

                        // Calcular el subtotal con la nueva cantidad
                        decimal subtotal = precioCompra * cantidad;

                        // Crear un nuevo objeto Detalle_Compra para este producto
                        Detalle_Compra detalleCompra = new Detalle_Compra
                        {
                            Compra = new Compra { Id = ultimacompra },
                            Producto = new Producto { Id = productoId },
                            Cantidad = cantidad,
                            Precio_Compra_Unitario = precioCompra,
                            Subtotal = subtotal
                        };

                        // Agregar el detalle de compra a la lista
                        listaDetallesCompra.Add(detalleCompra);
                    }
                }
            }

            // Ahora insertar los detalles de la compra en la base de datos
            Detalle_Compra_Negocio detalleCompraNegocio = new Detalle_Compra_Negocio();
            detalleCompraNegocio.agregarProductos(listaDetallesCompra);

            // Redirigir o mostrar un mensaje de éxito
            Response.Redirect("Compras.aspx");
        }
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            // Recorrer cada item del Repeater
            foreach (RepeaterItem item in rptDetalleCompra.Items)
            {
                // Buscar el control TextBox dentro de cada fila
                TextBox txtCantidad = (TextBox)item.FindControl("txtCantidad");

                // Verificar si el TextBox no es nulo y tiene un valor
                if (txtCantidad != null && !string.IsNullOrEmpty(txtCantidad.Text))
                {
                    // Obtener el valor de la cantidad ingresada
                    int cantidad = 0;
                    if (int.TryParse(txtCantidad.Text, out cantidad))
                    {
                        // Obtener los valores desde el DataBinder
                        long productoId = Convert.ToInt64(DataBinder.Eval(item.DataItem, "Producto.Id"));
                        decimal precioCompra = Convert.ToDecimal(DataBinder.Eval(item.DataItem, "Producto.Precio_Compra"));

                        // Calcular el subtotal con la nueva cantidad
                        decimal subtotal = precioCompra * cantidad;

                        // Actualizar el Subtotal en el DataItem (en memoria)
                        var detalleCompra = (Detalle_Compra)item.DataItem;
                        detalleCompra.Producto = new Producto();
                        detalleCompra.Compra = new Compra();
                        detalleCompra.Cantidad = cantidad;
                        detalleCompra.Subtotal = subtotal;
                    }
                }
            }

            // Actualizar el DataSource del Repeater para reflejar los cambios en la interfaz
            rptDetalleCompra.DataSource = listaDetalle;  // listaDetalle debe tener los detalles actualizados
            rptDetalleCompra.DataBind();
            btnNuevaOC.Visible = true;
        }
    }
}


