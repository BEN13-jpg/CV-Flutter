function filtrarHabilidades(categoria) {
  const items = document.querySelectorAll('#lista-habilidades li');
  const botones = document.querySelectorAll('.btn');

  // Actualizar estado activo de los botones
  botones.forEach(btn => btn.classList.remove('active'));
  event.target.classList.add('active');

  // Filtrar lista
  items.forEach(item => {
    if (categoria === 'todas' || item.classList.contains(categoria)) {
      item.style.display = 'block';
    } else {
      item.style.display = 'none';
    }
  });
}