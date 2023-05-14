

const barraNotificaciones = document.getElementById('barra-notificaciones');
const contenidoExpandido = document.querySelector('.contenido-expandido');

barraNotificaciones.addEventListener('click', function(event) {
  if (event.target === barraNotificaciones || event.target === contenidoExpandido) {
    barraNotificaciones.classList.toggle('expandida');
  }
});

window.addEventListener("message", function (event) {
  switch (event.data.action) {
    case 'show':
      AbrirTablet();
      break;
    case 'noti':
      crearNotificacion(event.data.title, event.data.msg, event.data.tiempo, event.data.icon);
      break;
  }
});

const barraBrillo = document.getElementById('brillo-input');
const canelo = document.querySelector('.pantalla');

// Verificar si hay un valor de brillo en caché
if (localStorage.getItem('brillo')) {
  const brilloGuardado = localStorage.getItem('brillo');
  canelo.style.filter = `brightness(${brilloGuardado}%)`;
  barraBrillo.value = brilloGuardado;
}

// Escuchar cambios en la barra de brillo
barraBrillo.addEventListener('input', function() {
  const brillo = this.value;
  canelo.style.filter = `brightness(${brillo}%)`;
  // Guardar el valor de brillo en caché
  localStorage.setItem('brillo', brillo);
});





function AbrirTablet() {
  $('.marco').show(0)
}


window.addEventListener('keyup', function (event) {
  if (event.key === 'Escape' || event.key === 'Backspace') {
    var container = document.querySelector('.marco');
    container.style.display = 'none';
    $.post('https://sy_tab/SendAction', JSON.stringify({action: 'cerrar'}));
  }
})

document.addEventListener("brightnessUpdate", function(event) {
  var brightness = event.detail;
  var pantallaElement = document.querySelector(".pantalla");
  pantallaElement.style.filter = "brightness(" + brightness + "%)";
});



// Array de objetos que representan cada aplicación
var aplicaciones = [
  {
    nombre: "Trabjo",
    icono: "trabajo",
    contenido: "trabajo.html"
  }
];

// Selecciona el contenedor de las aplicaciones
var contenedorAplicaciones = document.querySelector(".aplicaciones");

// Selecciona la pantalla de la aplicación
var pantalla = document.querySelector(".pantalla");

// Crea un div para cada aplicación y lo agrega al contenedor
aplicaciones.forEach(function (aplicacion) {
  var divAplicacion = document.createElement("div");
  divAplicacion.classList.add("aplicacion");

  var divIcono = document.createElement("div");
  divIcono.classList.add("icono");
  divIcono.style.backgroundImage = "url('./img/" + aplicacion.icono + ".png')";

  var divNombre = document.createElement("div");
  divNombre.classList.add("nombre");
  divNombre.textContent = aplicacion.nombre;

  divAplicacion.appendChild(divIcono);
  divAplicacion.appendChild(divNombre);

  divAplicacion.addEventListener("click", function () {
    // Elimina la aplicación activa anterior si existe
    var appActivaAnterior = document.querySelector(".app-activa");
    if (appActivaAnterior) {
      appActivaAnterior.remove();
    }

    // Crea un nuevo div para mostrar la información de la aplicación seleccionada
    var nuevoContenido = document.createElement('div');
    nuevoContenido.classList.add('app-activa');

    if (aplicacion.contenido.endsWith('.html')) {
      fetch(aplicacion.contenido)
        .then(response => response.text())
        .then(html => {
          nuevoContenido.innerHTML = html;
        });
    } else {
      nuevoContenido.innerHTML = aplicacion.contenido;
    }

   
    // Agrega el nuevo div a la pantalla
    pantalla.appendChild(nuevoContenido);

    // Muestra la aplicación activa en pantalla
    nuevoContenido.style.display = "block";
  });

  var botonAtras = document.querySelector(".boton-atras");

  botonAtras.addEventListener("click", function () {
    var appActiva = document.querySelector(".app-activa");
    if (appActiva) {
      appActiva.remove();
    }
  });

  contenedorAplicaciones.appendChild(divAplicacion);
});

// $.post('https://sy_tab/SendAction', JSON.stringify({action: 'actualizar'}));

var BotonCerrar = document.querySelector(".boton");

BotonCerrar.addEventListener("click", function () {
  $('.marco').show(500)
  var container = document.querySelector('.marco');
  container.style.display = 'none';
  $.post('https://sy_tab/SendAction', JSON.stringify({action: 'cerrar'}));
  
});


var container = document.querySelector('.marco');
var offsetX, offsetY;
var isDragging = false; // Agregamos una variable para controlar si se está arrastrando o no

