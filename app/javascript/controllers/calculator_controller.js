
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Hello from our first Stimulus controller")

    
    const address = "3 rue jean Robert 75018 Paris"

    let url = `https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=${address}&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=${key}`


    console.log(url)
    // fetch(url, {
    //   method: "GET",
    //   mode: 'no-cors',
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Access-Control-Allow-Origin': '*'
    //     }
    //   })
    //   .then(response => response.json())
    //   .then((data) => {
    //     console.log(data)
    //   })

    fetch(url, {
      headers: {
        "Access-Control-Allow-Origin": '*'
      }
      })
        .then(response => response)
        .then((data) => {
          console.log(data)
        })
    }
  }
