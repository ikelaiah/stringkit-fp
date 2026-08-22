# Beginner recipes

Every Pascal program below is compiled with FPC 3.2.2 and run against its stated output by `tools/test_docs_examples.py`.

## Trim and normalise user input

**Problem:** Turn accidental surrounding and repeated whitespace into one readable value.

**Recommended API:** `Trim` and `CollapseWhitespace`.

```pascal
program NormalizeInput;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.CollapseWhitespace(TStringKit.Trim('  Ada   Lovelace  ')));
end.
```

**Expected output:** `Ada Lovelace`

**Caveat:** This handles the library’s ordinary byte whitespace characters; it is not Unicode whitespace normalisation. [Source program](../../examples/documentation/01_normalize_input.pas).

## Convert HelloWorld to hello_world

**Problem:** Change a code identifier to snake case.

**Recommended API:** `ToSnakeCase`.

```pascal
program IdentifierCases;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.ToSnakeCase('HelloWorld'));
  Writeln(TStringKit.ToPascalCase('snake_case'));
end.
```

**Expected output:**

```text
hello_world
SnakeCase
```

**Caveat:** Identifier tokenisation is ASCII/byte-oriented. [Source program](../../examples/documentation/02_identifier_cases.pas).

## Convert snake_case to PascalCase

**Problem:** Create a Pascal type or class-like name from a snake-case name.

**Recommended API:** `ToPascalCase`.

```pascal
program IdentifierCases;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.ToSnakeCase('HelloWorld'));
  Writeln(TStringKit.ToPascalCase('snake_case'));
end.
```

**Expected output:**

```text
hello_world
SnakeCase
```

**Caveat:** The same program demonstrates both identifier conversions. [Source program](../../examples/documentation/02_identifier_cases.pas).

## Split a simple delimited string and join strings

**Problem:** Handle a short, unquoted delimiter-separated value.

**Recommended API:** `Split` and `Join`.

```pascal
program SplitAndJoin;

{$mode objfpc}{$H+}

uses
  Types,
  StringKit;

var
  Parts: TStringDynArray;
begin
  Parts := TStringKit.Split('red,green,blue', ',');
  Writeln(Length(Parts));
  Writeln(TStringKit.Join(Parts, ' | '));
end.
```

**Expected output:**

```text
3
red | green | blue
```

**Caveat:** `Split` is for simple delimiters, not a full CSV parser with quoted fields. `TStringDynArray` is declared by `Types`. [Source program](../../examples/documentation/03_split_and_join.pas).

## Validate an email

**Problem:** Reject clearly malformed email-shaped input before continuing.

**Recommended API:** `IsValidEmail`.

```pascal
program ValidateEmail;

{$mode objfpc}{$H+}

uses
  SysUtils,
  StringKit;

begin
  Writeln(BoolToStr(TStringKit.IsValidEmail('ada@example.com'), True));
end.
```

**Expected output:** `True`

**Caveat:** This is a practical syntax check, not confirmation that a mailbox exists or full RFC validation. [Source program](../../examples/documentation/04_validate_email.pas).

## Validate IPv4 and IPv6

**Problem:** Check which common IP literals are syntactically valid.

**Recommended API:** `IsValidIPv4` and `IsValidIPv6`.

```pascal
program ValidateIp;

{$mode objfpc}{$H+}

uses
  SysUtils,
  StringKit;

begin
  Writeln(BoolToStr(TStringKit.IsValidIPv4('192.168.0.1'), True));
  Writeln(BoolToStr(TStringKit.IsValidIPv6('2001:db8::1'), True));
end.
```

**Expected output:**

```text
True
True
```

**Caveat:** Validation does not establish network reachability. [Source program](../../examples/documentation/05_validate_ip.pas).

## Encode HTML

**Problem:** Render text safely as text inside an HTML context.

**Recommended API:** `HTMLEncode`.

```pascal
program HtmlEncode;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.HTMLEncode('<b>Hello</b>'));
end.
```

**Expected output:** `&lt;b&gt;Hello&lt;/b&gt;`

