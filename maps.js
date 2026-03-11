
    src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
    integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
    crossorigin=""
  

 
    // Coordonnées approximatives de Lanrodec (centre de la commune)
    // Si tu connais les coordonnées exactes de 5 Calvin,
    // remplace simplement ces valeurs par les bonnes.
    const lat = 48.4863183;
    const lng = -3.046472;

    // Initialisation de la carte
    const map = L.map("map").setView([lat, lng], 15);

    // Fond de carte OpenStreetMap
    L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
      maxZoom: 19,
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    // Marqueur sur l'adresse
    const marker = L.marker([lat, lng]).addTo(map);

    // Popup attachée au marqueur
    marker.bindPopup(
      "<b>5 Calvin</b><br>22170 Lanrodec"
    ).openPopup();
