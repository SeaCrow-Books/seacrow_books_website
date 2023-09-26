# SeaCrow Site


# STYLING - BEM (Block, Element, Modifier)

BEM is a naming convention for writing cleaner and more readable class names in HTML and CSS. It helps in understanding the relationship between the HTML and CSS in a project.

## Concepts:

- **Block**: A standalone component that is meaningful on its own.
- **Element**: A part of a block that has no standalone meaning and is semantically tied to its block.
- **Modifier**: A flag on a block or element, used to change appearance or behavior.

## Naming Convention:

- **Block**: `.block`
- **Element**: `.block__element`
- **Modifier**: `.block--modifier` or `.block__element--modifier`

## Advantages:

- Increases readability and understanding of the structure.
- Offers a clear set of rules for naming.
- Helps in maintaining a consistent CSS architecture, especially in large-scale projects.
- Eases the scaling of CSS and facilitates teamwork.

## Usage Example:

\```html
<!-- Block component -->
<div class="block">

    <!-- Element inside block -->
    <div class="block__element"></div>

    <!-- Modified version of block -->
    <div class="block block--modifier"></div>

</div>
\```

Corresponding CSS:

\```css
.block {
  /* styles for block */
}

.block__element {
  /* styles for element inside block */
}

.block--modifier {
  /* modified styles for block */
}
\```

## Considerations:

- It may feel verbose at first.
- It doesn't prescribe how to structure your CSS (e.g., SCSS, LESS), just how to name classes.
- Works well in combination with preprocessors like SCSS, due to nested rules which mirror the BEM structure.

## Extensions & Variations:

Over time, various adaptations of BEM have emerged, tweaking the conventions to fit specific needs or preferences. It's essential to be consistent, no matter the chosen naming approach.

```html
<div>

    <!-- Title Block for the Post Model -->
    <div class="post-title">
        <h1 class="post-title__heading">title</h1>
    </div>

    <!-- List Block - Consistent across the site -->
    <div class="list-block">
        <ul class="list-block__list">
            <li class="list-block__item">Item one</li>
            <li class="list-block__item">Item two</li>
        </ul>
    </div>

    <!-- Description Block specific to the Post Model's show page -->
    <div class="post-view__description">
        <p class="post-view__description-text">This is text</p>
    </div>

</div>
