import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["todos", "field"]

  errorResult(event) {
    console.log("error", event.detail)
  }

  successResult(event) {
    const response = event.detail[0]
    const todoHTML = document.createRange().createContextualFragment(response.html)

    this.todosTarget.prepend(todoHTML)
    this.fieldTarget.value = ""
  }

  validateSubmit(event) {
    if (this.fieldTarget.value === "") {
      event.preventDefault()
    }
  }
}
