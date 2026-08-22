# 📋 Cheat Sheet

## 🧵String operations

### Using helpers (instance-style)

Enable instance-style string methods by adding `StringKitHelper` to your uses.

```pascal
uses
  StringKit, StringKitHelper;

var
  S: string;
begin
  S := '  hello world  '.Trim;          // 'hello world'
  S := 'Hello World'.ToSnakeCase;       // 'hello_world'
  if 'user@example.com'.IsValidEmail then ; // True
  S := 'foo'.Encode64;                  // 'Zm9v'
  S := 'Hello World!'.PercentEncode;    // 'Hello%20World%21'
  S := '  Mixed Case  '.Trim.ToUpper;   // Chaining: 'MIXED CASE'
  if 'ABC123'.MatchesPattern('^[A-Z]{3}\d{3}$') then ; // True (regex via helper)
  // Split and Join via helpers
  // Note: Split returns TStringDynArray; JoinWith uses Self as the delimiter
  S := ','.JoinWith('a,b,,c'.Split(',', 0, True)); // 'a,b,c'
end;
```

Notes:
- Most `TStringKit` string-first methods are available via the helper for convenience.
- Chaining is supported because helpers return strings (e.g., `'text'.Trim.ToLower`).
- Use static `TStringKit` calls for operations that don't act on a source string (e.g., number conversions), or when passing non-string types.

### ⚙️ Feature flags (1.6.0+)

`TStringHelperEx` is modularized. By default all features are enabled. To slim the helper:

- Default: `SK_ALL` (applies when no symbols defined)
- Selective: define `SK_ANY` and then one or more of:
  - `SK_MANIP`, `SK_MATCH`, `SK_COMPARE`, `SK_CASE`, `SK_VALIDATE`, `SK_FORMAT`, `SK_NUMERIC`, `SK_ENCODE`, `SK_SPLIT`, `SK_PHONETIC`

See details:

