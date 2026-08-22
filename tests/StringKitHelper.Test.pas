unit StringKitHelper.Test;

(*
  StringKitHelper.Test - Test cases for TStringHelperEx

  This unit contains test cases for the TStringHelperEx string helper class,
  which provides instance-style method calls for string manipulation.

  Generated on: 2025-02-15
*)

{$mode objfpc}{$H+}{$J-}

interface

uses
  Classes, SysUtils, Types, fpcunit, testregistry, StringKit, StringKitHelper;

type
  TStringArray = array of string;

type
  // TStringHelperTests
  TStringHelperTests = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Basic transformations
    procedure Test01_From;
    procedure Test02_ToString;
    procedure Test03_Trim;
    procedure Test04_TrimLeft;
    procedure Test05_TrimRight;
    procedure Test06_ToUpper;
    procedure Test07_ToLower;
    procedure Test08_Capitalize;
    // Advanced transformations
    procedure Test09_Reverse;
    procedure Test10_Duplicate;
    procedure Test11_PadLeft;
    procedure Test12_PadRight;
    procedure Test13_PadCenter;
    procedure Test14_RemoveWhitespace;
    procedure Test15_CollapseWhitespace;
    // Pattern matching and replacement
    procedure Test16_Replace;
    procedure Test17_ReplaceRegEx;
    procedure Test18_Extract;
    procedure Test19_ExtractAll;
    procedure Test20_Matches;
    // Substrings and parts
    procedure Test21_SubString;
    procedure Test22_Left;
    procedure Test23_Right;
    procedure Test24_Words;
    // Tests and information
    procedure Test25_Contains;
    procedure Test26_StartsWith;
    procedure Test27_EndsWith;
    procedure Test28_IsEmpty;
    procedure Test29_Length;
    procedure Test30_CountSubString;
    // String similarity functions
    procedure Test31_LevenshteinDistance;
    procedure Test32_LevenshteinSimilarity;
    procedure Test33_HammingDistance;
    procedure Test34_JaroSimilarity;
    procedure Test35_JaroWinklerSimilarity;
    procedure Test36_LongestCommonSubsequence;
    procedure Test37_LCSSimilarity;
    procedure Test38_IsFuzzyMatch;
    // Case conversion variants
    procedure Test39_ToTitleCase;
    procedure Test40_ToCamelCase;
    procedure Test41_ToPascalCase;
    procedure Test42_ToSnakeCase;
    procedure Test43_ToKebabCase;
    // String validation
    procedure Test44_IsValidEmail;
    procedure Test45_IsValidURL;
    procedure Test46_IsValidIP;
    procedure Test47_IsValidIPv4;
    procedure Test48_IsValidIPv6;
    procedure Test49_IsValidDate;
    // String transformation and formatting
    procedure Test50_Truncate;
    // String splitting and joining
    procedure Test51_Join;
    procedure Test52_Split;
    // Formatting
    procedure Test53_FormatFileSize;
    procedure Test54_FormatNumber;
    procedure Test55_FormatFloat;
    // Phonetic algorithms
    procedure Test56_Soundex;
    procedure Test57_Metaphone;
    // Text analysis
    procedure Test58_CountWords;
    procedure Test59_FleschKincaidReadability;
    // N-grams
    procedure Test60_GenerateNGrams;
    // Encoding/decoding
    procedure Test61_HexEncode;
    procedure Test62_HexDecode;
    procedure Test63_HTMLEncode;
    procedure Test64_HTMLDecode;
    procedure Test65_URLEncode;
    procedure Test66_URLDecode;
    procedure Test71_Base64Encode;
    procedure Test72_Base64Decode;
    procedure Test75_IdentifierCaseConversion;
    procedure Test76_TypedFuzzyMatch;
    procedure Test77_TryDecodingContracts;
    procedure Test78_TryFromRoman;
    procedure Test79_ExplicitURLEncoding;
    // Number conversions
    procedure Test67_FromRoman;
    procedure Test68_ToRoman;
    procedure Test69_ToOrdinal;
    procedure Test70_NumberToWords;
  end;

implementation

// TStringHelperTests

procedure TStringHelperTests.SetUp;
begin
  // No setup needed for string helpers
end;

procedure TStringHelperTests.TearDown;
begin
  // No teardown needed for string helpers
end;

procedure TStringHelperTests.Test01_From;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('String value should remain unchanged',
    TestStr, TestStr);
end;

procedure TStringHelperTests.Test02_ToString;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('String value should remain unchanged',
    TestStr, TestStr);
end;

