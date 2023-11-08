
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.loadGTag();
  }

  loadGTag() {
    const script1 = document.createElement('script');
    script1.async = true;
    script1.src = 'https://www.googletagmanager.com/gtag/js?id=G-11H7YH95XC';
    document.head.appendChild(script1);

    script1.onload = () => {
      const script2 = document.createElement('script');
      script2.innerHTML = `
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-11H7YH95XC');
      `;
      document.head.appendChild(script2);
    };
  }
}
