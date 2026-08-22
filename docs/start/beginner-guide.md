# Beginner guide

## 1. What StringKit-FP is

`TStringKit` is a collection of static functions for everyday text work: cleaning input, splitting strings, converting identifier case, validating common formats, encoding data, approximate comparison, and simple text analysis. It uses Free Pascal RTL/FCL components only.

Start with the static API. The optional string helper is a second spelling of most string-first calls, not a different implementation.

## 2. Add StringKit-FP to a project

For an FPC project, put `src/` on the unit search path and add `StringKit` to `uses`.

```text
fpc -Fupath/to/stringkit-fp/src your_program.pas
```

In Lazarus, open `packages/lazarus/stringkit_fp.lpk`, compile it, then choose **Use → Add to Project**. Alternatively add the repository’s `src/` directory under **Project Options → Compiler Options → Paths → Other Unit Files**.

## 3. Make the first call

The [first call program](../../examples/documentation/00_first_stringkit_call.pas) converts an identifier and prints:

```text
hello_world
```

## 4. Choose static or helper style

The static style is explicit and works with only `StringKit`:

```pascal
Clean := TStringKit.Trim(Input);
```

Add `StringKitHelper` when you prefer a pipeline-like spelling:

```pascal
Clean := Input.Trim;
```

Both calls use the same library logic. Read [Static API vs helper API](../guides/static-vs-helper.md) before enabling selective helper feature flags.

## 5. Clean and transform text

Use `Trim` for surrounding whitespace and `CollapseWhitespace` for runs inside text. The compiled [normalise input program](../../examples/documentation/01_normalize_input.pas) prints `Ada Lovelace`. Use `ToLower`, `ToUpper`, or `ToTitleCase` for display-oriented changes. For code-like names, use the identifier converters described in [Case conversion](../guides/case-conversion.md).

## 6. Split and join

`Split` returns `TStringDynArray`, declared in the `Types` unit. The compiled [split and join program](../../examples/documentation/03_split_and_join.pas) shows the full `uses` list and prints a three-item join. This is useful for simple delimited text, not quoted CSV fields.

## 7. Convert identifier case

Use `ToCamelCase`, `ToPascalCase`, `ToSnakeCase`, or `ToKebabCase` when converting a name such as `HelloWorld` or `snake_case`. Start with the [identifier case program](../../examples/documentation/02_identifier_cases.pas), then see the [case conversion guide](../guides/case-conversion.md) for acronyms and digits.

## 8. Validate common input

`IsValidEmail`, `IsValidURL`, `IsValidIPv4`, `IsValidIPv6`, and `IsValidDate` are practical syntax checks. They do not prove that an address exists, a URL is reachable, or input meets every RFC edge case. See [Validation](../guides/validation.md).

## 9. Encode text for the right context

Use `HTMLEncode` before inserting text into HTML. Use `PercentEncode` for URI components and `FormURLEncode` for HTML form data. `URLEncode` is intentionally a legacy-compatible form alias. The [encoding guide](../guides/encoding.md) explains the difference.

## 10. Prefer safe parsing for external input

When malformed data is normal, prefer `TryHexDecode`, `TryDecode64`, and `TryFromRoman`. They return `False` and clear the `out` value on malformed input. See [Parsing and Try APIs](../guides/parsing-and-try-apis.md).

## 11. Compare similar text

`IsFuzzyMatch` can compare close spellings such as `colour` and `color`. Its typed `TFuzzyMethod` selector makes the chosen algorithm explicit. See [Fuzzy matching](../guides/fuzzy-matching.md).

## 12. Analyse readability and text

`CountWords`, `FleschReadingEase`, `FleschKincaidGradeLevel`, and `GenerateNGrams` provide lightweight text analysis. The English readability calculations use heuristic syllable counts; they are useful signals, not editorial verdicts. See [Text analysis](../guides/text-analysis.md).

## 13. Where to go next

Choose a complete task from [Recipes](recipes.md), keep the [Cheat Sheet](cheat-sheet.md) as a reminder, and consult [Contracts and limitations](../reference/contracts-and-limitations.md) whenever input format or indexing matters.