- README: Modular Helper section (`README.md` → “Modular Helper via Feature Flags (1.6.0+)”)
- Changelog: [CHANGELOG 1.6.0](../../CHANGELOG.md#release-160---2025-08-16)

### Using static methods (type-first)

```pascal
// ---------- Basic String Manipulation ----------

// Trimming and Whitespace
Str := TStringKit.Trim(Text);                     // Trim whitespace from both ends
Str := TStringKit.TrimLeft(Text);                 // Trim left whitespace
Str := TStringKit.TrimRight(Text);                // Trim right whitespace

// Case Conversion
Str := TStringKit.ToLower(Text);                  // Convert to lowercase
Str := TStringKit.ToUpper(Text);                  // Convert to uppercase
Str := TStringKit.CapitalizeText(Text);           // Capitalize first letter of each word

// Advanced Case Conversion
Str := TStringKit.ToTitleCase(Text);              // Convert to Title Case
Str := TStringKit.ToCamelCase(Text);              // Convert to camelCase
Str := TStringKit.ToPascalCase(Text);             // Convert to PascalCase
Str := TStringKit.ToSnakeCase(Text);              // Convert to snake_case
Str := TStringKit.ToKebabCase(Text);              // Convert to kebab-case

// Padding and Alignment
Str := TStringKit.PadLeft(Text, Width, Char);     // Left pad with character
Str := TStringKit.PadRight(Text, Width, Char);    // Right pad with character
Str := TStringKit.PadCenter(Text, Width, Char);   // Center pad with character

// Text Transformation
Str := TStringKit.ReverseText(Text);              // Reverse text
Str := TStringKit.DuplicateText(Text, Count);     // Duplicate text
Str := TStringKit.Truncate(Text, MaxLen, '...');  // Truncate with ellipsis; result never exceeds MaxLen

// Whitespace Manipulation
Str := TStringKit.CollapseWhitespace(Text);       // Collapse multiple whitespace to single space
Str := TStringKit.RemoveWhitespace(Text);         // Remove all whitespace characters

// ---------- String Inspection ----------

// Basic Tests
if TStringKit.IsEmpty(Text) then                  // Check if empty
Length := TStringKit.GetLength(Text);             // Get string length
Count := TStringKit.CountWords(Text);             // Count words

// Content Inspection
if TStringKit.Contains(Text, SubStr) then         // Check if contains substring
if TStringKit.StartsWith(Text, Prefix) then       // Check if starts with prefix
if TStringKit.EndsWith(Text, Suffix) then         // Check if ends with suffix
Count := TStringKit.CountSubString(Text, SubStr); // Count non-overlapping occurrences of substring

// Validation
if TStringKit.IsValidEmail('user@example.com') then       // Validate email address
if TStringKit.IsValidURL('https://example.com') then      // Validate URL
if TStringKit.IsValidIP('192.168.1.1') then               // Validate IP address (v4 or v6)
if TStringKit.IsValidIPv4('192.168.1.1') then             // Validate IPv4 address
if TStringKit.IsValidIPv6('::1') then                     // Validate IPv6 address
if TStringKit.IsValidDate('2024-01-15', 'yyyy-mm-dd') then // Validate numeric date components/order

// ---------- Substring Operations ----------

// Extraction
Str := TStringKit.SubString(Text, Start, Length); // Extract substring
Str := TStringKit.LeftStr(Text, Length);          // Get left part
Str := TStringKit.RightStr(Text, Length);         // Get right part

// Splitting and Joining
Words := TStringKit.GetWords(Text);               // Split into words
Strings := TStringKit.Split('a,b,c', ',');                // Split by delimiter
Strings := TStringKit.Split('a,b,,c', ',', 0, True);      // Split and remove empty entries
Str := TStringKit.Join(['one', 'two', 'three'], ', ');    // Join with delimiter

// ---------- Pattern Matching and Replacement ----------

// Regex Operations
Matches := TStringKit.ExtractMatches(Text, Pattern);      // Extract regex matches with positions
Words := TStringKit.ExtractAllMatches(Text, Pattern);     // Extract regex matches as strings
if TStringKit.MatchesPattern(Text, Pattern) then          // Check regex pattern
Str := TStringKit.ReplaceRegEx(Text, Pattern, Replace);   // Replace using regex

// Simple Replacement
Str := TStringKit.ReplaceText(Text, Old, New);            // Replace all occurrences

// ---------- Formatting and Conversion ----------

// Number Formatting
Str := TStringKit.FormatNumber(1234);                     // Format to "1,234"
Str := TStringKit.FormatFloat(1234.56, 2, '.', ',');      // Format to "1,234.56"
Str := TStringKit.FormatFileSize(1048576);                // Format to "1.00 MB"

// Number Conversions
Roman := TStringKit.ToRoman(1984);                        // Convert to Roman numerals (MCMLXXXIV)
Num := TStringKit.FromRoman('MMXXIV');                    // Convert from Roman numerals (2024)
Ordinal := TStringKit.ToOrdinal(21);                      // Convert to ordinal (21st)
Words := TStringKit.NumberToWords(42);                    // Convert to words (forty-two)

// ---------- String Similarity and Distance ----------

// Distance Metrics
Dist := TStringKit.LevenshteinDistance(S1, S2);        // Edit distance between strings
Dist := TStringKit.HammingDistance(S1, S2);            // Character differences at same positions

// Similarity Metrics (0-1 scale, higher is more similar)
Sim := TStringKit.LevenshteinSimilarity(S1, S2);       // Normalized similarity
Sim := TStringKit.JaroSimilarity(S1, S2);              // Jaro similarity for short strings
Sim := TStringKit.JaroWinklerSimilarity(S1, S2);       // Jaro-Winkler with prefix bonus
Sim := TStringKit.LCSSimilarity(S1, S2);               // LCS similarity ratio

// Common Subsequence
LCS := TStringKit.LongestCommonSubsequence(S1, S2);    // Longest common subsequence

// Fuzzy Matching
if TStringKit.IsFuzzyMatch(S1, S2) then               // Default: Levenshtein, threshold 0.7
if TStringKit.IsFuzzyMatch(S1, S2, 0.8) then          // Custom threshold
if TStringKit.IsFuzzyMatch(S1, S2, 0.7, fmJaroWinkler) then // Preferred typed selector
if TStringKit.IsFuzzyMatch(S1, S2, 0.7, 2) then       // Legacy integer LCS selector

// ---------- Phonetic Algorithms ----------

// Phonetic Encoding
Code := TStringKit.Soundex('Smith');                   // Get Soundex code (S530)
Code := TStringKit.Metaphone('Smith');                 // Get Metaphone code (SM0)

// ---------- Text Analysis ----------

// Readability and Analysis
Score := TStringKit.FleschReadingEase(Text);           // Flesch Reading Ease (heuristic English syllables)
Grade := TStringKit.FleschKincaidGradeLevel(Text);     // Flesch-Kincaid Grade Level
NGrams := TStringKit.GenerateNGrams(Text, 2);          // Generate bigrams

// ---------- Encoding/Decoding ----------

// HTML and URL Encoding
Encoded := TStringKit.HTMLEncode('<div>');             // HTML encoding
Decoded := TStringKit.HTMLDecode('&lt;div&gt;');       // HTML decoding
Encoded := TStringKit.PercentEncode('a b');            // URI percent encoding (a%20b)
Encoded := TStringKit.FormURLEncode('a b');            // Form encoding (a+b)
Decoded := TStringKit.PercentDecode('a+b');            // Keeps '+' literal
Decoded := TStringKit.FormURLDecode('a+b');            // Decodes '+' as a space

// Base64 Encoding
Encoded := TStringKit.Encode64('foo');                  // Base64 encode (Zm9v)
Decoded := TStringKit.Decode64('Zm9v');                 // Base64 decode (foo)
Decoded := TStringKit.Decode64('Zm8=');                 // Base64 decode with padding (fo)
Decoded := TStringKit.Decode64('Zg==');                 // Base64 decode with padding (f)

// Hex Encoding
HexStr := TStringKit.HexEncode('abc');                   // Hex encoding (616263)
Original := TStringKit.HexDecode('616263');              // Hex decoding
if TStringKit.TryHexDecode('616263', Original) then ;   // Strict decoder; False clears Original
if TStringKit.TryDecode64('Zm9v', Decoded) then ;        // Strict Base64 decoder
if TStringKit.TryFromRoman('MMXXVI', Num) then ;         // Strict canonical 1..3999 Roman parser
```

Contracts: identifier casing is ASCII/byte-oriented (`XMLHttpRequest` → `xml_http_request`); digits remain in their current token and an uppercase word after digits starts a new token. `Try...` methods return `False` and clear their output for malformed external input. Legacy `URLEncode`/`URLDecode` are form-style aliases, while legacy `HexDecode` and `FromRoman` retain their permissive behavior.
