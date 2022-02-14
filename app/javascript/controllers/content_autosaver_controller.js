import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-autosaver"
export default class extends Controller {
  static values = { 
    url: String, 
    refreshInterval: Number,
    contentSourceElementId: String,
    contentSubmissionField: String,
    currentValue: String,
  }

  connect() {
    this.prepare();
  
    if (this.hasRefreshIntervalValue) {
      this.startRefreshing();
    }
  }

  disconnect() {
    this.stopRefreshing();
  }

  startRefreshing() {
    this.interval = setInterval(() => {
      this.load()
    }, this.refreshIntervalValue);
  }

  prepare() {
    this.currentValue = this.getContent();
  }

  load() {
    const contentValue = this.getContent();
    if (this.currentValue === contentValue) {
      return;
    }
    const data = new URLSearchParams();

    data.append("authenticity_token", this.getAuthToken());
    data.append(this.contentSubmissionFieldValue, contentValue);

    fetch(this.urlValue, {
      method: 'post',
      body: data,
    })
      .then(response => response.text())
      .then(html => this.element.innerHTML = html);
      this.currentValue = contentValue;
  }

  getContent() {
    return document.getElementById(this.contentSourceElementIdValue).value;
  }

  getAuthToken() {
    return document.querySelector('meta[name="csrf-token"]').content;
  }

  stopRefreshing() {
    clearInterval(this.interval);
  }
}
