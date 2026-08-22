# TStringKit Helper Coverage Script

This README documents how to use the PowerShell script `tools/count_tstringkit_public.ps1` to generate a coverage report between the public methods of `TStringKit` and the String Helper functions.

## What it does
- Scans `src/StringKit.pas` for all public `class function/procedure` names of `TStringKit`.
- Scans `src/inc/*.intf.inc` for helper function names.
- Produces a coverage matrix showing which `TStringKit` methods are available (same name or alias) in the helper.

## Outputs
Written into `tools/`:
- `summary.txt` — high-level counts (public total, helper total, covered/missing)
- `coverage.md` — a Markdown table of all public methods and whether the helper has them
- `coverage.json` — machine-readable version of the same data

## Requirements
- Windows PowerShell 5.x or PowerShell 7+
- No external modules required

## How to run
From the repo root (recommended):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\count_tstringkit_public.ps1
```

Or from the `tools/` directory:

```powershell
.\count_tstringkit_public.ps1
```

The script resolves paths relative to its own location, so either approach works.

## Interpreting the results
- `TStringKit public count`: Number of public `class function/procedure` members declared in `TStringKit`.
- `Helper method count`: Unique function names found across `src/inc/*.intf.inc`.
- `Covered`: Number of `TStringKit` methods available through the helper, including the documented aliases.
- `Missing`: Public methods without a same-named helper function.

The `coverage.md` table columns:
- `Method` — the public `TStringKit` method name
- `In Helper` — `Yes` if present in the helper under the same name or a documented alias, `No` otherwise

## Notes & troubleshooting
- If you run the script line-by-line in a console/ISE, `$MyInvocation.MyCommand.Path` may be unset. Prefer running the script file as shown above.
- If you see a path resolution error, ensure your workspace layout matches:
  - `src/StringKit.pas`
  - `src/inc/*.intf.inc`
- The script recognises the documented aliases `ReverseText` → `Reverse`, `CapitalizeText` → `Capitalize`, and `Join` → `JoinWith`.

## How it works (brief)
1. Reads `src/StringKit.pas` and slices the interface section (before the `implementation` keyword).
2. Finds the `TStringKit = class` block, then captures names of public `class function|procedure` members via regex.
3. Reads all `*.intf.inc` files, extracts helper function names via regex.
4. Compares sets and writes results.

## Updating or extending
- To add another documented alias, extend the `$aliasMap` inside the script, e.g.:

```powershell
$aliasMap = @{ ReverseText = 'Reverse'; CapitalizeText = 'Capitalize'; Join = 'JoinWith' }
$tkNorm = $tkNames | ForEach-Object { if ($aliasMap.ContainsKey($_)) { $aliasMap[$_] } else { $_ } }
```

- To filter by category (e.g., `Manip`, `Match`), you could parse the `*.intf.inc` filenames to derive a category column when writing `coverage.md`.

## Contact
If you have questions or want to automate this in CI, consider adding a GitHub Action that runs the script and uploads the artifacts.
