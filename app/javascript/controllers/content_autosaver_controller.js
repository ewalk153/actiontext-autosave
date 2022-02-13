import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-autosaver"
export default class extends Controller {
  static values = { 
    url: String, 
    refreshInterval: Number,
    articleForm: String,
  }

  connect() {
    // this.load() // we don't need to save right away
  
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
    const formElement = document.getElementById(this.articleFormValue);
    const data = new URLSearchParams();
    for (const pair of new FormData(formElement)) {
      data.append(pair[0], pair[1]);
    }

    const auth_token = document.querySelector('meta[name="csrf-token"]').content;
    data.append("authenticity_token", auth_token);
    data.append("draft_article[content]", data.get("article[content]"));

    data.delete("article[content]");
    data.delete("_method");    

    fetch(this.urlValue, {
      method: 'post',
      body: data,
    })
      .then(response => response.text())
      .then(html => this.element.innerHTML = "saved");
    console.log('load called');
  }

  stopRefreshing() {
    clearInterval(this.interval);
  }
}
