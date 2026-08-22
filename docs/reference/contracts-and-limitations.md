# Contracts and limitations

StringKit-FP deliberately preserves a stable, practical API. The following details matter when processing external or non-ASCII data.

| Area | Contract |
|---|---|
| `SubString` | `StartPos` follows Pascal `Copy` convention and is 1-based. |
| Text classification | casing, word tokenisation, URL, hex, and related APIs are largely byte/ASCII-oriented, not Unicode grapheme-aware. |
| Identifier case | separators, lower-to-upper changes, acronym boundaries, and digits are handled by the ASCII tokenizer. |
| Validators | email, URL, IP, and date methods are pragmatic syntax checks, not complete RFC validators or reachability checks. |
| Percent encoding | `PercentEncode` uses `%20` for spaces and `PercentDecode` preserves literal `+`. |
| Form encoding | `FormURLEncode` uses `+` for spaces; legacy `URLEncode` and `URLDecode` retain the same form semantics. |
| Safe parsing | `TryHexDecode`, `TryDecode64`, and `TryFromRoman` return `False` and clear their `out` value on malformed input. |
| Readability | English readability formulas use heuristic syllable counts. |

These are contracts, not shortcomings hidden by the documentation: make a Unicode-aware or standards-complete validation decision explicitly when your application requires it.
