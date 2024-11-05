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
        public Usuario() { }
        public Usuario(string nombreUsuario, string contrasenia, int idPermiso)
        {
            NombreUsuario = nombreUsuario;
            Contrasenia = contrasenia;
            Permiso = new Permiso { Id = idPermiso };  // Inicializa un nuevo Permiso con el ID proporcionado
            Activo = true;  // inicializar Activo como true por defecto o agregarlo como parámetro si es necesario
        }
    }
}
