# Command ledger

This ledger records shell commands run during the formalization. Browser
submission to Aristotle and file edits through the patch interface are not
shell commands; Aristotle's output was not used as a proof dependency.

## Handoff and environment discovery

| Command | Exit/status |
|---|---:|
| `pwd && rg --files -g 'AGENTS.md' -g 'CODEX_TASK.md' -g 'lakefile.*' -g 'lean-toolchain' -g '*.lean' -g 'README*' \| sed -n '1,160p'` | 0 |
| `sed -n '1,260p' /Users/danielcabezas/.codex/skills/erdos-ledger-handoff/SKILL.md` | 0 |
| `rg -n -i 'A211420\|Lean\|formal.verification\|factorial ratio' /Users/danielcabezas/.codex/memories/MEMORY.md \| sed -n '1,120p'` | 0 |
| `unzip -l '/Users/danielcabezas/Downloads/A211420_Codex_Lean_Handoff_v1.zip' \| sed -n '1,240p'` | 0 |
| `unzip -q ... && shasum -a 256 -c SHA256SUMS && sed ...` (archive extraction, checksum verification, and governing-file read) | 0 |
| `lake --version; lean --version; which lake; which lean` | 1; tools absent |
| standard-location searches for `lean`, `lake`, `elan`, `lean-toolchain`, and `lakefile.toml` | 0; no installation found |
| `which brew && brew --version` | 1; Homebrew absent |
| `uname -m; sw_vers` | 0 |
| `curl -L https://api.github.com/repos/leanprover/elan/releases/tags/v4.2.1` | 0 |
| `curl -L https://github.com/leanprover/elan/releases/download/v4.2.1/elan-aarch64-apple-darwin.tar.gz -o /private/tmp/elan-aarch64-apple-darwin-v4.2.1.tar.gz` | 0 |
| `shasum -a 256 /private/tmp/elan-aarch64-apple-darwin-v4.2.1.tar.gz; tar -tzf ...` | 0; digest matched `3b3170...100c8` |
| first installer execution request | not executed; approval gate rejected it |
| `find a211420_codex_handoff_v1 -mindepth 1 -maxdepth 1 -exec mv -n {} . \; && rmdir ...` | 0 |
| `chmod +x scripts/verify.sh && git status --short && sed ...` | 0 |

## Approved toolchain and dependency setup

| Command | Exit/status |
|---|---:|
| `mkdir -p /private/tmp/elan-v4.2.1 && tar -xzf ... && /private/tmp/elan-v4.2.1/elan-init -y --default-toolchain none` | 0 |
| `ls -la ~/.elan/bin && ~/.elan/bin/elan --version && ~/.elan/bin/elan toolchain list` | 0; Elan 4.2.1, no toolchain yet |
| first Lean toolchain request before explicit approval | not executed; approval gate rejected it |
| `/Users/danielcabezas/.elan/bin/elan toolchain install leanprover/lean4:v4.30.0` | installation completed; the retry/waiting invocation exited 0 |
| `/Users/danielcabezas/.elan/bin/elan toolchain list && .../lean --version && .../lake --version` | 1 before Elan settings existed |
| direct installed-toolchain `lean --version` and `lake --version` | 0 |
| `/Users/danielcabezas/.elan/bin/elan default leanprover/lean4:v4.30.0` | 0 |
| `/Users/danielcabezas/.elan/bin/lake update` | 0; mathlib and dependencies resolved, cache downloaded |
| `/Users/danielcabezas/.elan/bin/lake exe cache get` | 0; no missing files |
| `lake --version && lean --version && lake build` | 127; shell PATH had not refreshed |
| absolute-path Lean/Lake version check and baseline `lake build` | 0; 8,476 jobs |

## API reconnaissance

All source searches used `rg`/`sed` against the pinned `.lake/packages/mathlib`
tree and exited 0. They covered:

- factorial factorization and `padicValNat` APIs;
- divisibility via `Nat.factorization`;
- finite lcm and `Nat.lcmUpto` APIs;
- natural-number division, logarithm, finite-cardinality, and product APIs.

Temporary `Scratch.lean` `#check` runs intentionally returned exit 1 while
probing nonexistent candidate names such as `Nat.div_eq_iff_lt_le`; the
successful API names used in the final development were verified in the same
runs. `Scratch.lean` was removed.

## Incremental proof builds

