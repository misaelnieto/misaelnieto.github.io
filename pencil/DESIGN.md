# Design System Documentation: The Intellectual Artifact



## 1. Overview & Creative North Star



**Creative North Star: The Scholarly Monograph**

This design system rejects the ephemeral nature of modern web "templates" in favor of the permanence and authority of a 19th-century technical treatise. We are not building a "site"; we are curating a digital manuscript. The experience must feel heavy, tactile, and intellectually rigorous.



The design breaks the standard grid by utilizing **intentional asymmetry** and **typographic architecturalism**. We move away from digital "components" and toward "plates" and "folios." Every pixel must look as though it were pressed into heavy-stock cream paper by a manual letterpress. We achieve premium status not through motion or shadows, but through the mastery of white space (leeway) and the rhythmic pacing of serif typography.



---



## 2. Colors



The palette is a disciplined study in ink-on-paper. It mimics the natural aging and high-pigment constraints of 1800s printing.



* **Background (`#FCF9F4`)**: Our primary "Paper" tone. It is warm, non-reflective, and provides a historical substrate.

* **On-Surface/Ink (`#1C1C19`)**: A deep, charcoal black. Avoid true `#000000` to prevent a digital "starkness" that breaks the immersion.

* **Secondary Spot (`#E65100`)**: Burnt Orange. This is our "Rubrication." Use it exclusively for high-level emphasis—think hand-inked marginalia or a master craftsman's stamp.



### The "No-Container" Rule

In this system, 1px solid borders for sectioning are strictly forbidden unless they are decorative *filetes* (see Typography).

* **Boundaries** must be defined by shifts in the `surface-container` tiers.

* **Nesting**: To elevate a piece of content (like a technical diagram), place it on a `surface-container-low` background to create a subtle "inset" feel.

* **Prohibition of Gradients/Blurs**: To honor the 19th-century constraint, no modern CSS blurs or digital gradients are allowed. Depth is achieved through "Tonal Layering"—stacking different paper-tone tokens to create a physical sense of overlapping sheets.



---



## 3. Typography



**Primary Typeface: Newsreader**

Newsreader is chosen for its optical sizing and calligraphic heritage. It mimics the slight "ink bleed" of metal type.



* **Display & Headlines**: Use `display-lg` and `headline-lg` for chapter starts and section headers. These should be set with wide margins to allow the letterforms to breathe.

* **The Editorial Lead**: Large headlines should often be centered or aggressively offset to the left to create an asymmetrical, editorial rhythm.

* **Body Copy**: Use `body-lg` (1rem) for the narrative. Line height should be generous (utilizing the 1.7rem or 2rem spacing scale) to ensure maximum legibility and a "technical manual" feel.

* **Labels & Captions**: Use `label-sm` in all-caps or italics to mimic the notations found in botanical or engineering lithographs.



---



## 4. Elevation & Depth



We achieve depth through **Tonal Layering**, not shadows.



* **The Layering Principle**: Instead of a shadow, use `surface-container-highest` to indicate a "pressed" or "raised" area. For example, a "Floating" navigation bar should actually be a full-width block of `surface-container-low` that sits at the top of the scroll, separated by a single, sober *filete* line.

* **The "Sober Line" (Filete)**: When a visual break is required, use a thin horizontal line using the `outline` token. This line should never "box" content; it should act as a terminal or a separator between the header and the body, reminiscent of bookplates.

* **Roundedness**: All elements have a **0px radius**. Curves are the enemy of the letterpress. Sharp, architectural corners are mandatory for all buttons, containers, and inputs.



---



## 5. Components



### Buttons (The "Printer's Block")

* **Primary**: Solid `on_surface` (#1C1C19) background with `on_primary_container` (#FFFFFF) text. Rectangular, no rounding.

* **Secondary**: A "Ghost" style. No background, but a 1px border of `outline` (#777777).

* **Emphasis**: Use the `secondary` (#A83900) burnt orange for critical actions, but only once per view.



### Input Fields

* **Style**: Bottom-border only, using the `outline` token.

* **Labels**: Floating `label-md` text that appears in italics when the field is active, mimicking handwritten ledger entries.



### Cards & Lists

* **Forbid Dividers**: Use vertical white space (`spacing-8` or `spacing-10`) to separate list items.

* **Technical Plates**: Use a `surface-container-low` background for images or diagrams. Diagrams must be HD line art or lithographic engravings—never photographs or modern renders.



### The Decorative Flourish (Signature Component)

Introduce a "Flourish" component: a small, centered svg of a Victorian woodcut ornament (fleuron) to signify the end of a major section. This reinforces the "Book" mental model.



---



## 6. Do's and Don'ts



### Do:

* **Use Asymmetry**: Place pull-quotes in wide margins to the left or right of the main text block.

* **Embrace "Ink-Heavy" Moments**: Use large blocks of `on_surface` with light text for high-contrast "Interstitials" or chapter covers.

* **Respect the "Paper"**: Ensure at least 40% of the screen remains the raw `background` (#FCF9F4) color.



### Don't:

* **No Rounded Corners**: 0px means 0px. Even a 2px radius destroys the "printed" illusion.

* **No Shadows**: Depth must be flat. If a button needs to feel "active," shift its color to `secondary` or change the background tone.

* **No Icons**: Use labeled text or technical woodcut illustrations. Standard "hamburger" icons or "gear" icons feel too modern; replace them with text-labels like "INDEX" or "APPARATUS."



---



## 7. Spacing Scale Implementation



Use the spacing scale to drive the hierarchy.

* **Margin-Global**: `spacing-12` (4rem) for desktop layouts to create that luxurious, wide-margin monograph look.

* **Paragraph Spacing**: `spacing-4` (1.4rem) between text blocks.

* **Section Break**: `spacing-24` (8.5rem) to signify a major topical shift.



By adhering to these constraints, you create a digital environment that feels like it has been authored, not just generated. Every element should feel as though it was placed by a typesetter's hand.