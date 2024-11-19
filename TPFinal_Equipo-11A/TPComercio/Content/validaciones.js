function validarAgregarCliente() {
    var DNI = document.querySelector('.validar-DNI');
    var nombre = document.querySelector('.validar-nombre');
    var apellido = document.querySelector('.validar-apellido');
    var direccion = document.querySelector('.validar-direccion');
    var telefono = document.querySelector('.validar-telefono');
    var correo = document.querySelector('.validar-correo');

    let valid = true;

    // Helper function to apply classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de DNI
    if (!DNI.value) {
        setValidationClasses(DNI, false);
    } else if (!/^[0-9]+$/.test(DNI.value)) {
        setValidationClasses(DNI, false);
    } else {
        setValidationClasses(DNI, true);
    }

    // Validación de Nombre
    if (!nombre.value) {
        setValidationClasses(nombre, false);
    } else {
        setValidationClasses(nombre, true);
    }

    // Validación de Apellido
    if (!apellido.value) {
        setValidationClasses(apellido, false);
    } else {
        setValidationClasses(apellido, true);
    }

    // Validación de Dirección
    if (!direccion.value) {
        setValidationClasses(direccion, false);
    } else {
        setValidationClasses(direccion, true);
    }

    // Validación de Teléfono
    if (!telefono.value) {
        setValidationClasses(telefono, false);
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        setValidationClasses(telefono, false);
    } else {
        setValidationClasses(telefono, true);
    }

    // Validación de Correo
    if (!correo.value) {
        setValidationClasses(correo, false);
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        setValidationClasses(correo, false);
    } else {
        setValidationClasses(correo, true);
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

    // Helper function to apply classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de DNI
    if (!dni.value) {
        setValidationClasses(dni, false);
    } else if (!/^[0-9]+$/.test(dni.value)) {
        setValidationClasses(dni, false);
    } else {
        setValidationClasses(dni, true);
    }

    // Validación de Nombre
    if (!nombre.value) {
        setValidationClasses(nombre, false);
    } else {
        setValidationClasses(nombre, true);
    }

    // Validación de Apellido
    if (!apellido.value) {
        setValidationClasses(apellido, false);
    } else {
        setValidationClasses(apellido, true);
    }

    // Validación de Dirección
    if (!direccion.value) {
        setValidationClasses(direccion, false);
    } else {
        setValidationClasses(direccion, true);
    }

    // Validación de Teléfono
    if (!telefono.value) {
        setValidationClasses(telefono, false);
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        setValidationClasses(telefono, false);
    } else {
        setValidationClasses(telefono, true);
    }

    // Validación de Correo
    if (!correo.value) {
        setValidationClasses(correo, false);
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        setValidationClasses(correo, false);
    } else {
        setValidationClasses(correo, true);
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

    // Helper function to apply validation classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de CUIT
    if (!cuit.value) {
        setValidationClasses(cuit, false);
    } else if (!/^[0-9]+$/.test(cuit.value)) {
        setValidationClasses(cuit, false);
    } else {
        setValidationClasses(cuit, true);
    }

    // Validación de Siglas
    if (!siglas.value) {
        setValidationClasses(siglas, false);
    } else {
        setValidationClasses(siglas, true);
    }

    // Validación de Nombre
    if (!nombre.value) {
        setValidationClasses(nombre, false);
    } else {
        setValidationClasses(nombre, true);
    }

    // Validación de Dirección
    if (!direccion.value) {
        setValidationClasses(direccion, false);
    } else {
        setValidationClasses(direccion, true);
    }

    // Validación de Teléfono
    if (!telefono.value) {
        setValidationClasses(telefono, false);
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        setValidationClasses(telefono, false);
    } else {
        setValidationClasses(telefono, true);
    }

    // Validación de Correo
    if (!correo.value) {
        setValidationClasses(correo, false);
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        setValidationClasses(correo, false);
    } else {
        setValidationClasses(correo, true);
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

    // Helper function to apply validation classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de CUIT
    if (!cuit.value) {
        setValidationClasses(cuit, false);
    } else if (!/^[0-9]+$/.test(cuit.value)) {
        setValidationClasses(cuit, false);
    } else {
        setValidationClasses(cuit, true);
    }

    // Validación de Siglas
    if (!siglas.value) {
        setValidationClasses(siglas, false);
    } else {
        setValidationClasses(siglas, true);
    }

    // Validación de Nombre
    if (!nombre.value) {
        setValidationClasses(nombre, false);
    } else {
        setValidationClasses(nombre, true);
    }

    // Validación de Dirección
    if (!direccion.value) {
        setValidationClasses(direccion, false);
    } else {
        setValidationClasses(direccion, true);
    }

    // Validación de Teléfono
    if (!telefono.value) {
        setValidationClasses(telefono, false);
    } else if (!/^[0-9]+$/.test(telefono.value)) {
        setValidationClasses(telefono, false);
    } else {
        setValidationClasses(telefono, true);
    }

    // Validación de Correo
    if (!correo.value) {
        setValidationClasses(correo, false);
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value)) {
        setValidationClasses(correo, false);
    } else {
        setValidationClasses(correo, true);
    }

    return valid;
}


function validarAgregarMarca() {
    var nombreMarca = document.querySelector('.validar-nombre');
    let valid = true;

    // Helper function to apply classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de Nombre de Marca
    if (!nombreMarca.value) {
        setValidationClasses(nombreMarca, false);
    } else {
        setValidationClasses(nombreMarca, true);
    }

    return valid;
}

function validarModificarMarca() {
    var nombreMarcaMod = document.querySelector('.validar-nombre-mod');
    let valid = true;

    // Helper function to apply classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de Nombre de Marca Modificada
    if (!nombreMarcaMod.value) {
        setValidationClasses(nombreMarcaMod, false);
    } else {
        setValidationClasses(nombreMarcaMod, true);
    }

    return valid;
}

function validarAgregarCategoria() {
    var nombreCategoria = document.querySelector('.validar-nombre');
    let valid = true;

    // Helper function to apply classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de Nombre de Categoría
    if (!nombreCategoria.value) {
        setValidationClasses(nombreCategoria, false);
    } else {
        setValidationClasses(nombreCategoria, true);
    }

    return valid;
}

function validarModificarCategoria() {
    var nombreCategoriaMod = document.querySelector('.validar-nombre-mod');
    let valid = true;

    // Helper function to apply classes
    function setValidationClasses(field, isValid) {
        const container = field.closest('.mb-3');
        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            valid = false;
        }
    }

    // Validación de Nombre de Categoría Modificada
    if (!nombreCategoriaMod.value) {
        setValidationClasses(nombreCategoriaMod, false);
    } else {
        setValidationClasses(nombreCategoriaMod, true);
    }

    return valid;
}

function validarAgregarUsuario() {
    var nombre = document.querySelector('.validar-nombre');
    var apellido = document.querySelector('.validar-apellido');
    var correo = document.querySelector('.validar-correo');
    var telefono = document.querySelector('.validar-telefono');
    var imagen = document.querySelector('.validar-imagen');
    var username = document.querySelector('.validar-username');
    var password = document.querySelector('.validar-password');
    var permisos = document.querySelector('.validar-permisos');

    let valid = true;

    // Helper function to apply classes
    function setValidationClasses(field, isValid, errorMessage) {
        const container = field.closest('.mb-3');
        const invalidFeedback = container.querySelector('.invalid-feedback');

        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
            if (invalidFeedback) invalidFeedback.textContent = "";
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            if (invalidFeedback) invalidFeedback.textContent = errorMessage;
            valid = false;
        }
    }

    // Validación de cada campo
    setValidationClasses(nombre, nombre.value !== "", "El nombre es obligatorio.");
    setValidationClasses(apellido, apellido.value !== "", "El apellido es obligatorio.");
    setValidationClasses(correo, /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value), "Ingresa un correo electrónico válido.");
    setValidationClasses(telefono, /^[0-9]+$/.test(telefono.value), "El teléfono debe contener solo números.");
    setValidationClasses(username, username.value !== "", "El nombre de usuario es obligatorio.");
    setValidationClasses(password, password.value.length >= 3, "La contraseña debe tener al menos 3 caracteres.");
    setValidationClasses(permisos, permisos.value !== "", "Selecciona un permiso válido.");

    // Validación de URL de la imagen
    const validImageExtensions = /\.(jpg|jpeg|png|gif|bmp|tiff)$/i; // Extensiones válidas
    setValidationClasses(imagen, validImageExtensions.test(imagen.value), "Ingresa una URL válida para la imagen.");

    return valid;
}