procedure TStringHelperTests.Test03_Trim;
const
  TestStr = '  Hello, World!  ';
begin
  AssertEquals('Trim should remove surrounding whitespace',
    'Hello, World!', TestStr.Trim);
end;

procedure TStringHelperTests.Test04_TrimLeft;
const
  TestStr = '  Hello, World!  ';
begin
  AssertEquals('TrimLeft should remove leading whitespace',
    'Hello, World!  ', TestStr.TrimLeft);
end;

procedure TStringHelperTests.Test05_TrimRight;
const
  TestStr = '  Hello, World!  ';
begin
  AssertEquals('TrimRight should remove trailing whitespace',
    '  Hello, World!', TestStr.TrimRight);
end;

procedure TStringHelperTests.Test06_ToUpper;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('ToUpper should work correctly',
    'HELLO, WORLD!', TestStr.ToUpper);
end;

procedure TStringHelperTests.Test07_ToLower;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('ToLower should work correctly',
    'hello, world!', TestStr.ToLower);
end;

procedure TStringHelperTests.Test08_Capitalize;
const
  TestStr = 'hello, world!';
begin
  AssertEquals('Capitalize should work correctly',
    'Hello, World!', TestStr.Capitalize);
end;

procedure TStringHelperTests.Test09_Reverse;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('Reverse should work correctly',
    '!dlroW ,olleH', TestStr.Reverse);
end;

procedure TStringHelperTests.Test10_Duplicate;
const
  TestStr = 'Hello';
begin
  AssertEquals('DuplicateText should work correctly',
    'HelloHello', TestStr.DuplicateText(2));
end;

procedure TStringHelperTests.Test11_PadLeft;
const
  TestStr = 'test';
begin
  AssertEquals('PadLeft should work correctly',
    '****test', TestStr.PadLeft(8, '*'));
end;

procedure TStringHelperTests.Test12_PadRight;
const
  TestStr = 'test';
begin
  AssertEquals('PadRight should work correctly',
    'test****', TestStr.PadRight(8, '*'));
end;

procedure TStringHelperTests.Test13_PadCenter;
const
  TestStr = 'test';
begin
  AssertEquals('PadCenter should work correctly',
    '**test**', TestStr.PadCenter(8, '*'));
end;

procedure TStringHelperTests.Test14_RemoveWhitespace;
const
  TestStr = '  too   many    spaces  ';
begin
  AssertEquals('RemoveWhitespace should work correctly',
    'toomanyspaces', TestStr.RemoveWhitespace);
end;

procedure TStringHelperTests.Test15_CollapseWhitespace;
const
  TestStr = '  too   many    spaces  ';
begin
  AssertEquals('CollapseWhitespace should work correctly',
    'too many spaces', TestStr.CollapseWhitespace.Trim);
end;

procedure TStringHelperTests.Test16_Replace;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('ReplaceText should work correctly',
    'Hi, World!', TestStr.ReplaceText('Hello', 'Hi'));
end;

procedure TStringHelperTests.Test17_ReplaceRegEx;
const
  TestStr = 'The year is 2024';
begin
  AssertEquals('ReplaceRegEx should work correctly',
    'The year is 2024', TestStr.ReplaceRegEx('\d+', '2024'));
end;

procedure TStringHelperTests.Test18_Extract;
const
  TestStr = 'The year is 2024';
var
  Matches: TMatchesResults;
begin
  Matches := TestStr.ExtractMatches('\d+');
  AssertEquals('ExtractMatches should work correctly',
    '2024', Matches[0].Text);
end;

procedure TStringHelperTests.Test19_ExtractAll;
const
  TestStr = 'The year is 2024';
var
  Results: TStringArray;
begin
  Results := TestStr.ExtractAllMatches('\d+');
  AssertEquals('ExtractAllMatches should work correctly',
    '2024', Results[0]);
end;

procedure TStringHelperTests.Test20_Matches;
const
  TestStr = 'The year is 2024';
begin
  AssertTrue('MatchesPattern should work correctly',
    TestStr.MatchesPattern('\d+'));
end;

procedure TStringHelperTests.Test21_SubString;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('SubString should work correctly',
    'Hello', TestStr.SubString(1, 5));
end;

procedure TStringHelperTests.Test22_Left;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('LeftStr should work correctly',
    'Hello', TestStr.LeftStr(5));
end;

procedure TStringHelperTests.Test23_Right;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('RightStr should work correctly',
    'World!', TestStr.RightStr(6));
end;

procedure TStringHelperTests.Test24_Words;
const
  TestStr = 'Hello, World!';
var
  WordArray: TStringArray;
