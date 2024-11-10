function validarAgregarCliente() {
    var nombre = document.querySelector('.validar-nombre');
    var apellido = document.querySelector('.validar-apellido');
    var direccion = document.querySelector('.validar-direccion');
    var telefono = document.querySelector('.validar-telefono');
    var correo = document.querySelector('.validar-correo');

    let valid = true;
    if (!DNI.value) {
        document.getElementById('errorDNI').textContent = "El DNI es obligatorio.";
        DNI.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(DNI.value)) {
        document.getElementById('errorDNI').textContent = "El DNI solo debe contener números.";
        DNI.classList.add('input-error');
        valid = false;
    }

    if (!nombre.value) {
        document.getElementById('errorNombre').textContent = "El nombre es obligatorio.";
        nombre.classList.add('input-error');
        valid = false;
    }
    if (!apellido.value) {
        document.getElementById('errorApellido').textContent = "El apellido es obligatorio.";
        apellido.classList.add('input-error');
        valid = false;
    }
    if (!direccion.value) {
        document.getElementById('errorDireccion').textContent = "La dirección es obligatoria.";
        direccion.classList.add('input-error');
        valid = false;
    }
    if (!telefono.value) {
        document.getElementById('errorTelefono').textContent = "El teléfono es obligatorio.";
        telefono.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        document.getElementById('errorTelefono').textContent = "El teléfono solo debe contener números.";
        telefono.classList.add('input-error');
        valid = false;
    }
    if (!correo.value) {
        document.getElementById('errorCorreo').textContent = "El correo es obligatorio.";
        correo.classList.add('input-error');
        valid = false;
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        document.getElementById('errorCorreo').textContent = "Ingresa un correo válido.";
        correo.classList.add('input-error');
        valid = false;
    }

    return valid;
}

function validarModificarCliente() {
    var dni = document.querySelector('.validar-DNI-mod');
    var nombre = document.querySelector('.validar-nombre-mod');
    var apellido = document.querySelector('.validar-apellido-mod');
    var direccion = document.querySelector('.validar-direccion-mod');
    var telefono = document.querySelector('.validar-telefono-mod');
    var correo = document.querySelector('.validar-correo-mod');

    let valid = true;

    if (!dni.value) {
        document.getElementById('errorDNIMod').textContent = "El DNI es obligatorio.";
        dni.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(dni.value)) {
        document.getElementById('errorDNIMod').textContent = "El DNI solo debe contener números.";
        dni.classList.add('input-error');
        valid = false;
    }

    if (!nombre.value) {
        document.getElementById('errorNombreMod').textContent = "El nombre es obligatorio.";
        nombre.classList.add('input-error');
        valid = false;
    }
    if (!apellido.value) {
        document.getElementById('errorApellidoMod').textContent = "El apellido es obligatorio.";
        apellido.classList.add('input-error');
        valid = false;
    }
    if (!direccion.value) {
        document.getElementById('errorDireccionMod').textContent = "La dirección es obligatoria.";
        direccion.classList.add('input-error');
        valid = false;
    }
    if (!telefono.value) {
        document.getElementById('errorTelefonoMod').textContent = "El teléfono es obligatorio.";
        telefono.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        document.getElementById('errorTelefonoMod').textContent = "El teléfono solo debe contener números.";
        telefono.classList.add('input-error');
        valid = false;
    }
    if (!correo.value) {
        document.getElementById('errorCorreoMod').textContent = "El correo es obligatorio.";
        correo.classList.add('input-error');
        valid = false;
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        document.getElementById('errorCorreoMod').textContent = "Ingresa un correo válido.";
        correo.classList.add('input-error');
        valid = false;
    }

    return valid;
}

function validarAgregarProveedor() {
    var cuit = document.querySelector('.validar-CUIT');
    var siglas = document.querySelector('.validar-siglas');
    var nombre = document.querySelector('.validar-nombre');
    var direccion = document.querySelector('.validar-direccion');
    var correo = document.querySelector('.validar-correo');
    var telefono = document.querySelector('.validar-telefono');

    let valid = true;

    if (!cuit.value) {
        document.getElementById('errorCUIT').textContent = "El CUIT es obligatorio.";
        cuit.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(cuit.value)) {
        document.getElementById('errorCUIT').textContent = "El CUIT solo debe contener números.";
        cuit.classList.add('input-error');
        valid = false;
    }

    if (!siglas.value) {
        document.getElementById('errorSiglas').textContent = "Las siglas son obligatorias.";
        siglas.classList.add('input-error');
        valid = false;
    }

    if (!nombre.value) {
        document.getElementById('errorNombre').textContent = "El nombre es obligatorio.";
        nombre.classList.add('input-error');
        valid = false;
    }

    if (!direccion.value) {
        document.getElementById('errorDireccion').textContent = "La dirección es obligatoria.";
        direccion.classList.add('input-error');
        valid = false;
    }

    if (!telefono.value) {
        document.getElementById('errorTelefono').textContent = "El teléfono es obligatorio.";
        telefono.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        document.getElementById('errorTelefono').textContent = "El teléfono solo debe contener números.";
        telefono.classList.add('input-error');
        valid = false;
    }

    if (!correo.value) {
        document.getElementById('errorCorreo').textContent = "El correo es obligatorio.";
        correo.classList.add('input-error');
        valid = false;
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        document.getElementById('errorCorreo').textContent = "Ingresa un correo válido.";
        correo.classList.add('input-error');
        valid = false;
    }

    return valid;
}

