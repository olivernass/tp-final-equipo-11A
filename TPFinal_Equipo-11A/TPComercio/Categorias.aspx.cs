﻿using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class Categorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarCategorias();
            }
        }
        private void cargarCategorias()
        {
            CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
            gvCategorias.DataSource = categoriaNegocio.listar();
            gvCategorias.DataBind();
        }
    }
}