# Implementation Plan: StringKit-FP v1.8.1 Reliability Release

## Overview

Prepare a patch release that corrects confirmed edge-case defects, adds focused FPCUnit regression coverage, introduces a concise Windows/Linux GitHub Actions workflow, removes stale artefacts, and makes version and roadmap documentation accurate without changing the public API.

## Architecture Decisions

- Preserve the static and helper APIs; helper tests verify delegation while algorithmic edge cases live in `TStringKit` tests.
- Treat two empty strings as perfectly similar, and one empty string as dissimilar, for the affected normalized metrics.
- Keep `CountSubString` explicitly non-overlapping and preserve trailing fields in `Split` when empty entries are retained.
- Bound truncation output to `MaxLength`: non-positive limits return an empty string and a too-long ellipsis is shortened to fit.
- Use GitHub Actions on Ubuntu and Windows with FPC 3.2.2, covering the full helper and representative feature-flag builds.

## Task List

### Phase 1: Correctness and regression coverage

- [ ] Task 1: Add failing regression cases for similarity, count, split, truncate, and negative formatting boundaries.
- [ ] Task 2: Implement the minimal fixes in `TStringKit` and update affected API comments.
- [ ] Task 3: Add representative helper delegation assertions and run the focused/full FPCUnit suite.

### Checkpoint: Correctness

- [ ] The suite passes and all corrected results meet their documented contracts.
- [ ] Default and selected modular helper configurations compile.

### Phase 2: CI and documentation

- [ ] Task 4: Add a reliable Ubuntu/Windows FPC 3.2.2 GitHub Actions workflow including library, tests, examples, helper, and selected feature flags.
- [ ] Task 5: Remove confirmed stale artefacts; update `.gitignore`, README, coverage/cheat-sheet material, package version, CHANGELOG, and roadmaps.

### Checkpoint: Release readiness

- [ ] Local tests, package, examples, and all selected configurations compile.
- [ ] Diff is scoped, version metadata is consistent, and no generated outputs are tracked.

### Phase 3: Publication

- [ ] Task 6: Commit logical changes, push `fix/v1.8.1-reliability`, and open a PR to `main`.
- [ ] Task 7: Resolve any CI failures, complete an independent code-quality review, merge only after green checks, tag `v1.8.1`, and publish the GitHub Release.

## Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Cross-platform FPC setup differs | High | Use the official `fpc` Ubuntu package and established Windows setup action; keep commands plain FPC. |
| Empty-delimiter split semantics are undefined | Medium | Do not change it unless testing proves a safety issue; document the supported non-empty delimiter contract. |
| GitHub credentials cannot publish | High | Complete all local release preparation and clearly report any required account authorization. |

## Open Questions

- None for the patch scope; remote publication depends on valid GitHub credentials and successful hosted CI.