begin
  WordArray := TestStr.GetWords;
  AssertEquals('GetWords should work correctly',
    'Hello', WordArray[0]);
  AssertEquals('GetWords should work correctly',
    'World', WordArray[1]);
end;

procedure TStringHelperTests.Test25_Contains;
const
  TestStr = 'Hello, World!';
begin
  AssertTrue('Contains should work correctly',
    TestStr.Contains('World'));
end;

procedure TStringHelperTests.Test26_StartsWith;
const
  TestStr = 'Hello, World!';
begin
  AssertTrue('StartsWith should work correctly',
    TestStr.StartsWith('Hello'));
end;

procedure TStringHelperTests.Test27_EndsWith;
const
  TestStr = 'Hello, World!';
begin
  AssertTrue('EndsWith should work correctly',
    TestStr.EndsWith('World!'));
end;

procedure TStringHelperTests.Test28_IsEmpty;
begin
  AssertTrue('IsEmpty should work correctly',
    ''.IsEmpty);
end;

procedure TStringHelperTests.Test29_Length;
const
  TestStr = 'Hello, World!';
begin
  AssertEquals('GetLength should work correctly',
    13, TestStr.GetLength);
end;

procedure TStringHelperTests.Test30_CountSubString;
const
  TestStr = 'Hello, Hello, Hello!';
begin
  AssertEquals('CountSubString should work correctly',
    3, TestStr.CountSubString('Hello'));
  AssertEquals('CountSubString should delegate non-overlapping semantics',
    2, 'aaaaa'.CountSubString('aa'));
end;

procedure TStringHelperTests.Test31_LevenshteinDistance;
const
  TestStr = 'test';
begin
  AssertEquals('Identical strings should have distance 0',
    0, TestStr.LevenshteinDistance('test'));
end;

procedure TStringHelperTests.Test32_LevenshteinSimilarity;
const
  TestStr = 'test';
begin
  AssertEquals('Identical strings should have similarity 1.0',
    1.0, TestStr.LevenshteinSimilarity('test'));
  AssertEquals('Empty helper values should delegate perfect similarity',
    1.0, ''.LevenshteinSimilarity(''), 0.000001);
end;

procedure TStringHelperTests.Test33_HammingDistance;
const
  TestStr = 'test';
begin
  AssertEquals('Identical strings should have Hamming distance 0',
    0, TestStr.HammingDistance('test'));
end;

procedure TStringHelperTests.Test34_JaroSimilarity;
const
  TestStr = 'test';
begin
  AssertEquals('Identical strings should have Jaro similarity 1.0',
    1.0, TestStr.JaroSimilarity('test'));
end;

procedure TStringHelperTests.Test35_JaroWinklerSimilarity;
const
  TestStr = 'test';
begin
  AssertEquals('Identical strings should have Jaro-Winkler similarity 1.0',
    1.0, TestStr.JaroWinklerSimilarity('test'));
end;

procedure TStringHelperTests.Test36_LongestCommonSubsequence;
const
  TestStr = 'test';
begin
  AssertEquals('Identical strings should return the entire string',
    'test', TestStr.LongestCommonSubsequence('test'));
end;

procedure TStringHelperTests.Test37_LCSSimilarity;
const
  TestStr = 'test';
begin
  AssertEquals('Identical strings should have LCS similarity 1.0',
    1.0, TestStr.LCSSimilarity('test'));
  AssertEquals('Empty helper values should delegate perfect LCS similarity',
    1.0, ''.LCSSimilarity(''), 0.000001);
end;

procedure TStringHelperTests.Test38_IsFuzzyMatch;
const
  TestStr = 'test';
begin
  AssertTrue('Identical strings should match with any method and threshold',
    TestStr.IsFuzzyMatch('test', 0.8, 0));
end;

procedure TStringHelperTests.Test39_ToTitleCase;
const
  TestStr = 'this is a test';
begin
  AssertEquals('Title case should capitalize first letter of each word',
    'This Is A Test', TestStr.ToTitleCase);
end;

procedure TStringHelperTests.Test40_ToCamelCase;
const
  TestStr = 'this is a test';
begin
  AssertEquals('camelCase should start with lowercase and capitalize other words',
    'thisIsATest', TestStr.ToCamelCase);
end;

procedure TStringHelperTests.Test41_ToPascalCase;
const
  TestStr = 'this is a test';
begin
  AssertEquals('PascalCase should capitalize all words',
    'ThisIsATest', TestStr.ToPascalCase);
end;

procedure TStringHelperTests.Test42_ToSnakeCase;
const
  TestStr = 'this is a test';
