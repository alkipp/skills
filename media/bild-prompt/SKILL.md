---
name: bild-prompt
description: Writing image prompts — six building blocks in fixed order, word lists, negative prompts per model family, a length rule, and iteration with exactly one variable. Companion to the image-generation tooling.
---

# Building an image prompt

Purpose: turn a wish in plain language into **one** prompt that separates
subject, style and technique, in a single pass.

Based on fokus-KI, "Prompts für KI-Bilder" (April 2026), extended with the
limits of the models actually in use here (Z-Image-Turbo, FLUX.2 Klein, SDXL).

## When to load

- "Generate an image of …", "write me a prompt for …"
- A result misses and the prompt needs sharpening
- Before the first image, when the request names only a subject

Out of scope: settings and tool choice (the generation skill), storage in a
vault (the assets skill), graphics from SVG.

## The six building blocks

Order matters: the model weights the beginning more heavily. Subject before
style, style before technique.

| # | Block | Question | Example |
|---|---|---|---|
| 1 | **Image type** | photo, illustration, 3D, painting? | `photorealistic`, `flat vector illustration`, `3D render` |
| 2 | **Main subject** | what exactly, with which traits? | `tabby cat, green eyes, looking up` |
| 3 | **Setting** | where, with which props? | `window sill, blurred garden behind` |
| 4 | **Time / light** | time of day, season, light source | `early morning, warm side light from the left` |
| 5 | **Style** | artist, era, mood, palette | `in the style of Gustav Klimt, gold tones, calm` |
| 6 | **Technique** | perspective, detail level, composition | `close-up, shallow depth of field, rule of thirds` |

Rule: **1 and 2 are required, 3–6 are optional.** Filling all six when the
request does not support it yields an arbitrary image. Four concrete blocks
beat six vague ones.

## Template

```
<image type> of <subject with 2–3 traits>, <setting>, <light>,
<style/mood/colors>, <perspective/detail/composition>
```

Example:

> Photorealistic: traditional Japanese tea house beside a still pond,
> blossoming cherry trees, soft late-afternoon light, warm earth tones,
> slightly elevated perspective, reflections in the water, calm meditative mood.

One sentence, not a pile of keywords. Punctuation and commas are enough
weighting; brackets, `::` and `--ar` are understood by none of the three
models.

## Length and language

- **Core 15–50 words.** Longer dilutes: attention spreads across subordinate
  clauses instead of the subject.
- **English is the safe default.** Style terms (`golden hour`,
  `volumetric light`, `shallow depth of field`) and artist names are
  predominantly English in training data; translations often miss the nuance.
- **German works** with multilingual text encoders for subjects and spatial
  descriptions. With SDXL or FLUX-class models, translate when in doubt — a
  German style term can fall flat there.
- **Do not mix.** A half-German, half-English sentence costs consistency. One
  language per prompt.
- **Open:** German versus English at the same seed is not measured yet with
  these models. Until then English is the default; if a German prompt clearly
  underperforms, change the language first, not the step count.

## Negative prompts: only where the field exists

| Tool family | Negative prompt | Approach |
|---|---|---|
| SDXL | yes | collect wishes there: `text, watermark, extra fingers, blurry, deformed` |
| Z-Image, FLUX | no | **rephrase the negation positively**: "no text" → `clean surface without lettering` |

A "no …" in the positive prompt often works as an invitation: the model reads
the noun, not the negation.

## Iteration: one variable per run

1. **First run** at low step count, note the seed.
2. **Name the finding**, do not re-describe the image: "steam is missing" is a
   finding, "doesn't look good" is not.
3. **Exactly one change** — a subject addition, the style, or the steps. Keep
   the seed, otherwise the comparison is worthless.
4. **Second run only after a visible flaw.** No nudging on suspicion.
5. For fine detail (steam, smoke, lettering), raise the step count first, do not
   lengthen the prompt.

## What models cannot do reliably

| Wish | Reality | Way out |
|---|---|---|
| readable text in the image | letters dissolve, especially under six characters | set the text afterwards (SVG, layout tool) |
| hands, fingers, teeth | count and shape are often wrong | crop away the hands |
| exact count ("three candles") | sometimes two, sometimes four | count in the image, otherwise change the seed |
| era ("1750", "Edo") | years are not a feature — the background gains power lines, metal and solar roofs, concrete | set the era via **materials**: `every roof thatched with rice straw or dark cedar shingles`, `hand-hewn wooden posts`, `unpaved road` |
| brand logo, real face | blurry or distorted | do not aim for it; rights and personality rights |
| "4K", "16:9" in the sentence | read as a style word, not a measurement | set `width`/`height` in the tool |

## Checklist before sending

1. Is the subject within the first ten words?
2. Are image type and style named separately (not "a nice picture")?
3. At most one style term and one light direction — or deliberately two?
4. No negation in the positive prompt?
5. Under fifty words, without numbers the tool already sets?
6. One language throughout?

## Failure modes

| Symptom | Cause | Fix |
|---|---|---|
| subject missing, landscape dominates | setting first or too long | move the subject to the front, cut the setting to five words |
| image feels arbitrary, "stock photo" | only adjectives, no style | name one concrete style or artist |
| everything sharp and flat | no perspective, no light | `close-up` or `slightly elevated` plus one light direction |
| colours drift | two style directions fighting | one palette, one style |
| text appears as scribble | text wish inside the prompt | remove it, set the text afterwards |
| result changes wildly despite a small edit | seed or step count changed | fix the seed, hold the steps constant |
| power pole, wires or solar roof in the background | a year does not steer an era; the model fills in infrastructure from training | prescribe materials positively (`every roof thatched or dark cedar shingles`, `hand-hewn wooden posts`), not "no power lines" — and check the background, not just the subject |

## Source

- <https://www.fokus-ki.de/ki-tipps-know-how/prompts-fuer-bilder-so-gelingt-das-perfekte-ki-bild/>
