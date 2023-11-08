import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  async loadChildren() {
    const categoryId = this.selectTarget.value;
    if (!categoryId) {
      this.clearChildCategories();
      return;
    }

    try {
      // Make a GET request to the server
      const response = await fetch(`/categories/${categoryId}/child_categories`);

      if (response.ok) {
        const frame = document.getElementById("child_categories_frame");
        if (frame) {
          // Update the frame with the response from the server
          frame.innerHTML = await response.text();
        }
      } else {
        throw new Error("Server responded with an error.");
      }
    } catch (error) {
      console.error("Failed to fetch child categories", error);
    }
  }

  clearChildCategories() {
    const frame = document.getElementById("child_categories_frame");
    if (frame) {
      frame.innerHTML = "";
    }
  }
}
