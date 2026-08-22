# Helper feature flags

`StringKitHelper` conditionally includes helper method groups. Its default is deliberately simple:

- With no `SK_ANY` definition, `SK_ALL` is defined and all helper groups are available.
- Define `SK_ANY` to opt into selective mode.
- In selective mode, define one or more `SK_*` groups at project/build level.

```text
fpc -dSK_ANY -dSK_CASE -dSK_ENCODE -Fusrc your_program.pas
```

| Define | Includes |
|---|---|
| `SK_MANIP` | trimming, padding, whitespace, length, substrings |
| `SK_MATCH` | regex, replacement, text inspection, word extraction |
| `SK_COMPARE` | distances, similarities, fuzzy matching |
| `SK_CASE` | identifier and title conversion |
| `SK_VALIDATE` | common syntax validation |
| `SK_FORMAT` | truncation and number/file-size formatting |
| `SK_NUMERIC` | Roman, ordinal, number-to-words |
| `SK_ENCODE` | HTML, URL, Base64, hex |
| `SK_SPLIT` | splitting and joining |
| `SK_PHONETIC` | phonetics, counts, readability, n-grams |

The symbols must be visible while `StringKitHelper.pas` is compiled. A `{$DEFINE}` only inside an application source file does not recompile a separately built helper unit. See [Static API vs helper API](../guides/static-vs-helper.md) and [Helper coverage](helper-coverage.md).
