# StringKit-FP Roadmap

This roadmap describes direction rather than dates. It is deliberately selective: StringKit-FP should be the obvious first choice for common string and text work in Free Pascal and Lazarus, not an ever-growing collection of loosely related features.

## 1. Project vision

StringKit-FP provides a practical, well-tested collection of everyday string and text utilities for Free Pascal and Lazarus. It should be easy for a new Pascal developer to discover, understand, and use, while remaining dependable enough for production code.

The primary entry point remains the static `TStringKit` facade: no object lifetime, configuration, or framework knowledge should be necessary for ordinary tasks. String helper methods may provide convenient instance-style syntax, but they must remain an equivalent view of the same behaviour rather than a separate library.

The library will continue to favour explicit contracts, strong tests, clear documentation, and a lightweight RTL/FCL-oriented dependency model. Byte- and ASCII-oriented operations are useful and legitimate, but must be described honestly; Unicode-aware text processing is a later, distinct programme.

## 2. Design principles / scope boundaries

- Keep the API beginner-friendly: names, defaults, error behaviour, examples, and documentation should make ordinary use unsurprising.
- Preserve source and behavioural compatibility throughout v1.x. New APIs, aliases, overloads, and documentation may improve the experience without silently changing established results.
- Keep `TStringKit` as the stable, simple facade. Static and helper forms must agree on results, boundary cases, and failure behaviour.
- Prefer small, dependency-light implementations using the RTL/FCL where appropriate. A third-party dependency needs a clear, durable benefit before it is considered.
- Specify behaviour rather than relying on implication: indexing, separators, empty inputs, malformed data, case sensitivity, byte limits, and validator scope belong in contracts and tests.
- Treat practical validators as syntax checks, not as full standards implementations, security policy, or network reachability checks.
- Distinguish byte/ASCII handling from UTF-8 code-point and grapheme-cluster handling in API names, documentation, and examples.
- Add operations only when their usefulness exceeds their maintenance, documentation, compatibility, and testing cost.

### Release philosophy

- **Patch releases** deliver correctness fixes, stronger tests and documentation, and compatible API additions.
- **Minor releases** deliver meaningful backward-compatible capability additions.
- **Major releases** are reserved for intentional API or architecture changes.

### Scope boundaries / Non-goals

