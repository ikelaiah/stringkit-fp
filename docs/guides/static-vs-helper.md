# Static API vs helper API

StringKit-FP has two ways to call most operations. Pick the one that makes the surrounding code clearer; they are alternatives, not two implementations.

## Static API

Add `StringKit` and call a class function:

```pascal
Clean := TStringKit.Trim(' hello ');
```

Static calls make the owning library obvious. They are also the only natural form for operations whose main input is not a source string, such as `TStringKit.ToRoman(2026)`.

## Helper API

Add both `StringKit` and `StringKitHelper`:

```pascal
Clean := ' hello '.Trim;
```

The helper is useful for left-to-right reading and chaining:

```pascal
Clean := '  HELLO   WORLD  '.Trim.CollapseWhitespace.ToLower;
```

## Feature flags

With no helper symbols, StringKit-FP defines `SK_ALL`, so every helper group is available. To build only selected groups, define `SK_ANY` at the project/compiler level and add the groups you need, for example `-dSK_ANY -dSK_ENCODE`.

| Group | Helper area |
|---|---|
| `SK_MANIP` | trim, padding, whitespace, substring |
| `SK_MATCH` | regex, replacement, contains, words |
| `SK_COMPARE` | distance, similarity, fuzzy matching |
| `SK_CASE` | title, camel, Pascal, snake, kebab case |
| `SK_VALIDATE` | email, URL, IP, date |
| `SK_FORMAT` | truncation and number/file-size formatting |
| `SK_NUMERIC` | Roman numerals, ordinals, number words |
| `SK_ENCODE` | HTML, URL, Base64, hex |
| `SK_SPLIT` | split and join |
| `SK_PHONETIC` | Soundex, Metaphone, readability, n-grams |

Defines inside a program do not change a separately compiled `StringKitHelper` unit. Set them in Lazarus project options or the FPC command line. The [helper feature-flags reference](../reference/helper-feature-flags.md) and [coverage table](../reference/helper-coverage.md) have the complete details.
