import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    let marker = JSON.parse(this.element.dataset.mapboxMarkersValue)

    mapboxgl.accessToken = this.apiKeyValue
    if (!mapboxgl.supported()) {
      alert('Your browser does not support Mapbox GL');
      } else {
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      zoom : 15,
      center : [marker.lng, marker.lat]
    });
  }

  }
    addMarker(marker){
      new mapboxgl.Marker({color: 'black', rotation: 45}).setLngLat([marker.lng,marker.lat]).addTo(this.map);
    }



  }