The exact command was
`/Users/danielcabezas/.elan/bin/lake build A211420`.

| Stage | Exit |
|---|---:|
| Initial residue/support implementation | 1 |
| Repaired quotient decomposition and support proof | 0 |
| First Legendre identity parse | 1 |
| Repaired sum syntax; factorial rewrite mismatch | 1 |
| Repaired factorial product rewrites; integrality compiled | 0 |
| Generalized common exponent bound | 0 |
| First power-count/double-sum implementation | 1 |
| Repaired explicit double-count coercions | 0 |
| First final valuation assembly | 1 |
| Unified the definitional exponent bound | 0 |

Additional read-only `nl`, `sed`, `rg`, and `#check` commands used to localize
these errors exited 0.

## Final verification and reporting

| Command | Exit/status |
|---|---:|
| `./scripts/verify.sh` | 0 |
| temporary negative-control Lean file containing `sorry`, followed by `./scripts/verify.sh` | 1 as required; verifier identified the exact file and token, then the probe was removed |
| `./scripts/verify.sh && /Users/danielcabezas/.elan/bin/lake env lean Audit.lean` | 0; exact signatures and standard axiom dependencies printed; temporary file removed |
| Lean/Lake version, mathlib commit/tag, and SHA-256 query | 0 |
| TeX-engine availability loop over `latexmk pdflatex xelatex lualatex tectonic` | 0; no engine found |
| `git status --short; git diff --check; wc -l A211420.lean; rg ...` | 0 |
| prior-art bibliography extraction from supplied files | 0 |
| `source /Users/danielcabezas/.elan/env && lake build` | 0; clean final build, 8,476 jobs |
| final `./scripts/verify.sh` after removal of the negative-control probe | 0 |
| `git diff --check` and `sh -n scripts/verify.sh` | 0 |
| final SHA-256, line-count, theorem-location, and temporary-file inventory commands | 0; no temporary audit or probe file remained |

The final clean verification command is rerun after all report and TeX edits;
its terminal status is recorded in `FORMALIZATION_REPORT.md` and the final
task response.

## Repository publication preparation

| Command | Exit/status |
|---|---:|
| `/Users/danielcabezas/.elan/bin/lake build` after conversion from `lakefile.toml` to `lakefile.lean` | 0 |
| `./scripts/verify.sh` after the Lake configuration conversion | 0; 8,476 jobs and source-integrity gate passed |
| `/Users/danielcabezas/.elan/bin/lake update` in the restricted network sandbox | 1; DNS access blocked |
| the same pinned `lake update` with approved network access | 0; toolchain unchanged and mathlib cache current |
| final `./scripts/verify.sh` before the corrected configuration was pushed | 0; 8,476 jobs and source-integrity gate passed |
| SHA-256 queries for Lean source, verifier, manifest, TeX, and PDF | 0 |
| removal of exact temporary PDF-rendering intermediates under `tmp/pdfs/` | 0 |
| Ruby YAML parse using an unsupported Ruby 2.6 `aliases:` keyword | 1; validator invocation incompatibility, not a workflow error |
| Ruby 2.6-compatible YAML parse of `.github/workflows/lean.yml` | 0 |
| first minimal-import build using the nonexistent `Mathlib.Tactic.Omega` module | 1; corrected to Lean's actual `Lean.Elab.Tactic.Omega` module |
| `/Users/danielcabezas/.elan/bin/lake build A211420` with exact theorem/tactic imports | 0; 2,721 jobs |
| final `./scripts/verify.sh` with exact imports | 0; 2,721 jobs and source-integrity gate passed |
| Ruby YAML parse of the revised `leanchecker` workflow | 0 |
| `./scripts/verify.sh` after replacing the incompatible `nanoda` gate with bundled `leanchecker` | 0; 2,721 jobs and source-integrity gate passed |
| SHA-256 queries for the revised README, report, and Lean workflow | 0 |

GitHub repository creation, file uploads, commits, and workflow inspection were
performed through authenticated GitHub and browser APIs rather than shell
commands. PDF workflow run `29839378058` succeeded. Lean workflow run
`29841907020` built all 2,721 jobs successfully but failed when `nanoda` 0.3.2
reported `invalid digit found in string` while parsing the Lean 4.30 export;
this compatibility result is recorded in `FORMALIZATION_REPORT.md`. Their
commit and workflow identifiers are also preserved in the repository history.