**Caveat:** This encodes the five essential HTML characters. Contexts such as JavaScript and CSS need their own safe handling. [Source program](../../examples/documentation/06_html_encode.pas).

## Form URL encoding and percent encoding

**Problem:** Encode text for a URI component or an HTML form body.

**Recommended API:** `PercentEncode` or `FormURLEncode`.

```pascal
program UrlEncoding;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.PercentEncode('a b+c'));
  Writeln(TStringKit.FormURLEncode('a b+c'));
end.
```

**Expected output:**

```text
a%20b%2Bc
a+b%2Bc
```

**Caveat:** Spaces differ: percent encoding uses `%20`, while form encoding uses `+`. [Source program](../../examples/documentation/07_url_encoding.pas).

## Decode hex safely

**Problem:** Decode external hexadecimal without accepting malformed pairs.

**Recommended API:** `TryHexDecode`.

```pascal
program TryHexDecode;

{$mode objfpc}{$H+}

uses
  StringKit;

var
  Decoded: string;
begin
  if TStringKit.TryHexDecode('48656C6C6F', Decoded) then
    Writeln(Decoded);
end.
```

**Expected output:** `Hello`

**Caveat:** On malformed input the function returns `False` and clears `Decoded`. [Source program](../../examples/documentation/08_try_hex_decode.pas).

## Decode Base64 safely

**Problem:** Decode expected Base64 while handling malformed input explicitly.

**Recommended API:** `TryDecode64`.

```pascal
program TryBase64Decode;

{$mode objfpc}{$H+}

uses
  StringKit;

var
  Decoded: string;
begin
  if TStringKit.TryDecode64('SGVsbG8=', Decoded) then
    Writeln(Decoded);
end.
```

**Expected output:** `Hello`

**Caveat:** `TryDecode64` accepts whitespace in valid Base64 text; malformed input returns `False` and clears `Decoded`. [Source program](../../examples/documentation/09_try_base64_decode.pas).

## Convert Roman numerals safely

**Problem:** Accept only canonical Roman numerals in the supported range.

**Recommended API:** `TryFromRoman`.

```pascal
program TryRoman;

{$mode objfpc}{$H+}

uses
  StringKit;

var
  Value: Integer;
begin
  if TStringKit.TryFromRoman('MMXXVI', Value) then
    Writeln(Value);
end.
```

**Expected output:** `2026`

**Caveat:** The strict parser accepts canonical values from 1 through 3999 and clears `Value` when it returns `False`. [Source program](../../examples/documentation/10_try_roman.pas).

## Compare two strings approximately

**Problem:** Treat close spellings as a match.

**Recommended API:** `IsFuzzyMatch` with `TFuzzyMethod`.

```pascal
program FuzzyMatch;

{$mode objfpc}{$H+}

uses
  SysUtils,
  StringKit;

begin
  Writeln(BoolToStr(
    TStringKit.IsFuzzyMatch('colour', 'color', 0.75, fmLevenshtein), True));
end.
```

**Expected output:** `True`

**Caveat:** A threshold is a product decision; test it with your real data. [Source program](../../examples/documentation/11_fuzzy_match.pas).

## Calculate readability

**Problem:** Get a quick English readability score for a short passage.

**Recommended API:** `FleschReadingEase`.

```pascal
program Readability;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.FleschReadingEase('The cat sat on the mat.'):0:2);
end.
```

**Expected output:** `100.00`

**Caveat:** Syllables are estimated heuristically for English text. [Source program](../../examples/documentation/12_readability.pas).

## Extract text with a regular expression

**Problem:** Find each matching fragment in a string.

**Recommended API:** `ExtractAllMatches`.

```pascal
program RegexExtract;

{$mode objfpc}{$H+}

uses
  Types,
  StringKit;

var
  Matches: TStringDynArray;
  Index: Integer;
begin
  Matches := TStringKit.ExtractAllMatches('Order #42, then #7', '#\d+');
  for Index := 0 to High(Matches) do
    Writeln(Matches[Index]);
end.
```

**Expected output:**

```text
#42
#7
```

**Caveat:** Patterns use Free Pascal’s `RegExpr` syntax. [Source program](../../examples/documentation/13_regex_extract.pas).