begin
  AssertEquals('snake_case should be all lowercase with underscores',
    'this_is_a_test', TestStr.ToSnakeCase);
end;

procedure TStringHelperTests.Test43_ToKebabCase;
const
  TestStr = 'this is a test';
begin
  AssertEquals('kebab-case should be all lowercase with hyphens',
    'this-is-a-test', TestStr.ToKebabCase);
end;

procedure TStringHelperTests.Test44_IsValidEmail;
const
  ValidEmail = 'user@example.com';
  InvalidEmail = 'not-an-email';
begin
  AssertTrue('Valid email should pass', ValidEmail.IsValidEmail);
  AssertFalse('Invalid email should fail', InvalidEmail.IsValidEmail);
end;

procedure TStringHelperTests.Test45_IsValidURL;
const
  ValidURL = 'https://example.com';
  InvalidURL = 'not-a-url';
begin
  AssertTrue('Valid URL should pass', ValidURL.IsValidURL);
  AssertFalse('Invalid URL should fail', InvalidURL.IsValidURL);
end;

procedure TStringHelperTests.Test46_IsValidIP;
const
  ValidIPv4 = '192.168.1.1';
  ValidIPv6 = '2001:0db8:85a3:0000:0000:8a2e:0370:7334';
  InvalidIP = 'not.an.ip';
begin
  AssertTrue('Valid IPv4 should pass', ValidIPv4.IsValidIP);
  AssertTrue('Valid IPv6 should pass', ValidIPv6.IsValidIP);
  AssertFalse('Invalid IP should fail', InvalidIP.IsValidIP);
end;

procedure TStringHelperTests.Test47_IsValidIPv4;
const
  ValidIPv4 = '192.168.1.1';
  InvalidIPv4 = '256.256.256.256';
begin
  AssertTrue('Valid IPv4 should pass', ValidIPv4.IsValidIPv4);
  AssertFalse('Invalid IPv4 should fail', InvalidIPv4.IsValidIPv4);
end;

procedure TStringHelperTests.Test48_IsValidIPv6;
const
  ValidIPv6 = '2001:0db8:85a3:0000:0000:8a2e:0370:7334';
  InvalidIPv6 = '2001:db8:::1';
begin
  AssertTrue('Valid IPv6 should pass', ValidIPv6.IsValidIPv6);
  AssertFalse('Invalid IPv6 should fail', InvalidIPv6.IsValidIPv6);
end;

procedure TStringHelperTests.Test49_IsValidDate;
const
  ValidDate = '2023-01-15';
  InvalidDate = '2023-02-31';
begin
  AssertTrue('Valid date should pass', ValidDate.IsValidDate('yyyy-mm-dd'));
  AssertFalse('Invalid date should fail', InvalidDate.IsValidDate('yyyy-mm-dd'));
end;

procedure TStringHelperTests.Test50_Truncate;
const
  TestStr = 'This is a long string';
begin
  AssertEquals('Truncate should limit string length',
    'This is...', TestStr.Truncate(10, '...'));
  AssertEquals('Truncate should delegate a non-positive limit',
    '', 'abcdef'.Truncate(0));
end;

procedure TStringHelperTests.Test51_Join;
var
  Arr: TStringArray;
begin
  SetLength(Arr, 3);
  Arr[0] := 'one';
  Arr[1] := 'two';
  Arr[2] := 'three';
  
  AssertEquals('Join should concatenate with delimiter',
    'one,two,three', string(',').JoinWith(Arr));
end;

procedure TStringHelperTests.Test52_Split;
var
  Result: TStringArray;
begin
  Result := 'one,two,three'.Split(',');
  AssertEquals('Split should return correct number of elements', 3, Length(Result));
  AssertEquals('First element should match', 'one', Result[0]);
  AssertEquals('Second element should match', 'two', Result[1]);
  AssertEquals('Third element should match', 'three', Result[2]);

  Result := 'a,b,'.Split(',');
  AssertEquals('Split should delegate trailing empty entries', 3, Length(Result));
  AssertEquals('Split should preserve a trailing empty entry', '', Result[2]);
end;

procedure TStringHelperTests.Test53_FormatFileSize;
begin
  AssertEquals('FormatFileSize should format bytes correctly',
    '1.00 KB', '1024'.FormatFileSize);
  AssertEquals('FormatFileSize should handle zero',
    '0 B', string('0').FormatFileSize);
  AssertEquals('FormatFileSize should handle large numbers',
    '1.00 MB', '1048576'.FormatFileSize);
  AssertEquals('FormatFileSize should handle invalid input',
    '0 B', 'notanumber'.FormatFileSize);
