# StringKit-FP Helper Coverage

Notes:
- “Is Available in String Helper” considers exact or aliased helper names.
- 3 TStringKit methods have different helper names: ReverseText → Reverse, CapitalizeText → Capitalize, Join → JoinWith.
- Measured for v1.9.1 with `tools/count_tstringkit_public.ps1`: 80 public operations covered, 0 missing.
# Summary Table

Below is the full coverage summary with your requested columns.

| Category | Name in TStringKit | Is Available in String Helper | Name in String Helper | Category in String Helper |
|---|---|---|---|---|
| Manipulation | Trim | Yes | Trim | Manip |
| Manipulation | TrimLeft | Yes | TrimLeft | Manip |
| Manipulation | TrimRight | Yes | TrimRight | Manip |
| Manipulation | ToUpper | Yes | ToUpper | Manip |
| Manipulation | ToLower | Yes | ToLower | Manip |
| Manipulation | PadCenter | Yes | PadCenter | Manip |
| Manipulation | PadLeft | Yes | PadLeft | Manip |
| Manipulation | PadRight | Yes | PadRight | Manip |
| Manipulation | CollapseWhitespace | Yes | CollapseWhitespace | Manip |
| Manipulation | RemoveWhitespace | Yes | RemoveWhitespace | Manip |
| Manipulation | DuplicateText | Yes | DuplicateText | Manip |
| Manipulation | ReverseText | Yes | Reverse | Manip |
| Manipulation | CapitalizeText | Yes | Capitalize | Manip |
| Matching | ExtractMatches | Yes | ExtractMatches | Match |
| Matching | ExtractAllMatches | Yes | ExtractAllMatches | Match |
| Matching | MatchesPattern | Yes | MatchesPattern | Match |
| Matching | ReplaceRegEx | Yes | ReplaceRegEx | Match |
| Matching | ReplaceText | Yes | ReplaceText | Match |
| Matching | GetWords | Yes | GetWords | Match |
| Matching | CountSubString | Yes | CountSubString | Match |
| Matching | Contains | Yes | Contains | Match |
| Matching | StartsWith | Yes | StartsWith | Match |
| Matching | EndsWith | Yes | EndsWith | Match |
| Manipulation | IsEmpty | Yes | IsEmpty | Manip |
| Manipulation | GetLength | Yes | GetLength | Manip |
| Manipulation | SubString | Yes | SubString | Manip |
| Manipulation | LeftStr | Yes | LeftStr | Manip |
| Manipulation | RightStr | Yes | RightStr | Manip |
| Comparison | LevenshteinDistance | Yes | LevenshteinDistance | Compare |
| Comparison | LevenshteinSimilarity | Yes | LevenshteinSimilarity | Compare |
| Comparison | HammingDistance | Yes | HammingDistance | Compare |
| Comparison | JaroSimilarity | Yes | JaroSimilarity | Compare |
| Comparison | JaroWinklerSimilarity | Yes | JaroWinklerSimilarity | Compare |
| Comparison | LongestCommonSubsequence | Yes | LongestCommonSubsequence | Compare |
| Comparison | LCSSimilarity | Yes | LCSSimilarity | Compare |
| Comparison | IsFuzzyMatch | Yes | IsFuzzyMatch | Compare |
| Case | ToTitleCase | Yes | ToTitleCase | Case |
| Case | ToCamelCase | Yes | ToCamelCase | Case |
| Case | ToPascalCase | Yes | ToPascalCase | Case |
| Case | ToSnakeCase | Yes | ToSnakeCase | Case |
| Case | ToKebabCase | Yes | ToKebabCase | Case |
| Validation | IsValidEmail | Yes | IsValidEmail | Validate |
| Validation | IsValidURL | Yes | IsValidURL | Validate |
| Validation | IsValidIP | Yes | IsValidIP | Validate |
| Validation | IsValidIPv4 | Yes | IsValidIPv4 | Validate |
| Validation | IsValidIPv6 | Yes | IsValidIPv6 | Validate |
| Validation | IsValidDate | Yes | IsValidDate | Validate |
| Formatting | Truncate | Yes | Truncate | Format |
| Formatting | FormatFileSize | Yes | FormatFileSize | Format |
| Formatting | FormatNumber | Yes | FormatNumber | Format |
| Formatting | FormatFloat | Yes | FormatFloat | Format |
| Split | Join | Yes | JoinWith | Split |
| Split | Split | Yes | Split | Split |
| Phonetic | Soundex | Yes | Soundex | Phonetic |
| Phonetic | Metaphone | Yes | Metaphone | Phonetic |
| Phonetic | CountWords | Yes | CountWords | Phonetic |
| Phonetic | FleschReadingEase | Yes | FleschReadingEase | Phonetic |
| Phonetic | FleschKincaidReadability | Yes | FleschKincaidReadability | Phonetic |
| Phonetic | FleschKincaidGradeLevel | Yes | FleschKincaidGradeLevel | Phonetic |
| Phonetic | GenerateNGrams | Yes | GenerateNGrams | Phonetic |
| Encoding | HTMLEncode | Yes | HTMLEncode | Encode |
| Encoding | HTMLDecode | Yes | HTMLDecode | Encode |
| Encoding | URLEncode | Yes | URLEncode | Encode |
| Encoding | URLDecode | Yes | URLDecode | Encode |
| Encoding | PercentEncode | Yes | PercentEncode | Encode |
| Encoding | PercentDecode | Yes | PercentDecode | Encode |
| Encoding | FormURLEncode | Yes | FormURLEncode | Encode |
| Encoding | FormURLDecode | Yes | FormURLDecode | Encode |
| Encoding | Encode64 | Yes | Encode64 | Encode |
| Encoding | Decode64 | Yes | Decode64 | Encode |
| Encoding | TryDecode64 | Yes | TryDecode64 | Encode |
| Numeric | ToRoman | Yes | ToRoman | Numeric |
| Numeric | FromRoman | Yes | FromRoman | Numeric |
| Numeric | TryFromRoman | Yes | TryFromRoman | Numeric |
| Numeric | ToOrdinal | Yes | ToOrdinal | Numeric |
| Numeric | NumberToWords | Yes | NumberToWords | Numeric |
| Encoding | HexEncode | Yes | HexEncode | Encode |
| Encoding | HexDecode | Yes | HexDecode | Encode |
| Encoding | TryHexDecode | Yes | TryHexDecode | Encode |

# Summary

- TStringKit public methods: 80
- String Helper method names: 79
- All 80 are available in the helper (3 via alias names), as measured by the coverage tool.
  - ReverseText -> Reverse
  - CapitalizeText -> Capitalize
  - Join -> JoinWith