// Intentar cargar la posición almacenada en el caché
var cachedPosition = localStorage.getItem('elementPosition');
if (cachedPosition) {
  var position = JSON.parse(cachedPosition);
  container.style.left = position.left + 'px';
  container.style.top = position.top + 'px';
}

container.addEventListener('mousedown', function (e) {
  // Verificamos que el elemento donde se hizo clic tenga la clase ".marco"
  if (e.target.classList.contains('marco')) {
    isDragging = true;
    offsetX = e.clientX - container.offsetLeft;
    offsetY = e.clientY - container.offsetTop;
    document.addEventListener('mousemove', onMouseMove);
    document.addEventListener('mouseup', onMouseUp);
  }
});

function onMouseMove(e) {
  if (isDragging) {
    var left = e.clientX - offsetX;
    var top = e.clientY - offsetY;
    container.style.left = left + 'px';
    container.style.top = top + 'px';
  }
}

function onMouseUp() {
  if (isDragging) {
    // Guardar la posición actual en el caché
    var position = {
      left: container.offsetLeft,
      top: container.offsetTop
    };
    localStorage.setItem('elementPosition', JSON.stringify(position));

    document.removeEventListener('mousemove', onMouseMove);
    document.removeEventListener('mouseup', onMouseUp);
    isDragging = false;
  }
}
function actualizarReloj() {
  const fecha = new Date();
  const hora = fecha.getHours();
  const minutos = fecha.getMinutes();
  const horaFormateada = hora.toString().padStart(2, '0');
  const minutosFormateados = minutos.toString().padStart(2, '0');
  const horaCompleta = horaFormateada + ':' + minutosFormateados;
  document.querySelector('.reloj').textContent = horaCompleta;
}

// Actualizar el reloj cada minuto
setInterval(actualizarReloj, 60000);

// Actualizar el reloj al cargar la página
actualizarReloj();






function crearNotificacion(titulo, mensaje, tiempo, icono) {
  var contenedor;
  if (document.querySelector('.barra-notificaciones.expandida')) {
    contenedor = document.querySelector('.barra-notificaciones .noti-contenedor');
  } else {
    contenedor = document.querySelector('.noti-contenedor');
  }
  var notificaciones = contenedor.children.length;
  var limiteMaximo = 5; // limite máximo de notificaciones en la pantalla
  if (notificaciones >= limiteMaximo) {
    contenedor.removeChild(contenedor.firstChild); // elimina la notificación más antigua
  }
  var notificacion = document.createElement('div');
  notificacion.classList.add('noti-barra');
  var iconoElemento = document.createElement('i');
  iconoElemento.classList.add('icono', 'fas', 'fa-fade', 'fa-' + icono);

  var contenido = document.createElement('div');
  contenido.classList.add('contenido');
  var tituloElemento = document.createElement('div');
  tituloElemento.classList.add('titulo');
  tituloElemento.textContent = titulo;
  var mensajeElemento = document.createElement('div');
  mensajeElemento.classList.add('mensaje');
  mensajeElemento.textContent = mensaje;
  contenido.appendChild(tituloElemento);
  contenido.appendChild(mensajeElemento);
  notificacion.appendChild(iconoElemento);
  notificacion.appendChild(contenido);
  contenedor.appendChild(notificacion);
  setTimeout(function () {
    contenedor.removeChild(notificacion);
  }, tiempo);
}

// Obtener el contenedor de los botones
const botonesContainer = document.getElementById("botones-container");

// Crear los botones y agregarlos al contenedor
const botones = [
  { icono: "fa-cog", opcion: "ajustes" },
  { icono: "fa-times", opcion: "cerrar" },
];

botones.forEach(boton => {
  const button = document.createElement("button");
  button.classList.add("boton-brillo");

  const icono = document.createElement("i");
  icono.classList.add("fa", boton.icono);
  
  button.appendChild(icono);

  // Agregar el evento click al botón
  button.addEventListener("click", () => {
    // Acciones a realizar cuando se haga clic en el botón
    if (boton.opcion === "ajustes") {
      // Acción para el botón de ajustes
      // ...
    } else if (boton.opcion === "cerrar") {
      // Acción para el botón de cerrar
      $('.marco').show(500);
      var container = document.querySelector('.marco');
      container.style.display = 'none';
      $.post('https://sy_tab/SendAction', JSON.stringify({action: 'cerrar'}));
      barraNotificaciones.classList.toggle('expandida');
    }
  });

  botonesContainer.appendChild(button);
});