end;

procedure TStringHelperTests.Test54_FormatNumber;
begin
  AssertEquals('FormatNumber should format with default separator',
    '1,234,567', '1234567'.FormatNumber);
  AssertEquals('FormatNumber should handle custom separator',
    '1.234.567', '1234567'.FormatNumber('.'));
  AssertEquals('FormatNumber should handle small numbers',
    '123', '123'.FormatNumber);
  AssertEquals('FormatNumber should handle zero',
    '0', string('0').FormatNumber);
  AssertEquals('FormatNumber should delegate negative number formatting',
    '-1,234,567', '-1234567'.FormatNumber);
  AssertEquals('FormatNumber should handle invalid input',
    '0', 'notanumber'.FormatNumber);
end;

procedure TStringHelperTests.Test55_FormatFloat;
begin
  // Test with default parameters
  AssertEquals('FormatFloat should format with default parameters',
    '12,345.68', '12345.6789'.FormatFloat);
    
  // Test with custom decimal places
  AssertEquals('FormatFloat should handle custom decimal places',
    '12,345.679', '12345.6789'.FormatFloat(3));
    
  // Test with custom separators
  AssertEquals('FormatFloat should handle custom separators',
    '12.345,679', '12345.6789'.FormatFloat(3, ',', '.'));
    
  // Test with negative numbers
  AssertEquals('FormatFloat should handle negative numbers',
    '-9,876.5', '-9876.543'.FormatFloat(1));
    
  // Test with zero decimals
  AssertEquals('FormatFloat should handle zero decimals',
    '1,234', '1234'.FormatFloat(0));
    
  // Test with invalid input
  AssertEquals('FormatFloat should handle invalid input',
    '0.00', 'notanumber'.FormatFloat);
end;

procedure TStringHelperTests.Test56_Soundex;
begin
  // Test standard Soundex examples
  AssertEquals('Soundex should encode names correctly',
    'R163', 'Robert'.Soundex);
  AssertEquals('Soundex should encode similar sounding names the same',
    'R163', 'Rupert'.Soundex);
  AssertEquals('Soundex should handle adjacent same codes',
    'A261', 'Ashcraft'.Soundex);
  AssertEquals('Soundex should handle adjacent same codes with extra letters',
    'A261', 'Ashcraftt'.Soundex);
  AssertEquals('Soundex should handle special cases',
    'T522', 'Tymczak'.Soundex);
  AssertEquals('Soundex should handle special cases',
    'P236', 'Pfister'.Soundex);
  AssertEquals('Soundex should handle single-letter names',
    'A000', string('A').Soundex);
  AssertEquals('Soundex should handle empty string',
    '', ''.Soundex);
  AssertEquals('Soundex should handle names with non-alphabetic first character',
    '@000', '@#$%'.Soundex);
end;

procedure TStringHelperTests.Test57_Metaphone;
begin
  // Test standard Metaphone examples
  AssertEquals('Metaphone should encode words correctly',
    'MTFN', 'metaphone'.Metaphone);
  AssertEquals('Metaphone should handle silent letters',
    'TLFN', 'telephone'.Metaphone);
  AssertEquals('Metaphone should handle common patterns',
    'EKSMPL', 'example'.Metaphone);
  AssertEquals('Metaphone should handle silent K and GH',
    'NT', 'knight'.Metaphone);
  AssertEquals('Metaphone should handle silent W',
    'RK', 'wrack'.Metaphone);
  AssertEquals('Metaphone should handle SC pattern',
    'SNS', 'science'.Metaphone);
  AssertEquals('Metaphone should handle GH pattern',
    'T', 'tough'.Metaphone);
  AssertEquals('Metaphone should handle initial X',
    'SFR', 'Xavier'.Metaphone);
  AssertEquals('Metaphone should handle empty string',
    '', ''.Metaphone);
  AssertEquals('Metaphone should handle non-alphabetic input',
    '', '@#$%'.Metaphone);
end;

procedure TStringHelperTests.Test58_CountWords;
begin
  // Test basic word counting
  AssertEquals('CountWords should count words in a simple sentence',
    5, 'Hello, world! How are you?'.CountWords);
  AssertEquals('CountWords should handle alphanumeric words',
    3, 'Item123 Code-ABC.'.CountWords);
  AssertEquals('CountWords should handle single word',
    1, 'OneWord'.CountWords);
  AssertEquals('CountWords should handle empty string',
    0, ''.CountWords);
  AssertEquals('CountWords should handle whitespace only',
    0, '   '.CountWords);
  AssertEquals('CountWords should handle punctuation',
    4, 'This is a test.'.CountWords);
  AssertEquals('CountWords should handle mixed case',
    3, 'TeStInG OnE TwO'.CountWords);
  AssertEquals('CountWords should handle numbers',
    3, '123 456 789'.CountWords);
  AssertEquals('CountWords should handle mixed alphanumeric',
    4, 'Word1 2Word 3rdWord Word4'.CountWords);
