---
name: Obsidian Format
description: Consistent formatting for Obsidian markdown pages — H2 structure, lead lines, Prism viz tables, coloured hint and warning cards, code cards, theme-aware colours.
---

# Obsidian Format

Purpose: uniform, high-quality formatting for **markdown pages** in an
Obsidian vault. Applies to new documentation and planning notes as well as to
any page that is explicitly reformatted. Canvas files (`.canvas`) are not
markdown — use the canvas skill for those.

## When to load

- Before creating or reworking a formatted vault page.
- As soon as tables, hints, warnings or code blocks appear.
- When an existing page is brought up to the current formatting.
- Not needed for pure data lookups without a write.

## Basic structure

- **Title:** exactly one `#` heading.
- **Sections:** plain markdown H2, no numbering.
- **Lead:** directly under each H2, one short italic line with the core of the
  section.
- **No long bullet lists:** short lists as a checklist or a table.
- **Concrete, specific:** values, paths, decisions instead of vague statements.
- **No secrets:** tokens, passwords and keys never in notes.

## Tables

Tables are **not** written as markdown tables but as a Prism `viz` block with
HTML and the style from `references/table.css`.

Pattern:

```viz
<style>
/* paste the content of references/table.css here */
</style>
<div class="gt-wrap"><table class="gt gt-num">
<thead><tr><th>#</th><th>Approach</th><th>Strength</th><th>Role</th></tr></thead>
<tbody>
<tr><td><span class="num">01</span></td><td><span class="dot blue"></span><strong>Title</strong></td><td>Short statement</td><td><span class="tag green">Goal</span></td></tr>
</tbody></table></div>
```

Rules:

- A `viz` block contains **exactly one root** (e.g. `.gt-wrap`).
- Paste the CSS from `references/table.css` into the block; Prism isolates
  the blocks.
- First column of numbered tables: `.num` as `01`.
- Category dots: `.dot blue|green|amber|red|violet|gray`.
- Status/role: `.tag` with the same palette.
- Licences: `.lic` with `green` (permissive), `amber` (MPL), `violet`
  (font), `blue` (own project).
- No markdown tables in the finished page.
- No wide tables without need; long prose does not belong in cells.

## Hints and warnings

Hints, tips, warnings and hard limits are shown as a coloured card with a small
SVG pictogram. CSS: `references/callout.css`.

Variants:

- `info` — blue, orientation/goal
- `tip` — green, recommendation/shortcut
- `warn` — amber, limitation/caution
- `danger` — red, prohibition/risk

Pattern:

```viz
<style>
/* paste the content of references/callout.css here */
</style>
<div class="hint tip">
  <div class="hint-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M9 18h6"/><path d="M10 22h4"/><path d="M12 2a7 7 0 0 0-4 12.7c.6.5 1 1.2 1 2V17h6v-.3c0-.8.4-1.5 1-2A7 7 0 0 0 12 2Z"/></svg></div>
  <div><div class="hint-title">Title</div><div class="hint-body">Short text.</div></div>
</div>
```

Rules:

- SVG size inside the icon: **17 × 17 px**, no large pictograms.
- Icon and title in the card colour, text in `var(--text-normal)`.
- No callout emojis or theme callouts for these cards.
- At most one card per section; do not decorate every statement.

## Code

Code is shown as a Prism `viz` code card, not as a fenced code block with a
language tag. CSS: `references/code-card.css`.

Pattern:

```viz
<div class="cc"><div class="cch">bash</div><pre>cargo test</pre></div>
<style>
/* paste the content of references/code-card.css here */
</style>
```

Rules:

- No fenced code blocks with a language tag (`bash`, `jsonc`, `text` …); the
  theme otherwise renders huge language icons.
- Label in the header short and lower case (`bash`, `jsonc`, `topology`).
- Keep code unchanged and copyable.
- No secrets in code cards.

## Colours

- Always mix colours theme-aware:
  `color-mix(in srgb, <color> 75%, var(--text-normal))`.
- Backgrounds subtle: 6–15 % of the accent colour.
- Borders: 20–28 % of the accent colour.
- No fixed light or dark text colours; use `var(--text-normal)` and
  `var(--text-muted)`.
- Palette: blue `#5B8DEF`, green `#4FA37A`, amber `#D9A441`, red
  `#D96C6C`, violet `#8B7BD8`, gray `#8A94A6`.

## Check before finishing

- [ ] Exactly one H1; H2 without numbers; short italic leads.
- [ ] No markdown tables left in the page.
- [ ] Every table is a `viz` block with one root and its own CSS.
- [ ] Dots, tags and licence badges colour-consistent.
- [ ] Hints and warnings as cards with small SVG icons.
- [ ] Code as a `viz` code card, no language tag.
- [ ] Reading mode checked: no source leftovers, no oversized icons.
- [ ] Light and dark mode checked.
- [ ] No unresolved links, no secrets.

## Files

- `references/table.css` — tables, dots, tags, licences
- `references/callout.css` — hint and warning cards
- `references/code-card.css` — code cards

## Typical mistakes

- Leaving markdown tables in place and only "prettifying" the header row.
- Putting CSS into a `viz` block but placing the table as a second root node
  next to it; Prism then renders only part of it.
- Writing language tags on code blocks; the theme turns them into large icons.
- Designing colours fixed for light or dark only.
- Mixing hint cards with emoji or theme callouts.
- Forcing every list into a table; short checklists are better.
