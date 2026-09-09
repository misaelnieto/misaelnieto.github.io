---
name: design-system
description: "Apply the project's design system — \u201CThe Intellectual Artifact\u201D (19th-century letterpress/monograph aesthetic) — when writing or editing CSS, HTML/Tera templates, theme files, colors, typography, spacing, or any UI component. Use whenever touching templates/, the paper (#FDFCF0) / ink (#1C1C19) / rubric (#E65100) palette, surface-container tokens, the Newsreader type scale, heading hierarchy, or any visual styling on the site. This is the authoritative source for color tokens, typography, elevation, spacing, and component rules — consult it before generating or modifying any visual markup."
compatibility: opencode
metadata:
  audience: designers
---

# Design System: The Intellectual Artifact

## 1. Overview & Creative North Star

**North Star: The Scholarly Monograph.** Reject ephemeral web "templates" in favor of the permanence and authority of a 19th-century technical treatise. We are not building a "site"; we are curating a digital manuscript — heavy, tactile, intellectually rigorous.

The design breaks the standard grid via **intentional asymmetry** and **typographic architecturalism**, trading digital "components" for "plates" and "folios." Every pixel must feel pressed into heavy-stock cream paper by a manual letterpress. Premium status comes not from motion or shadows, but from mastery of white space and the rhythmic pacing of serif typography.

---

## 2. Colors

A disciplined study in ink-on-paper, mimicking the aging and pigment constraints of 1800s printing.

