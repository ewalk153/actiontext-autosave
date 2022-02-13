import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-autosaver"
export default class extends Controller {
  static values = { 
    url: String, 
    refreshInterval: Number,
    articleContent: String,
    currentValue: String,
  }

  connect() {
    this.prepare();
  
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

  prepare() {
    this.currentValue = this.getContent();
  }

  load() {
    // client side or server side dedupe content
    // client side: only send if it's has changed
    // server side, check most recent draft and only change if it has changed
    const contentValue = this.getContent();
    if (this.currentValue === contentValue) {
      console.log("values match, not saving a new version.");
      console.log(this.currentValue, contentValue);
      return;
    }
    const data = new URLSearchParams();

    data.append("authenticity_token", this.getAuthToken());
    data.append("draft_article[content]", contentValue);

    fetch(this.urlValue, {
      method: 'post',
      body: data,
    })
      .then(response => response.text())
      .then(html => this.element.innerHTML = html);
      this.currentValue = contentValue;
      console.log('save complete.');
  }

  getContent() {
    return document.getElementById(this.articleContentValue).value;
  }

  getAuthToken() {
    return document.querySelector('meta[name="csrf-token"]').content;
  }

  stopRefreshing() {
    clearInterval(this.interval);
  }
}