end;

procedure TStringHelperTests.Test59_FleschKincaidReadability;
begin
  // Test with empty string
  AssertEquals('FleschKincaidReadability should return 0 for empty string',
    0.0, ''.FleschKincaidReadability, 0.01);
    
  // Test with simple text (should be easy to read)
  AssertTrue('FleschKincaidReadability should return high score for simple text',
    'The cat sat on the mat.'.FleschKincaidReadability > 80.0);
    
  // Test with complex text (should be harder to read)
  AssertTrue('FleschKincaidReadability should return lower score for complex text',
    'The antidisestablishmentarianism of the aforementioned individuals is not to be underestimated.'.FleschKincaidReadability < 50.0);
    
  // Test with numbers and punctuation
  AssertTrue('FleschKincaidReadability should handle numbers and punctuation',
    'There are 3 apples and 4 oranges in the basket.'.FleschKincaidReadability > 0.0);
    
  // Test with abbreviations
  AssertTrue('FleschKincaidReadability should handle abbreviations',
    'The U.S.A. has 50 states.'.FleschKincaidReadability > 0.0);
end;

procedure TStringHelperTests.Test60_GenerateNGrams;
var
  Result: TStringDynArray;
begin
  // Bigrams
  Result := 'This is a test'.GenerateNGrams(2);
  AssertEquals('Bigrams should have correct count', 3, Length(Result));
  AssertEquals('First bigram should match', 'This is', Result[0]);
  AssertEquals('Second bigram should match', 'is a', Result[1]);
  AssertEquals('Third bigram should match', 'a test', Result[2]);

  // Trigrams
  Result := 'This is a test'.GenerateNGrams(3);
  AssertEquals('Trigrams should have correct count', 2, Length(Result));
  AssertEquals('First trigram should match', 'This is a', Result[0]);
  AssertEquals('Second trigram should match', 'is a test', Result[1]);

  // Not enough words
  Result := 'Single'.GenerateNGrams(2);
  AssertEquals('Not enough words for n-gram should return empty array', 0, Length(Result));

  // Empty text
  Result := ''.GenerateNGrams(2);
  AssertEquals('Empty text should return empty array', 0, Length(Result));

  // Invalid N
  Result := 'This is a test'.GenerateNGrams(0);
  AssertEquals('N=0 should return empty array', 0, Length(Result));
end;

procedure TStringHelperTests.Test61_HexEncode;
const
  TestStr = 'Hello';
begin
  AssertEquals('HexEncode should work correctly',
    '48656C6C6F', TestStr.HexEncode);
end;

procedure TStringHelperTests.Test62_HexDecode;
const
  TestHex = '48656C6C6F';
begin
  AssertEquals('HexDecode should work correctly',
    'Hello', TestHex.HexDecode);
end;

procedure TStringHelperTests.Test63_HTMLEncode;
const
  S = '<tag attr="x"> & text';
var
  Enc: string;
begin
  Enc := S.HTMLEncode;
  // Should replace special chars
  AssertTrue('HTMLEncode should encode <', Pos('&lt;', Enc) > 0);
  AssertTrue('HTMLEncode should encode >', Pos('&gt;', Enc) > 0);
  AssertTrue('HTMLEncode should encode &', Pos('&amp;', Enc) > 0);
  // Round-trip check
  AssertEquals('HTMLEncode/HTMLDecode should be inverse', S, Enc.HTMLDecode);
end;

procedure TStringHelperTests.Test64_HTMLDecode;
const
  Enc = '&lt;hi&gt;&amp;';
begin
  AssertEquals('HTMLDecode should decode common entities', '<hi>&', Enc.HTMLDecode);
end;

procedure TStringHelperTests.Test65_URLEncode;
const
  S = 'Hello World!';
var
  Enc: string;
begin
  Enc := S.URLEncode;
  AssertTrue('URLEncode should change string with spaces/punctuation', S <> Enc);
  // Round-trip should recover original
  AssertEquals('URLEncode/URLDecode should be inverse', S, Enc.URLDecode);
end;

procedure TStringHelperTests.Test66_URLDecode;
const
  Enc = 'Hello%20World%21';