- **Background `#FDFCF0`** — "Paper." Warm, non-reflective, the historical substrate.
- **On-Surface / Ink `#1C1C19`** — Deep charcoal. Avoid true `#000000`; it breaks immersion with digital starkness.
- **Secondary Spot `#E65100`** — Burnt Orange "Rubrication." Reserved for high-level emphasis only (hand-inked marginalia, a master craftsman's stamp).

### The "No-Container" Rule

- 1px solid borders for sectioning are **forbidden** unless they are decorative *filetes* (see Typography).
- **Boundaries** are defined by shifts in the `surface-container` tiers.
- **Nesting**: to elevate content (e.g., a technical diagram), place it on `surface-container-low` for a subtle "inset."
- **No Gradients/Blurs**: depth comes from "Tonal Layering" — stacking paper-tone tokens to suggest overlapping sheets.

---

## 3. Typography

**Primary Typeface: Newsreader** — chosen for optical sizing and calligraphic heritage; mimics the "ink bleed" of metal type.

- **Display & Headlines** (`display-lg`, `headline-lg`): chapter starts and section headers, set with wide margins so letterforms breathe.
- **Editorial Lead**: large headlines centered or aggressively left-offset for an asymmetrical, editorial rhythm.
- **Body Copy** (`body-lg`, 1rem): generous line-height (1.7rem–2rem scale) for a "technical manual" legibility.
- **Labels & Captions** (`label-sm`): all-caps or italics, mimicking lithograph notation.

### Heading Hierarchy: The Scholar's Cadence

Four tiers distinguished not by color or family but by typographic flourish — a 19th-century typesetter's restraint:

- **`h2` — The Division**: auto-incremented Roman numeral (`I.`, `II.`, `III.`) in italic serif rubric. Primary structural unit (chapter heading).
- **`h3` — The Section**: single em-dash (`—`) in muted ink. Sub-topic within a division.
- **`h4` — The Sub-section**: double em-dash (`——`), italic. Used sparingly.
- **`h5` — The Note**: unadorned; weight alone. Rare (e.g., definitions).

All wrapped headings receive the **rubric** (`#E65100`) and a `§` anchor on hover, mimicking marginal cross-references. This apparatus applies to **page and post bodies** (`.entry-content`); the résumé and homepage keep their bespoke numbering via `.section-numeral`.

---

## 4. Elevation & Depth

Depth comes from **Tonal Layering**, not shadows.

- **Layering Principle**: use `surface-container-highest` for "pressed"/"raised" areas. A "floating" nav bar is really a full-width block of `surface-container-low` at the top of scroll, separated by a single sober *filete*.
- **The Sober Line (Filete)**: a thin horizontal `outline` line for visual breaks. Never "box" content — it terminates or separates (header↔body), like a bookplate.
- **Roundedness**: **0px radius** everywhere. Curves are the enemy of the letterpress; sharp architectural corners for buttons, containers, inputs.

---

## 5. Components

### Buttons ("Printer's Block")

- **Primary**: solid `on_surface` (`#1C1C19`) background, `on_primary_container` (`#FFFFFF`) text. Rectangular, no rounding.
- **Secondary**: "Ghost" — no background, 1px `outline` (`#777777`) border.
- **Emphasis**: `--color-rubric-dark` (`#BF4200`) burnt orange, max once per view.

### Input Fields

- **Style**: bottom-border only, `outline` token.
- **Labels**: floating `label-md`, italic when active — handwritten ledger entries.

### Cards & Lists

- **Forbid dividers**: separate items with vertical whitespace (`spacing-8` / `spacing-10`).
- **Technical Plates**: `surface-container-low` background for images/diagrams. HD line art or lithographic engravings only — never photographs or modern renders. **To generate illustrations, use the `ilustracion` skill** (vintage engraving/lithography prompts); see section 8 for format rules.

### The Decorative Flourish (Signature Component)

A small, centered SVG of a Victorian woodcut ornament (fleuron) marking the end of a major section — reinforcing the "Book" mental model.

---

## 6. Do's and Don'ts

### Do

- **Use Asymmetry**: pull-quotes in wide margins flanking the main text block.
- **Embrace Ink-Heavy Moments**: large blocks of `on_surface` with light text for "Interstitials" or chapter covers.
- **Respect the Paper**: ≥40% of the screen stays raw `background` (`#FDFCF0`).

### Don't

- **No Rounded Corners**: 0px means 0px. A 2px radius already destroys the illusion.
- **No Shadows**: depth must be flat. For an "active" feel, shift to `secondary` color or change the background tone.
- **No Icons**: use labeled text or technical woodcut illustrations. Replace "hamburger"/"gear" icons with text labels like "INDEX" or "APPARATUS."
- **No Top Air**: never add `padding-top` to `body` or `body > header` (including media queries) — see §7 Page Frame. Vertical space is reserved for content, not dead air above the header.

---

## 7. Spacing Scale

- **Margin-Global** `spacing-12` (4rem): desktop layouts, the luxurious wide-margin monograph look.
- **Paragraph Spacing** `spacing-4` (1.4rem): between text blocks.
- **Section Break** `spacing-24` (8.5rem): signals a major topical shift.

### Page Frame — Zero Top Waste (enmienda 2026-09)

**Regla autoritativa:** `body` y `body > header` llevan `padding-top: 0` en todos los breakpoints. El desperdicio vertical arriba del header está prohibido.

- `body` (`static/css/atoms.css:16`): `padding: 0 clamp(...) clamp(...)` — top siempre `0`, incluso en `@media (max-width:1000px)` y `(max-width:600px)`.
- `body > header` (`static/css/organisms.css:4`): `padding: 0 2rem 1.5rem` — sin aire arriba; el respiro es inferior (`padding-bottom`) y el filete `border-bottom: 3px solid ink` hace de borde superior efectivo.
- **No reintroducir** `padding-top` en ningún media query ni override. El espacio lateral (`clamp` / `1.5rem` / `1rem`) y el inferior sí se conservan.
- Racional: la monografía no deja margen muerto sobre el encabezado; el contenido útil debe empezar en el primer píxel del viewport, como un pliego impreso a sangre en el borde superior.

---

## 8. Illustration Format

The CSS structurally favors **portrait and square** illustrations; horizontal banners fight the layout and lose impact. Use the `ilustracion` skill to generate the actual prompts — this section defines the *format* only.

| Placement | Format | Historical reference |
|---|---|---|
| **Hero / above-the-fold** (`.hero-figure`, 45% column) | **Portrait 3:4 or 2:3**, offset with wide margin to one side (asymmetric) | Frontispicio |
| **Embedded in body** (`figure`) | **Square 1:1** or portrait small | Viñeta / lámina |
| **Wide editorial space** (`.figure-grid`, 2-col) | **Diptych/triptych of portrait or square plates** | Láminas enfrentadas en un spread |
| **Panoramic subject only** (landscape, procession, architecture) | Horizontal allowed, kept shallow | Lámina plegable tipo Doré |
| **Headpieces / cabeceras** | *Por definir (TBD)* — not yet supported in CSS; decorative band (fleuron/scrollwork) is the historical model | Cabecera decimonónica |

**Rules**:
- Default to portrait; only go horizontal when the subject genuinely demands it.
- Cross-hatching detail needs vertical room — banners crush it.
- On mobile, floats/grid collapse to single column (`@media max-width: 768px` / `480px`); portrait/square survive the collapse, horizontal banners become a thin strip.

By adhering to these constraints, you create a digital environment that feels authored, not generated — every element placed by a typesetter's hand.
