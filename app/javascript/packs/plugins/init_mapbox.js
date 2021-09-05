import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 40, maxZoom: 17, duration: 0 });
};

const addMarkersToMapIndex = (map, markers) => {
  markers.forEach((marker) => {
    // crea el popup con información html desde info_index
    const popup = new mapboxgl.Popup().setHTML(marker.info_index);
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup) // add this
      .addTo(map);
  })
}

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    // crea el popup con información html desde info_window
    const popup = new mapboxgl.Popup().setHTML(marker.info_window); // add this
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup) // add this
      .addTo(map);
  });
};


const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/pablo120/cksy627uq02gi17o2gadvnhif'
      // en caso de fallar el diseño establecido,
      // utilizar el siguiente
      //'mapbox://styles/mapbox/streets-v10'
    });
    map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMapIndex(map, markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);

  }
};

export { initMapbox };