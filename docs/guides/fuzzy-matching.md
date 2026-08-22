# Fuzzy matching

Use fuzzy matching when two strings may be nearly, rather than exactly, the same. `IsFuzzyMatch` compares a similarity score with a threshold between 0 and 1.

The typed overload makes the selected algorithm visible:

```pascal
Matched := TStringKit.IsFuzzyMatch(
  'colour', 'color', 0.75, fmLevenshtein);
```

| Method | Best starting point |
|---|---|
| `fmLevenshtein` | general spelling edits and insertions/deletions |
| `fmJaroWinkler` | short names where a common prefix matters |
| `fmLCS` | shared ordered subsequences |

The legacy integer selector remains compatible (`0` Levenshtein, `1` Jaro-Winkler, `2` LCS), but the `TFuzzyMethod` form is clearer in new code. The [fuzzy match recipe](../start/recipes.md#compare-two-strings-approximately) is compiled with `fmLevenshtein` and a `0.75` threshold.

There is no universal right threshold. Collect representative matches and non-matches from your domain, then choose and test the threshold that gives the trade-off you need.
