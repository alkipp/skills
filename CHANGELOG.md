# Changelog

All notable changes to this repository. Format based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), versioning follows
[Semantic Versioning 2.0.0](https://semver.org/).

## [0.1.0] - 2026-11-03

### Added

- **`ki/humor`**: tone in chat. Structure (setup, turn, punchline last), eleven
  forms that work in text, seven that fail without a voice, four hard limits, a
  humor dial the user controls, dosage rules, situational humor, a callback
  repertoire, a pre-send checklist.
- **`media/bild-prompt`**: image prompt craft. Six building blocks in fixed
  order, length and language rules, negative prompts per model family,
  iteration with one variable, limits of current models, failure table.
- **`LICENSE`**: CC BY 4.0 for the whole repository.
- **`scripts/check-public.sh`**: generic safety check (private IP ranges,
  absolute server and home paths, private keys, token shapes). The list of
  private names lives in `.check-names`, which is gitignored.
- **`scripts/check-names.example`**: format of that local list, without real
  names.
