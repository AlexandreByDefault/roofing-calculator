// // Visit The Stimulus Handbook for more details
// // https://stimulusjs.org/handbook/introduction
// //
// // This example controller works with specially annotated HTML like:
// //
// // <div data-controller="hello">
// //   <h1 data-target="hello.output"></h1>
// // </div>

// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = [ "output","address" ]
//   static values = { apiKey: String }

//   connect() {
//     console.log("Je suis connecté")
//     this.#setInputValue()
//     this.#clearInputValue()
//     this.geocoder = new MapboxGeocoder({
//       accessToken: this.apiKeyValue,
//       types: "country,region,place,postcode,locality,neighborhood,address"
//     });
//     this.geocoder.addTo(this.element)

//     this.geocoder.on("result", event => this.#setInputValue(event))
//     this.geocoder.on("clear", () => this.#clearInputValue())


//   }
//   #setInputValue(event) {
//     this.addressTarget.value = event.result["place_name"]
//     console.log(event.result["place_name"])
//   }

//   #clearInputValue() {
//     this.addressTarget.value = ""
//   }


// }
