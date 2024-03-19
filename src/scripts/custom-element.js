customElements.define('custom-element', class CustomElement extends HTMLElement {
  static observedAttributes = ["color", "size"]

  constructor() {
    super()
  }

  connectedCallback() {
    console.log("Custom element added to page.")
  }

  disconnectedCallback() {
    console.log("Custom element removed from page.")
  }

  adoptedCallback() {
    console.log("Custom element moved to new page.")
  }

  attributeChangedCallback(name, oldValue, newValue) {
    console.log(`Attribute ${name} has changed.`)
  }
})