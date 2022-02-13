import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-loader"
export default class extends Controller {
  static values = { url: String, refreshInterval: Number }

  connect() {
    this.load()
  
    if (this.hasRefreshIntervalValue) {
      this.startRefreshing()
    }
  }

  disconnect() {
    this.stopRefreshing()
  }

  startRefreshing() {
    this.interval = setInterval(() => {
      this.load()
    }, this.refreshIntervalValue)
  }

  load() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html);
    console.log('load called');
  }

  stopRefreshing() {
    clearInterval(this.interval);
  }
}
