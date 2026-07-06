# prof-x

Opinionated skill suite installed at `~/.claude/skills/prof-x/`. Available skills:

- `/plan-prod-review` — CPO / staff PM plan review. Rethink the problem, align on the outcome, prep for breakdown and handoff.
- `/plan-eng-review` — Eng manager / tech lead review. Lock in architecture, data flow, diagrams, edge cases, and tests.
- `/review` — Paranoid staff engineer. Find the bugs that pass CI but blow up in production. Not a style nitpick pass.
- `/investigate` — Systematic debugger. Root-cause investigation before any fix. Iron Law: no fixes without root cause.
- `/pr-review` — Critical review of a PR authored by someone other than self. Wraps the `pr-review-toolkit` plugin and adds Linear-awareness plus file output.
- `/ship` — Release engineer. Sync main, run tests, review diff, bump VERSION, update CHANGELOG, commit, push, open PR. For a ready branch.
- `/retro` — Engineering manager. Weekly retrospective over commit history, work patterns, and shipping velocity.
- `/browse` — QA / dogfooding browser. Drive headless Chromium via `playwright-cli`: navigate, interact, assert element state, diff before/after, screenshot, check responsive layouts, inspect console/network.
