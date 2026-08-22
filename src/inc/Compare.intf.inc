// String similarity and comparison
function LevenshteinDistance(const S: string): Integer; inline;
function LevenshteinSimilarity(const S: string): Double; inline;
function HammingDistance(const S: string): Integer; inline;
function JaroSimilarity(const S: string): Double; inline;
function JaroWinklerSimilarity(const S: string): Double; inline;
function LongestCommonSubsequence(const S: string): string; inline;
function LCSSimilarity(const S: string): Double; inline;
function IsFuzzyMatch(const S: string; Threshold: Double = 0.7; Method: Integer = 0): Boolean; overload; inline;
function IsFuzzyMatch(const S: string; Threshold: Double; Method: TFuzzyMethod): Boolean; overload; inline;
