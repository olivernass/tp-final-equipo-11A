﻿using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProductoNegocio
    {
        public Producto verDetalle(long id)
        {
            Producto aux = new Producto();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_DetalleProducto");
                datos.setearParametro("@ID", id);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                { 
                    aux.Marca = new Marca();
                    aux.Categoria = new Categoria();
                    aux.Imagen = new Imagen();
                    aux.Id = (long)datos.Lector["ID"];
                    aux.Imagen.ImagenUrl = (string)datos.Lector["ImagenURL"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
                    aux.Marca.NombreMarca = (string)datos.Lector["NombreMarca"];
                    aux.Categoria.NombreCategoria = (string)datos.Lector["NombreCategoria"];
                    aux.StockActual = (int)datos.Lector["Stock_Actual"];
                    aux.StockMinimo = (int)datos.Lector["Stock_Minimo"];
                    aux.Precio_Compra = (decimal)datos.Lector["Precio_Compra"];
                    aux.Precio_Venta = (decimal)datos.Lector["Precio_Venta"];
                    aux.Porcentaje_Ganancia = (decimal)datos.Lector["Porcentaje_Ganancia"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                }
                return aux;
            }
            catch (Exception ex)
            {
                throw ex;
            }

            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<Producto> listar()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM VW_ALLProducto");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Producto aux = new Producto();
                    aux.Marca = new Marca();
                    aux.Categoria = new Categoria();
                    aux.Imagen = new Imagen();
                    aux.Id = (long)datos.Lector["ID"];
                    aux.Imagen.ImagenUrl = (string)datos.Lector["ImagenURL"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
                    aux.Marca.NombreMarca = (string)datos.Lector["NombreMarca"];
                    aux.Categoria.NombreCategoria = (string)datos.Lector["NombreCategoria"];
                    aux.StockActual = (int)datos.Lector["Stock_Actual"];
                    aux.StockMinimo = (int)datos.Lector["Stock_Minimo"];
                    aux.Precio_Compra = (decimal)datos.Lector["Precio_Compra"];
                    aux.Precio_Venta = (decimal)datos.Lector["Precio_Venta"];
                    aux.Porcentaje_Ganancia = (decimal)datos.Lector["Porcentaje_Ganancia"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                   
                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }

            finally
            {
                datos.cerrarConexion();
            }
        }
        public void eliminarL(Producto producto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_BajaProducto");
                datos.setearParametro("@ID", producto.Id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void activar(Producto producto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ActivarProducto");
                datos.setearParametro("@ID", producto.Id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void agregar(Producto nuevoproducto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ALTA_PRODUCTO");
                datos.setearParametro("@NOMBRE", nuevoproducto.Nombre);
                datos.setearParametro("@DESCRIPCION", nuevoproducto.Descripcion);
                datos.setearParametro("@IDMARCA", nuevoproducto.Marca.Id);
                datos.setearParametro("@IDCATEGORIA", nuevoproducto.Categoria.Id);
                datos.setearParametro("@IMAGENURL", nuevoproducto.Imagen.ImagenUrl);
                datos.setearParametro("@STOCKACTUAL", nuevoproducto.StockActual);
                datos.setearParametro("@STOCKMINIMO", nuevoproducto.StockMinimo);
                datos.setearParametro("@PRECIOCOMPRA", nuevoproducto.Precio_Compra);
                datos.setearParametro("@PRECIOVENTA", nuevoproducto.Precio_Venta);
                datos.setearParametro("@PORCENTAJEGANANCIA", nuevoproducto.Porcentaje_Ganancia);
                datos.setearParametro("@IDPROVEEDOR", nuevoproducto.Proveedores.First().Id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
