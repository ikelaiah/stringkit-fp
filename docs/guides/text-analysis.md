# Text analysis

StringKit-FP includes light-weight helpers for inspecting English-like text.

| Function | Use |
|---|---|
| `CountWords` | count words in a passage |
| `GetWords` | return words as `TStringDynArray` |
| `FleschReadingEase` | estimate reading ease; higher is generally easier |
| `FleschKincaidGradeLevel` | estimate a school-grade reading level |
| `GenerateNGrams` | create word n-grams |

The compiled [readability recipe](../start/recipes.md#calculate-readability) formats a score to two decimal places. The calculations use heuristic English syllable counts and byte-oriented word handling, so treat them as quick signals rather than a linguistic analysis.

For pattern extraction, use `ExtractAllMatches` with Free Pascal `RegExpr` syntax. The [regular-expression recipe](../start/recipes.md#extract-text-with-a-regular-expression) compiles and prints each match.