StringKit-FP concentrates on focused string-level transformations, matching, validation, formatting, encoding, comparison, and text analysis. It is not a substitute for a structured-data, networking, security, or internationalisation stack. The detailed exclusions are recorded in [Explicit non-goals](#10-explicit-non-goals); they keep the library coherent and its dependency footprint small.

## 3. Completed releases

### v1.9.2

- Redesigned the versioned documentation experience with a structured sidebar, responsive reading shell, light/dark themes, search, code-copy controls, and stronger built-site validation.
- Preserved the beginner-first documentation path, offline archive support, and the v1.9.1 historical release site.

### v1.9.1

- Added progressive beginner documentation, executable task recipes, and concise API/contract guides.
- Added a lightweight versioned documentation site builder, offline archive output, and GitHub Pages publishing workflow.
- Kept the public API intact while making static/helper choices and feature flags easier to discover.

### v1.9.0

- Added identifier-aware ASCII case conversion and typed fuzzy method selection.
- Defined explicit `Try...` parsing/decoding contracts and separate percent versus form URL encoding.
- Improved readability API names, behavioural testing, compiler output, and measured helper coverage.

## 4. Next release: v1.9.3 — Correctness & API Hardening

v1.9.3 is a quality release, not a feature-count release. Its purpose is to make existing behaviour more trustworthy, more consistent, and easier to use correctly without introducing major new subsystems.

### Validator audit

- Audit real-world boundary cases for `IsValidEmail`, `IsValidURL`, `IsValidIPv4`, `IsValidIPv6`, `IsValidIP`, and `IsValidDate`.
- Strengthen tests for accepted and rejected email forms, URL schemes/authorities/ports/paths, IPv4 ranges, IPv6 compression and notation variants, and date-format edge cases.
- Document the practical syntax-check scope of each validator and retain the clear statement that these APIs do not provide full RFC conformance, reachability checks, or security validation.

### Behavioural contracts and regressions

- Audit `Split`/`Join`, replacement, substring, encoding/decoding, and fuzzy-comparison edge cases, including empty values, delimiters, bounds, malformed data, and threshold or metric boundaries.
- Add focused regression tests for every corrected edge case and property-style coverage where invariants are clear: round trips where promised, bounded outputs, symmetry where applicable, and stable handling of empty inputs.
- Make failure behaviour consistent across `Try...` APIs: malformed input returns `False`, does not leak a partial result, and leaves the `out` result in the documented cleared state.
- Review naming, overloads, defaults, and related API contracts for consistency. Improve documentation or add compatible aliases only where they clarify use; do not break v1.x callers.
- Verify that static and helper APIs remain behaviourally equivalent, including relevant helper feature-flag configurations.
- Keep documentation examples executable and covered by the documentation test workflow so examples continue to express the real contract.

### Explicitly out of scope for v1.9.3

- No major new subsystem, parser, framework, or dependency.
- No Unicode rearchitecture or silent expansion of byte-oriented APIs into Unicode claims.
- No breaking rename or behavioural change for established v1.x callers.

## 5. Candidate future v1.x improvements

Future v1.x work starts by identifying gaps in everyday string work before considering specialised or exotic capabilities. Candidate additions must be evaluated, not assumed: an API is added only when it has a crisp contract, a small implementation and maintenance cost, and useful tests and examples.

Potential areas to evaluate include small, commonly needed operations such as explicit case-insensitive `Contains`/prefix/suffix checks, predictable plain-text replacement variants, simple prefix/suffix removal, and clearly specified search-position helpers. Existing RTL/FCL facilities should be reused or documented instead of wrapped gratuitously.

Candidates are prioritised in this order:

1. Usefulness to ordinary Pascal developers.
2. API simplicity.
3. Predictable semantics.
4. Testability.
5. Low dependency cost.
6. Suitability for both static and helper APIs.

There is no target operation count. A proposal that mainly adds novelty, duplicates an adequate RTL/FCL facility, or requires extensive standards, locale, or dependency machinery should remain outside v1.x.

## 6. v2.0 Modular Core

v2.0 is the point for intentional internal and API evolution after v1.x compatibility commitments have been met.

- Modularise the real implementations into coherent feature groups while retaining the simple `TStringKit` facade for beginners.
- Reduce actual implementation dependencies through those feature groups, rather than limiting only the helper surface.
- Adopt clearer canonical names such as `Reverse`, `Capitalize`, and `JoinWith`; retain deprecated compatibility aliases where technically practical and document the migration path.
- Make extension, test isolation, conditional helper support, package use, and dependency boundaries easier to reason about without forcing users into a framework or object-oriented workflow.
- Publish a migration guide before any intentional v2 API change, including equivalences, deprecation status, and byte/Unicode limitations.

## 7. Post-v2 Unicode / UTF-8

Unicode work begins only after the modular core and its contracts are stable. It must be a genuine text model, not a relabelling of byte routines.

- Make byte operations, UTF-8 code-point operations, and grapheme-cluster operations explicit and distinct.
- Define indexing, length, slicing, case conversion, whitespace, matching, encoding, and invalid-input policies separately for each text model.
- Keep existing byte-oriented v1.x behaviour available where compatibility requires it, and never present it as Unicode-aware text processing.
- Evaluate locale-sensitive casing, normalisation, segmentation, and external Unicode data with the dependency, package-size, performance, and cross-platform costs stated up front.

## 8. Performance programme

- Measure representative workloads and establish reproducible baselines before optimising hot paths.
- Track both time and allocation/memory behaviour for operations that handle large inputs or produce collections.
- Prefer linear-time or bounded-memory implementations when they improve demonstrated workloads without obscuring contracts or code clarity.
- Preserve deterministic behavioural, regression, and property-style tests around every optimisation; performance changes must not alter documented edge behaviour.
- Publish benchmark assumptions and inputs so performance claims remain useful rather than anecdotal.

## 9. Packaging / ecosystem

- Keep Free Pascal and Lazarus package support healthy across the documented compiler and platform support matrix.
- Maintain straightforward unit use, package metadata, examples, and beginner-oriented installation guidance.
- Continue improving versioned documentation, executable examples, offline archives, and release validation.
- Explore package-manager and documentation integration only when it preserves the lightweight RTL/FCL dependency model and does not make the core harder to adopt.

## 10. Explicit non-goals

StringKit-FP should **not** become any of the following. These belong in separate libraries with their own contracts, dependencies, security posture, and release cadence:

- A CSV parser.
- A JSON, XML, or YAML parser.
- A template engine.
- A general-purpose parser framework.
- A database or dataframe library.
- A cryptographic library.
- An HTTP or networking library.
- A full localisation or i18n framework.

Small string-level helpers may still be considered when they are generally useful, remain tightly focused, have predictable semantics, and keep the project dependency-light. They must not become a back door for importing one of these broader responsibilities into StringKit-FP.