function validarModificarUsuario() {
    var nombre = document.querySelector('.validar-nombre-mod');
    var apellido = document.querySelector('.validar-apellido-mod');
    var correo = document.querySelector('.validar-correo-mod');
    var telefono = document.querySelector('.validar-telefono-mod');
    var imagen = document.querySelector('.validar-imagen-mod');
    var username = document.querySelector('.validar-username-mod');
    var password = document.querySelector('.validar-password-mod');
    var permisos = document.querySelector('.validar-permisos-mod');

    let valid = true;

    // Helper function to apply classes
    function setValidationClasses(field, isValid, errorMessage) {
        const container = field.closest('.mb-3');
        const invalidFeedback = container.querySelector('.invalid-feedback');

        if (isValid) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
            container.classList.add('has-success');
            container.classList.remove('has-danger');
            if (invalidFeedback) invalidFeedback.textContent = "";
        } else {
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');
            container.classList.add('has-danger');
            container.classList.remove('has-success');
            if (invalidFeedback) invalidFeedback.textContent = errorMessage;
            valid = false;
        }
    }

    // Validación de cada campo
    setValidationClasses(nombre, nombre.value !== "", "El nombre es obligatorio.");
    setValidationClasses(apellido, apellido.value !== "", "El apellido es obligatorio.");
    setValidationClasses(correo, /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo.value), "Ingresa un correo electrónico válido.");
    setValidationClasses(telefono, /^[0-9]+$/.test(telefono.value), "El teléfono debe contener solo números.");
    setValidationClasses(username, username.value !== "", "El nombre de usuario es obligatorio.");
    setValidationClasses(password, password.value.length >= 3, "La contraseña debe tener al menos 3 caracteres.");
    setValidationClasses(permisos, permisos.value !== "", "Selecciona un permiso válido.");

    // Validación de URL de la imagen
    const validImageExtensions = /\.(jpg|jpeg|png|gif|bmp|tiff)$/i; // Extensiones válidas
    setValidationClasses(imagen, validImageExtensions.test(imagen.value), "Ingresa una URL válida para la imagen.");

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