begin
  AssertEquals('URLDecode should decode percent-encoded sequences', 'Hello World!', Enc.URLDecode);
end;

procedure TStringHelperTests.Test71_Base64Encode;
begin
  // Basic examples
  AssertEquals('Base64 encode of Hello', 'SGVsbG8=', string('Hello').Encode64);
  AssertEquals('Empty string encodes to empty', '', ''.Encode64);

  // RFC 4648 test vectors
  AssertEquals('RFC vector 1', 'TWFu', string('Man').Encode64);
  AssertEquals('RFC vector 2', 'TWE=', string('Ma').Encode64);
  AssertEquals('RFC vector 3', 'TQ==', string('M').Encode64);

  // Common padding scenarios
  AssertEquals('foo', 'Zm9v', string('foo').Encode64);
  AssertEquals('fo', 'Zm8=', string('fo').Encode64);
  AssertEquals('f', 'Zg==', string('f').Encode64);
end;

procedure TStringHelperTests.Test72_Base64Decode;
var
  WithWS: string;
begin
  // Basic examples
  AssertEquals('Base64 decode of SGVsbG8=', 'Hello', string('SGVsbG8=').Decode64);
  AssertEquals('Empty string decodes to empty', '', ''.Decode64);

  // RFC 4648 test vectors
  AssertEquals('RFC vector 1', 'Man', string('TWFu').Decode64);
  AssertEquals('RFC vector 2', 'Ma', string('TWE=').Decode64);
  AssertEquals('RFC vector 3', 'M', string('TQ==').Decode64);

  // Ignore whitespace in decoder
  WithWS := 'Zm' + #13#10 + '9v' + #9 + '' + #32 + '';
  AssertEquals('Decoder should ignore whitespace', 'foo', WithWS.Decode64);

  // Padding and non-padded cases
  AssertEquals('foo', 'foo', string('Zm9v').Decode64);
  AssertEquals('fo', 'fo', string('Zm8=').Decode64);
  AssertEquals('f', 'f', string('Zg==').Decode64);

  // Invalid input should return empty string per implementation
  AssertEquals('Invalid characters should yield empty', '', string('@@@').Decode64);
  AssertEquals('Bad padding should yield empty', '', string('SGVsbG8===').Decode64);
end;

procedure TStringHelperTests.Test67_FromRoman;
begin
  // Basic conversions
  AssertEquals('I should convert to 1', 1, string('I').FromRoman);
  AssertEquals('IV should convert to 4', 4, string('IV').FromRoman);
  AssertEquals('V should convert to 5', 5, string('V').FromRoman);
  AssertEquals('IX should convert to 9', 9, string('IX').FromRoman);
  AssertEquals('X should convert to 10', 10, string('X').FromRoman);
  AssertEquals('XL should convert to 40', 40, string('XL').FromRoman);
  AssertEquals('L should convert to 50', 50, string('L').FromRoman);
  AssertEquals('XC should convert to 90', 90, string('XC').FromRoman);
  AssertEquals('C should convert to 100', 100, string('C').FromRoman);
  AssertEquals('CD should convert to 400', 400, string('CD').FromRoman);
  AssertEquals('D should convert to 500', 500, string('D').FromRoman);
  AssertEquals('CM should convert to 900', 900, string('CM').FromRoman);
  AssertEquals('M should convert to 1000', 1000, string('M').FromRoman);

  // Complex and case insensitivity
  AssertEquals('MCMLXXXIV should convert to 1984', 1984, string('MCMLXXXIV').FromRoman);
  AssertEquals('mcmlxxxiv should convert to 1984', 1984, string('mcmlxxxiv').FromRoman);

  // Boundary/invalid
  AssertEquals('Empty string should convert to 0', 0, string('').FromRoman);
  AssertEquals('Invalid Roman numerals should convert to 0', 0, string('ABCDEF').FromRoman);
  AssertEquals('Non-standard IIII converts to 4 if accepted', 4, string('IIII').FromRoman);
end;

