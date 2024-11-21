using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPComercio.Utils;

namespace TPComercio
{
    public partial class Reportes : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);
        }

    }
}