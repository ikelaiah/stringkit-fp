# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.9.0] - 2026-08-22

### Added

- Identifier-aware ASCII case conversion for camel, Pascal, snake, and kebab case, including common acronym and digit boundaries.
- `TFuzzyMethod` and a type-safe `IsFuzzyMatch` overload.
- Strict non-throwing `TryHexDecode`, `TryDecode64`, and `TryFromRoman` APIs with predictable cleared output on failure.
- Explicit `PercentEncode`/`PercentDecode` and `FormURLEncode`/`FormURLDecode` APIs.
- `FleschReadingEase` and `FleschKincaidGradeLevel` while retaining `FleschKincaidReadability`.

### Changed

- Expanded practical URL validation to accept uppercase and modern-length TLDs.
- Kept legacy `URLEncode`/`URLDecode` as form-style aliases and retained permissive `HexDecode` and `FromRoman` behavior.

### Fixed

- Prevented `Split` from looping on an empty delimiter.
- Removed StringKit-owned FPC 3.2.2 warnings and notes.

### Testing

- Added deterministic API, helper-delegation, byte round-trip, identifier idempotence, and canonical Roman 1..3999 property coverage.

### Documentation

- Documented byte/ASCII limits, 1-based indexing, practical validator scope, Try API contracts, explicit URL semantics, and readability naming.
- Added a permanent v1.x/v2 roadmap and refreshed helper coverage measurement.

### Migration

- No intentional breaking changes. Prefer `TFuzzyMethod`, `Try...` methods, explicit percent/form URL methods, and `FleschReadingEase` in new code.


## [2.0.0] - Unreleased

### API evolution (planned)

- Rename selected `TStringKit` members to align with helper naming:
  - `ReverseText` → `Reverse`
  - `CapitalizeText` → `Capitalize`
  - `Join` → `JoinWith`

Notes:
- 2.0.0 should introduce these as canonical names while retaining deprecated compatibility aliases where technically practical.
- Any eventual removal of a compatibility alias should be considered separately in a later major release.

---

## [1.8.1] - 2026-08-22

### Fixed

- Made `LevenshteinSimilarity('', '')` and `LCSSimilarity('', '')` return `1.0` without division by zero; one-empty comparisons return `0.0`.
- Kept `CountSubString` non-overlapping, including overlapping-looking inputs such as `CountSubString('aaaaa', 'aa') = 2`.
- Preserved leading, consecutive, and trailing empty `Split` entries when `RemoveEmptyEntries` is `False`.
- Bounded `Truncate` results to `MaxLength`, including non-positive limits and ellipses longer than the limit.
- Added thousands separators to negative `FormatNumber` values.

### Testing

- Added FPCUnit regression assertions for the corrected boundaries, similarity invariants, symmetry, and helper delegation.

### CI

- Added GitHub Actions coverage for FPC 3.2.2 on Ubuntu and Windows, including tests, examples, the full helper, representative modular-helper configurations, and the Lazarus package.

### Documentation

- Corrected the public operation count, dependency description, helper alias coverage, Unicode limitations, readability metric description, and the v2 compatibility direction.
- Clarified that any future hashing work must distinguish data hashes, cryptographic hashes, and password hashing; password storage must use established algorithms and libraries.

### Maintenance

- Removed stale backup and generated artefacts, and ignored `*.backup` files.

---

## [1.8.0] - 2025-11-29

### Changed

- **Code Quality**: Standardized Pascal comment style across all source files:
  - Use `//` for short comments (1–3 lines)
  - Use `(* *)` for longer documentation blocks
  - Reserve `{ }` for compiler directives only
- **Bug Fixes**: Fixed regex quantifier syntax errors throughout codebase:
  - Corrected invalid `(*n,m*)` syntax to standard `{n,m}` in `IsValidURL`, `IsValidIPv4`, `IsValidIPv6`, `IsValidEmail`, and `HexDecode`
  - Fixed comment parsing issue with `*)` sequences in documentation blocks by restructuring pattern descriptions
- **Documentation**: Enhanced beginner experience:
  - Added "Project Philosophy" section to CONTRIBUTING.md explaining beginner-friendly design and IDE support rationale
  - Added "Working Examples" section to README.md with ready-to-run example programs (StringKitExample, CaseAndEncodeDemo, EncodeOnlyDemo)
  - Added "Common Beginner Questions" section to README.md addressing top usage questions
  - Updated version badge in README.md to 1.8.0
  - Updated Lazarus package version to 1.8.0 in `packages/lazarus/stringkit_fp.lpk`

