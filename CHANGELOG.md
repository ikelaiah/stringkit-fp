# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [2.0.0] - Unreleased

### Breaking (planned)

- Rename selected `TStringKit` members to align with helper naming:
  - `ReverseText` → `Reverse`
  - `CapitalizeText` → `Capitalize`
  - `Join` → `JoinWith`

Notes:
- These will be hard renames in 2.0.0. Migration: replace calls per the mapping above.
- Alternative considered: keep aliases in helper. We opted for simpler, consistent naming.

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