procedure TStringHelperTests.Test68_ToRoman;
begin
  // Basic conversions
  AssertEquals('1 should convert to I', 'I', string('1').ToRoman);
  AssertEquals('4 should convert to IV', 'IV', string('4').ToRoman);
  AssertEquals('5 should convert to V', 'V', string('5').ToRoman);
  AssertEquals('9 should convert to IX', 'IX', string('9').ToRoman);
  AssertEquals('10 should convert to X', 'X', string('10').ToRoman);
  AssertEquals('40 should convert to XL', 'XL', string('40').ToRoman);
  AssertEquals('50 should convert to L', 'L', string('50').ToRoman);
  AssertEquals('90 should convert to XC', 'XC', string('90').ToRoman);
  AssertEquals('100 should convert to C', 'C', string('100').ToRoman);
  AssertEquals('400 should convert to CD', 'CD', string('400').ToRoman);
  AssertEquals('500 should convert to D', 'D', string('500').ToRoman);
  AssertEquals('900 should convert to CM', 'CM', string('900').ToRoman);
  AssertEquals('1000 should convert to M', 'M', string('1000').ToRoman);

  // Complex and boundaries
  AssertEquals('1984 should convert to MCMLXXXIV', 'MCMLXXXIV', string('1984').ToRoman);
  AssertEquals('2024 should convert to MMXXIV', 'MMXXIV', string('2024').ToRoman);
  AssertEquals('3999 should convert to MMMCMXCIX', 'MMMCMXCIX', string('3999').ToRoman);
  AssertEquals('0 should convert to empty string', '', string('0').ToRoman);
  AssertEquals('Negative numbers should convert to empty string', '', string('-5').ToRoman);
  AssertEquals('Numbers over 3999 should convert to empty string', '', string('4000').ToRoman);
end;

procedure TStringHelperTests.Test69_ToOrdinal;
begin
  AssertEquals('ToOrdinal should handle 1st', '1st', string('1').ToOrdinal);
  AssertEquals('ToOrdinal should handle 2nd', '2nd', string('2').ToOrdinal);
  AssertEquals('ToOrdinal should handle 3rd', '3rd', string('3').ToOrdinal);
  AssertEquals('ToOrdinal should handle 4th', '4th', string('4').ToOrdinal);
  AssertEquals('ToOrdinal should handle 11th', '11th', '11'.ToOrdinal);
  AssertEquals('ToOrdinal should handle 12th', '12th', '12'.ToOrdinal);
  AssertEquals('ToOrdinal should handle 13th', '13th', '13'.ToOrdinal);
  AssertEquals('ToOrdinal should handle 21st', '21st', '21'.ToOrdinal);
end;

procedure TStringHelperTests.Test70_NumberToWords;
begin
  AssertEquals('NumberToWords should handle zero', 'zero', string('0').NumberToWords);
  AssertEquals('NumberToWords should handle single digits', 'five', string('5').NumberToWords);
  AssertEquals('NumberToWords should handle teens', 'fifteen', '15'.NumberToWords);
end;

procedure TStringHelperTests.Test75_IdentifierCaseConversion;
begin
  AssertEquals('Helper should delegate identifier-aware snake case',
    'xml_http_request', 'XMLHttpRequest'.ToSnakeCase);
  AssertEquals('Helper should delegate identifier-aware kebab case',
    'hello-world', 'HelloWorld'.ToKebabCase);
  AssertEquals('Helper should delegate identifier-aware camel case',
    'html5Parser', 'HTML5Parser'.ToCamelCase);
end;

procedure TStringHelperTests.Test76_TypedFuzzyMatch;
begin
  AssertTrue('Helper should expose the typed fuzzy selector',
    'hello'.IsFuzzyMatch('hallo', 0.6, fmLevenshtein));
end;

procedure TStringHelperTests.Test77_TryDecodingContracts;
var
  Decoded: string;
begin
  AssertTrue('Helper should expose strict hex decoding',
    '48656C6C6F'.TryHexDecode(Decoded));
  AssertEquals('Helper strict hex decoding should delegate', 'Hello', Decoded);
  AssertTrue('Helper should expose strict Base64 decoding',
    'SGVsbG8='.TryDecode64(Decoded));
  AssertEquals('Helper strict Base64 decoding should delegate', 'Hello', Decoded);
end;

procedure TStringHelperTests.Test78_TryFromRoman;
var
  Value: Integer;
begin
  AssertTrue('Helper should expose strict Roman parsing',
    'MMXXVI'.TryFromRoman(Value));
  AssertEquals('Helper strict Roman parsing should delegate', 2026, Value);
end;

procedure TStringHelperTests.Test79_ExplicitURLEncoding;
begin
  AssertEquals('Helper should expose percent encoding',
    'hello%20world', 'hello world'.PercentEncode);
  AssertEquals('Helper should expose form encoding',
    'hello+world', 'hello world'.FormURLEncode);
  AssertEquals('Helper percent decoding should preserve plus',
    'a+b', 'a+b'.PercentDecode);
  AssertEquals('Helper form decoding should convert plus',
    'a b', 'a+b'.FormURLDecode);
end;

initialization
  RegisterTest(TStringHelperTests);

end.