### Notes

- All 144 tests passing (72 TStringTests + 72 TStringHelperTests)
- No breaking changes or functionality modifications
- Focus on code quality, correctness, and documentation improvements


---

## Release [1.7.0] - 2025-08-19

### Changed

- Migrated to built-in RTL types for arrays of strings:
  - Replaced custom `TMatchStrings` with `Types.TStringDynArray` across the public API, helpers, tests, and documentation.
  - Helper method signatures updated accordingly, e.g., `JoinWith(const Strings: TStringDynArray)`.
- Documentation updated (README and Cheat Sheet) to reflect the new types and signatures.

### Migration Notes

- If you referenced `TMatchStrings`, switch to `Types.TStringDynArray`.
- Ensure `Types` is in your unit's `uses` clause when working with `TStringDynArray`.
- Instance-style `JoinWith` remains the recommended usage: `', '.JoinWith(Arr)`.

### Fixed

- Minor consistency fixes in examples and comments related to split/join and n-grams.

---

## Release [1.6.0] - 2025-08-16

### Added

- Modularized the `TStringHelperEx` type helper using conditional include files (`.intf.inc` / `.impl.inc`) grouped by feature. This enables selective compilation of helper methods while preserving the existing API when all features are enabled.
- Feature flags for selective builds:
  - `SK_ALL` — enable all helper features (default when no flags provided)
  - `SK_ANY` — opt into selective mode, then enable one or more of:
    - `SK_MANIP`, `SK_MATCH`, `SK_COMPARE`, `SK_CASE`, `SK_VALIDATE`, `SK_FORMAT`, `SK_NUMERIC`, `SK_ENCODE`, `SK_SPLIT`, `SK_PHONETIC`
- Documentation: README section “Modular Helper via Feature Flags (1.6.0+)” with examples for FPC/Lazarus conditional defines.

### Changed

- No breaking changes. Existing APIs remain compatible when `SK_ALL` (default) is active.
- Internal tooling: added `tools/count_tstringkit_public.ps1` to generate coverage between `TStringKit` and the helper. See `tools/count_tstringkit_public.README.md`.
 - Internal organization of `src/StringKitHelper.pas` to include feature groups from `src/inc/` via `{$I ...}` includes, improving maintainability and build-time flexibility.
 - Version badge in `README.md` updated to 1.6.0.

### Fixed

- Minor documentation and formatting improvements across README and docs.
 - No functional changes; refactor validated by the full test suite (144 tests) passing with all features enabled (`SK_ALL`).

---

## Release [1.5.0] - 2025-08-15

### Added

- Exposed existing `TStringKit` functionality as string type helpers in `TStringHelperEx` (e.g., `Soundex`, `Metaphone`, `CountWords`, formatting, case conversions, splitting/joining, etc.) for instance-style usage like `'text'.Soundex`.
- Added comprehensive unit tests for Roman numeral conversion (`FromRoman`, `ToRoman`), including boundary and invalid cases.
- Added Base64 encoding/decoding (`Encode64`, `Decode64`) to both `TStringKit` and `TStringHelperEx`.

### Changed

- Renamed delimiter-centric helper method `Join(const Strings: TMatchStrings)` to `JoinWith(const Strings: TMatchStrings)` in `TStringHelperEx` for clarity. Usage example: `', '.JoinWith(Arr)`.
- Updated tests and examples to prefer the delimiter-first, instance-style `JoinWith` over array-first calls.

### Fixed

- Soundex implementation aligned with standard rules (handle H/W non-reset and first-letter code), fixing cases like `"Ashcraft" -> A261` and `"Tymczak" -> T522`.
- Metaphone implementation adjusted for initial `WR` (silent W), `CK` collapsing, and soft `C` duplicate suppression, fixing cases like `"wrack" -> RK` and `"science" -> SNS`.
- Tests updated to reflect correct behavior where punctuation splits words (e.g., `CountWords` on `'This is a test.'` expects 4).
- Base64 decoding strictness: `TStringKit.Decode64` now validates padding strictly (length % 4, '=' only at the end, 1–2 '='), returning an empty string on invalid input. This resolves previously failing Base64 decode tests.

## Release [1.0.0] - 2025-08-12

### Changed

- Separated from TidyKit-FP as a separate library for ease of maintenance.
- Updated documentation to reflect this change.

