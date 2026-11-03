# skills

Agent skills: short, opinionated instruction files for AI coding agents.
A skill is a directory with a `SKILL.md` and optional `references/`. The format
is plain Markdown with YAML front matter, so it works in Claude Code, OpenCode,
Codex, and anything else that reads `SKILL.md`.

## What is in here

| Skill | What it does |
|---|---|
| [`ki/humor`](ki/humor/SKILL.md) | Tone in chat: forms that work in text, forms that fail without a voice, four hard limits, and a dial the user controls. |
| [`media/bild-prompt`](media/bild-prompt/SKILL.md) | Writing image prompts: six building blocks in order, length and language rules, negative prompts per model family, one variable per iteration. |

## Install

```bash
git clone https://github.com/alkipp/skills.git
mkdir -p ~/.config/opencode/skills
cp -r skills/ki/humor ~/.config/opencode/skills/
```

For Claude Code, copy the same directory into `~/.claude/skills/`.

## Rules for this repository

- English only: docs, comments, commit messages, issue and PR text.
- One directory per skill, grouped by topic. Directory names are skill ids and
  stay stable; only the content is translated.
- No secrets, no host names, no server or work directory paths, no private
  service names. Examples are illustrative and generic.
- A skill states what to do, not what it knows. If a rule cannot change a
  decision, it does not belong in the file.

## Before publishing

Every push must pass the safety check:

```bash
scripts/check-public.sh
```

It fails on host names, private IP ranges, server and work directory paths, and
private service names. If it fails, edit the content — not the pattern.

## License

Everything here is licensed under [CC BY 4.0](LICENSE).
