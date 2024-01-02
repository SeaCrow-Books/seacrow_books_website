// Google Analytics code
document.addEventListener("turbo:load", function(event) {
    window.dataLayer = window.dataLayer || []
    function gtag(){dataLayer.push(arguments)}
    gtag('js', new Date())
    gtag('config', 'G-9MEFG153GW', {'page_location': event.detail.url})
  }, false)