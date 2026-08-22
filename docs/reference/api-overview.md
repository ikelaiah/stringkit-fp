# API overview

`TStringKit` exposes 80 public operations. The project groups them by the task they solve rather than requiring an object instance.

| Area | Representative operations |
|---|---|
| Manipulation | `Trim`, `CollapseWhitespace`, `SubString`, padding, replacement |
| Matching | regex matching/extraction, `Contains`, `GetWords` |
| Comparison | Levenshtein, Jaro, Jaro-Winkler, LCS, fuzzy matching |
| Case | title, camel, Pascal, snake, kebab conversion |
| Validation | email, URL, IP, date |
| Formatting | truncation, number and file-size formatting |
| Split | `Split`, `Join` |
| Phonetic and analysis | Soundex, Metaphone, readability, n-grams |
| Encoding | HTML, percent/form URL, Base64, hex |
| Numeric | Roman numerals, ordinals, number words |

Begin with [Recipes](../start/recipes.md) for complete programs. Use the [Cheat Sheet](../start/cheat-sheet.md) when you need a compact method inventory, and the [helper coverage table](helper-coverage.md) to see the helper spelling for each operation.

Important behaviour is documented in [Contracts and limitations](contracts-and-limitations.md), especially `SubString` indexing, byte-oriented text handling, form URL semantics, and safe parsing.
