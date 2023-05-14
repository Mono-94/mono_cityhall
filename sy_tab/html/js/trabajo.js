window.addEventListener('message', function(event) {
    var data = event.data;
  
    switch (data.action) {
      case 'UpdateData':
        updateTrabajo(data);
        break;
    }
  });
  
  function updateTrabajo(data) {
    var contenedorTrabajo = document.querySelector(".co-trabajo");
    var tarjetasExistentes = contenedorTrabajo.querySelectorAll('.tarjeta');
    var nombreTrabajo = 'Trabajo: ' + data.value;
  
    var tarjetaExistente = Array.from(tarjetasExistentes).find(function(tarjeta) {
      return tarjeta.querySelector('.tarjeta-titulo').textContent.trim() === nombreTrabajo;
    });
  
    if (tarjetaExistente) {
      var horasTarjeta = tarjetaExistente.querySelector('.tarjeta-horas');
      horasTarjeta.textContent = 'Horas total: ' + data.horas;
    } else {
      var nuevaTarjeta = createTarjeta(nombreTrabajo, data.rango, data.horas);
      contenedorTrabajo.appendChild(nuevaTarjeta);
    }
  }
  
  function createTarjeta(nombreTrabajo, rango, horas) {
    var nuevaTarjeta = document.createElement("div");
    nuevaTarjeta.classList.add("tarjeta");
  
    var tituloTarjeta = document.createElement("div");
    tituloTarjeta.classList.add("tarjeta-titulo");
    tituloTarjeta.textContent = nombreTrabajo;
  
    var puestoTarjeta = document.createElement("div");
    puestoTarjeta.classList.add("tarjeta-puesto");
    puestoTarjeta.textContent = 'Puesto: ' + rango;

    var horasTarjeta = document.createElement("div");
    horasTarjeta.classList.add("tarjeta-horas");
    horasTarjeta.textContent = 'Horas total: ' + horas;
  
    var botonAtras = document.querySelector('.boton-atras');
    botonAtras.addEventListener('click', function() {
      var appActiva = document.querySelector(".app-activa");
      if (appActiva) {
        appActiva.remove();
      }
    });
  
    nuevaTarjeta.appendChild(tituloTarjeta);
    nuevaTarjeta.appendChild(puestoTarjeta);
    nuevaTarjeta.appendChild(horasTarjeta);
  
    return nuevaTarjeta;
  }
  