function validarModificarProveedor() {
    var cuit = document.querySelector('.validar-CUIT-mod');
    var siglas = document.querySelector('.validar-siglas-mod');
    var nombre = document.querySelector('.validar-nombre-mod');
    var direccion = document.querySelector('.validar-direccion-mod');
    var correo = document.querySelector('.validar-correo-mod');
    var telefono = document.querySelector('.validar-telefono-mod');

    let valid = true;

    if (!cuit.value) {
        document.getElementById('errorCUITMod').textContent = "El CUIT es obligatorio.";
        cuit.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(cuit.value)) {
        document.getElementById('errorCUITMod').textContent = "El CUIT solo debe contener números.";
        cuit.classList.add('input-error');
        valid = false;
    }

    if (!siglas.value) {
        document.getElementById('errorSiglasMod').textContent = "Las siglas son obligatorias.";
        siglas.classList.add('input-error');
        valid = false;
    }

    if (!nombre.value) {
        document.getElementById('errorNombreMod').textContent = "El nombre es obligatorio.";
        nombre.classList.add('input-error');
        valid = false;
    }

    if (!direccion.value) {
        document.getElementById('errorDireccionMod').textContent = "La dirección es obligatoria.";
        direccion.classList.add('input-error');
        valid = false;
    }

    if (!telefono.value) {
        document.getElementById('errorTelefonoMod').textContent = "El teléfono es obligatorio.";
        telefono.classList.add('input-error');
        valid = false;
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        document.getElementById('errorTelefonoMod').textContent = "El teléfono solo debe contener números.";
        telefono.classList.add('input-error');
        valid = false;
    }

    if (!correo.value) {
        document.getElementById('errorCorreoMod').textContent = "El correo es obligatorio.";
        correo.classList.add('input-error');
        valid = false;
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        document.getElementById('errorCorreoMod').textContent = "Ingresa un correo válido.";
        correo.classList.add('input-error');
        valid = false;
    }

    return valid;
}

function validarAgregarMarca() {
    var nombreMarca = document.querySelector('.validar-nombre');

    let valid = true;

    document.querySelectorAll('.input-error').forEach(function (el) {
        el.classList.remove('input-error');
    });
    document.querySelectorAll('.error-message').forEach(function (el) {
        el.textContent = ''; 
    });

    if (!nombreMarca.value) {
        document.getElementById('errorNombreMarca').textContent = "El nombre de la marca es obligatorio.";
        nombreMarca.classList.add('input-error');
        valid = false;
    }

    return valid;
}

function validarModificarMarca() {
    var nombreMarcaMod = document.querySelector('.validar-nombre-mod');

    let valid = true;

    document.querySelectorAll('.input-error').forEach(function (el) {
        el.classList.remove('input-error');
    });
    document.querySelectorAll('.error-message').forEach(function (el) {
        el.textContent = ''; 
    });

    if (!nombreMarcaMod.value) {
        document.getElementById('errorNombreMarcaMod').textContent = "El nombre de la marca es obligatorio.";
        nombreMarcaMod.classList.add('input-error');
        valid = false;
    }

    return valid;
}

function validarAgregarCategoria() {
    var nombreCategoria = document.querySelector('.validar-nombre');

    let valid = true;

    document.querySelectorAll('.input-error').forEach(function (el) {
        el.classList.remove('input-error');
    });
    document.querySelectorAll('.error-message').forEach(function (el) {
        el.textContent = '';
    });

    if (!nombreCategoria.value) {
        document.getElementById('errorNombreCategoria').textContent = "El nombre de la categoría es obligatorio.";
        nombreCategoria.classList.add('input-error');
        valid = false;
    }

    return valid;
}

function validarModificarCategoria() {
    var nombreCategoriaMod = document.querySelector('.validar-nombre-mod');

    let valid = true;

    document.querySelectorAll('.input-error').forEach(function (el) {
        el.classList.remove('input-error');
    });
    document.querySelectorAll('.error-message').forEach(function (el) {
        el.textContent = ''; 
    });


    if (!nombreCategoriaMod.value) {
        document.getElementById('errorNombreCategoriaMod').textContent = "El nombre de la categoría es obligatorio.";
        nombreCategoriaMod.classList.add('input-error');
        valid = false;
    }

    return valid;
}


function limpiarModal(modalId) {
    // Limpia todos los campos de texto, errores, y quita las clases de error en el modal específico
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.querySelectorAll('input.form-control, textarea.form-control, select.form-control').forEach(input => {
            input.value = '';
            input.classList.remove('input-error');
        });

        modal.querySelectorAll('.error-message').forEach(msg => {
            msg.textContent = '';
        });

        // Específicamente, para resetear checkboxes o radio buttons
        //modal.querySelectorAll('input[type="checkbox"], input[type="radio"]').forEach(check => {
        //    check.checked = false;
        //});
    }
}









