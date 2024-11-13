using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Usuario
    {
        public int Id { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasenia { get; set; }
        public Permiso Permiso { get; set; }
        public bool Activo { get; set; }
        public string Nombre { get; set; } 
        public string Apellido { get; set; } 
        public string CorreoElectronico { get; set; }
        public string Telefono { get; set; } 
        public Imagen Imagen { get; set; }
        public DateTime FechaCreacion { get; set; }

        public Usuario()
        {
            FechaCreacion = DateTime.Now;
            Activo = true;
        }

        public Usuario(
            string nombreUsuario,
            string contrasenia,
            int idPermiso = 0,
            string nombre = null,
            string apellido = null,
            string correoElectronico = null,
            string telefono = null,
            Imagen imagen = null
        )
        {
            NombreUsuario = nombreUsuario;
            Contrasenia = contrasenia;
            Permiso = new Permiso { Id = idPermiso };
            Nombre = nombre;
            Apellido = apellido;
            CorreoElectronico = correoElectronico;
            Telefono = telefono;
            Imagen = imagen;
            FechaCreacion = DateTime.Now;
            Activo = true;
        }
    }
}
