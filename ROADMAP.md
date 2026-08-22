# StringKit-FP Roadmap

This roadmap describes direction rather than dates. Compatibility and beginner-friendly static APIs remain important release criteria.

## Completed in v1.9.2

- Redesigned the versioned documentation experience with a structured sidebar, responsive reading shell, light/dark themes, search, code-copy controls, and stronger built-site validation.
- Preserved the beginner-first documentation path, offline archive support, and the v1.9.1 historical release site.

## Completed in v1.9.1

- Added progressive beginner documentation, executable task recipes, and concise API/contract guides.
- Added a lightweight versioned documentation site builder, offline archive output, and GitHub Pages publishing workflow.
- Kept the existing public API intact while making static/helper choices and feature flags easier to discover.

## Completed in v1.9.0

- Identifier-aware ASCII case conversion and typed fuzzy method selection.
- Explicit Try parsing/decoding contracts and percent versus form URL encoding.
- Correct readability API names, stronger behavioural testing, cleaner compiler output, and measured helper coverage.

## Next / v1.x maintenance

- Maintain backward compatibility, correct verified edge cases, and improve tests, examples, and documentation.
- Improve practical validator behaviour without claiming full RFC compliance.
- Keep byte-oriented APIs explicit and avoid introducing third-party dependencies without a clear need.

## v2.0 Modular Core

- Modularise real implementations while preserving a simple `TStringKit` facade for beginners.
- Introduce canonical names such as `Reverse`, `Capitalize`, and `JoinWith`, retaining compatibility aliases where practical.
- Reduce actual implementation dependencies through feature groups, not only helper surface selection.

## Post-v2 Unicode / UTF-8

- Make byte operations, UTF-8 code-point operations, and grapheme-cluster operations explicit and distinct.
- Do not present byte-oriented case conversion, indexing, or encoding as Unicode-aware text processing.

## Performance programme

- Measure hot paths before optimising and retain deterministic behavioural tests.
- Prefer linear or bounded-memory implementations where they improve proven workloads without obscuring the code.

## Packaging / ecosystem

- Keep Free Pascal/Lazarus package support healthy across supported platforms.
- Improve package-manager and documentation integration while retaining the lightweight RTL/FCL dependency model.
