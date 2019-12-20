import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["item"]

  errorResult(event) {
    console.log(event.detail)
  }

  successResult(event) {
    event.preventDefault()
    this.itemTarget.remove()
  }
}
