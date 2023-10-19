import { Controller } from "stimulus";
import { Turbo } from "@hotwired/turbo";

export default class extends Controller {
  connect() {
    if (process.env.NODE_ENV === "production") {
      this.loadScript();
      this.registerTurboEvents();
    }
  }

  loadScript() {
    const script = document.createElement("script");
    script.src = "https://www.googletagmanager.com/gtag/js?id=YOUR_TRACKING_ID";
    script.async = true;
    document.head.appendChild(script);

    script.addEventListener("load", () => {
      window.dataLayer = window.dataLayer || [];
      function gtag() { dataLayer.push(arguments); }
      gtag('js', new Date());
      gtag('config', 'YOUR_TRACKING_ID');
    });
  }

  registerTurboEvents() {
    document.addEventListener("turbo:load", () => {
      if (typeof gtag === 'function') {
        gtag('event', 'page_view', {
          page_location: window.location.href,
          page_path: window.location.pathname,
          page_title: document.title,
        });
      }
    });
  }
}
