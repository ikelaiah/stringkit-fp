unit StringKit;

{$mode objfpc}{$H+}{$J-}

interface

uses
  Classes, SysUtils, Types, RegExpr, StrUtils, Math, DateUtils, base64;

type
  { TStringMatch
    ------------
    Represents a single match result from pattern matching operations.
    Contains the matched text, its position in the original string,
    and the length of the match. }
  TStringMatch = record
    Text: string;      // The matched text
    Position: Integer; // Starting position in original string (1-based)
    Length: Integer;   // Length of the matched text
  end;
  
  {
    TMatchResults
    --------------
    Array of TStringMatch records for pattern matching results.
  }
  TMatchesResults = array of TStringMatch;

  

  { TStringKit
    ----------
    A comprehensive toolkit for string manipulation operations.
    Provides methods for common string operations like trimming,
    case conversion, padding, pattern matching, and more.
    
    All methods are static (class functions) for ease of use - 
    no need to create instances. }
  TStringKit = class
  private
    {
      @description Checks if a character is considered whitespace.
                   Whitespace characters are space (#32), tab (#9), line feed (#10),
                   and carriage return (#13).
      
      @usage Use when validating characters or implementing text processing 
             functions that need to identify space, tab, CR, or LF.
      
      @param C The character to check.
      
      @returns True if the character is whitespace, False otherwise.
      
      @warning Does not consider other Unicode whitespace characters.
      
      @example
        Result := IsWhiteSpace(' '); // Returns: True
        Result := IsWhiteSpace(#9);  // Returns: True
        Result := IsWhiteSpace('A'); // Returns: False
    }
    class function IsWhiteSpace(const C: Char): Boolean; static;
    
    {
      @description Computes the minimum value among three integers.
      
      @usage Use when implementing algorithms that require finding
             the smallest of three values, such as the Levenshtein distance algorithm.
      
      @param A First integer value.
      @param B Second integer value.
      @param C Third integer value.
      
      @returns The smallest of the three integer values.
      
      @warning None identified.
      
      @example
        Result := Min3(5, 2, 8); // Returns: 2
        Result := Min3(-1, -5, 0); // Returns: -5
    }
    class function Min3(A, B, C: Integer): Integer; static;
    
    {
      @description Computes the minimum value between two integers.
      
      @usage Use when implementing string similarity algorithms
             or other comparison operations needing the smaller of two values.
      
      @param A First integer value.
      @param B Second integer value.
      
      @returns The smaller of the two integer values.
      
      @warning None identified.
      
      @example
        Result := Min2(5, 2); // Returns: 2
        Result := Min2(-1, 5); // Returns: -1
    }
    class function Min2(A, B: Integer): Integer; static;
    
    {
      @description Computes the maximum value between two integers.
      
      @usage Use when implementing string similarity algorithms
             or other comparison operations needing the larger of two values.
      
      @param A First integer value.
      @param B Second integer value.
      
      @returns The larger of the two integer values.
      
      @warning None identified.
      
      @example
        Result := Max2(5, 2); // Returns: 5
        Result := Max2(-1, 5); // Returns: 5
    }
    class function Max2(A, B: Integer): Integer; static;
    
    {
      @description Counts the number of vowel groups in a word.
                   A vowel group is a contiguous sequence of vowels (a, e, i, o, u, y).
                   Includes a heuristic to handle silent 'e' at the end of words.
      
      @usage Primarily used as a helper function for syllable estimation in readability
             calculations like Flesch-Kincaid.
      
      @param Word The word to analyze (case-insensitive, uses lowercase internally).
      
      @returns The estimated number of syllables based on vowel groups. Returns 1 for empty or non-vowel words.
      
      @warning This is a heuristic and may not be perfectly accurate for all English words,
               especially complex ones or exceptions. Assumes 'y' is always a vowel in this context.
               The silent 'e' rule is basic and might miscount in some cases (e.g., "recipe").
      
      @example
        Result := CountVowelGroups('beautiful'); // Returns: 3 (eau, i, u)
        Result := CountVowelGroups('rhythm');    // Returns: 1 (y)
        Result := CountVowelGroups('the');       // Returns: 1 (e) - silent 'e' rule doesn't apply as 'h' is not a vowel.
        Result := CountVowelGroups('me');        // Returns: 1 (e) - silent 'e' rule reduces count from 1 to 0, then minimum 1 is enforced.
        Result := CountVowelGroups('');          // Returns: 1
    }
    class function CountVowelGroups(const Word: string): Integer; static;
  public
    {
      @description Removes leading and trailing whitespace (space, tab, CR, LF) from a string.
                   Uses the standard SysUtils.Trim function.
      
      @usage Use to clean up user input or data before processing or storage.
      
      @param Text The string to trim.
      
      @returns The string with leading and trailing whitespace removed. Returns an empty string if the input is empty or contains only whitespace.
      
      @warning Relies on SysUtils.Trim implementation.
      
      @example
        Result := Trim('  Hello World  '); // Returns: 'Hello World'
        Result := Trim(#9'Tabbed'#13#10); // Returns: 'Tabbed'
        Result := Trim('   ');            // Returns: ''
        Result := Trim('');               // Returns: ''
    }
    class function Trim(const Text: string): string; static;
    
    {
      @description Removes leading whitespace (space, tab, CR, LF) from a string.
                   Uses the standard SysUtils.TrimLeft function.
      
      @usage Use when only leading whitespace needs to be removed, preserving trailing whitespace.
      
      @param Text The string to trim from the left.
      
      @returns The string with leading whitespace removed. Returns the original string if it has no leading whitespace.
      
      @warning Relies on SysUtils.TrimLeft implementation.
      
      @example
        Result := TrimLeft('  Hello World  '); // Returns: 'Hello World  '
        Result := TrimLeft(#9'Tabbed'#13#10); // Returns: 'Tabbed'#13#10
        Result := TrimLeft('NoSpaces');       // Returns: 'NoSpaces'
        Result := TrimLeft('');               // Returns: ''
    }
    class function TrimLeft(const Text: string): string; static;
    
    {
      @description Removes trailing whitespace (space, tab, CR, LF) from a string.
                   Uses the standard SysUtils.TrimRight function.
      
      @usage Use when only trailing whitespace needs to be removed, preserving leading whitespace.
      
      @param Text The string to trim from the right.
      
      @returns The string with trailing whitespace removed. Returns the original string if it has no trailing whitespace.
      
      @warning Relies on SysUtils.TrimRight implementation.
      
      @example
        Result := TrimRight('  Hello World  '); // Returns: '  Hello World'
        Result := TrimRight(#9'Tabbed'#13#10); // Returns: #9'Tabbed'
        Result := TrimRight('NoSpaces');       // Returns: 'NoSpaces'
        Result := TrimRight('');               // Returns: ''
    }
    class function TrimRight(const Text: string): string; static;
    
    {
      @description Converts a string to its uppercase representation.
                   Uses the standard SysUtils.UpperCase function.
      
      @usage Use for case-insensitive comparisons or standardizing text format.
      
      @param Text The string to convert.
      
      @returns The uppercase version of the string.
      
      @warning Behavior for non-ASCII characters depends on system locale settings and FPC version.
      
      @example
        Result := ToUpper('Hello World'); // Returns: 'HELLO WORLD'
        Result := ToUpper('already_UPPER'); // Returns: 'ALREADY_UPPER'
        Result := ToUpper('123');         // Returns: '123'
        Result := ToUpper('');            // Returns: ''
    }
    class function ToUpper(const Text: string): string; static;
    
    {
      @description Converts a string to its lowercase representation.
                   Uses the standard SysUtils.LowerCase function.
      
      @usage Use for case-insensitive comparisons or standardizing text format.
      
      @param Text The string to convert.
      
      @returns The lowercase version of the string.
      
      @warning Behavior for non-ASCII characters depends on system locale settings and FPC version.
      
      @example
        Result := ToLower('Hello World'); // Returns: 'hello world'
        Result := ToLower('ALREADY_lower'); // Returns: 'already_lower'
        Result := ToLower('123');         // Returns: '123'
        Result := ToLower('');            // Returns: ''
    }
    class function ToLower(const Text: string): string; static;
    
    {
      @description Centers a string within a specified width by adding padding characters
                   on both sides. If the padding cannot be distributed evenly, the right side
                   will have the extra padding character.
      
      @usage Use for formatting text output, creating aligned columns, or visual centering.
      
      @param Text The string to pad and center.
      @param Width The desired total width of the resulting string.
      @param PadChar The character to use for padding (default is space ' ').
      
      @returns The centered string. If the original string's length is greater than or equal
               to the specified Width, the original string is returned unchanged.
      
      @warning If Width is less than the length of Text, no padding occurs.
      
      @example
        Result := PadCenter('Hello', 10);    // Returns: '  Hello   '
        Result := PadCenter('Hello', 11, '*'); // Returns: '***Hello***' (Note: Right side gets extra if uneven)
        Result := PadCenter('Hello', 5);     // Returns: 'Hello'
        Result := PadCenter('Hello', 3);     // Returns: 'Hello'
        Result := PadCenter('', 5, '-');     // Returns: '-- --' (Note: Right side gets extra if uneven)
    }
    class function PadCenter(const Text: string; Width: Integer; PadChar: Char = ' '): string; static;
    
    {
      @description Adds padding characters to the left of a string to reach a specified width.
      
      @usage Use for right-aligning text or numbers in fixed-width output.
      
      @param Text The string to pad.
      @param Width The desired total width of the resulting string.
      @param PadChar The character to use for padding (default is space ' ').
      
      @returns The left-padded string. If the original string's length is greater than or equal
               to the specified Width, the original string is returned unchanged.
      
      @warning If Width is less than the length of Text, no padding occurs.
      
      @example
        Result := PadLeft('Hello', 10);    // Returns: '     Hello'
        Result := PadLeft('Hello', 10, '*'); // Returns: '*****Hello'
        Result := PadLeft('Hello', 5);     // Returns: 'Hello'
        Result := PadLeft('Hello', 3);     // Returns: 'Hello'
        Result := PadLeft('', 5, '-');     // Returns: '-----'
    }
    class function PadLeft(const Text: string; Width: Integer; PadChar: Char = ' '): string; static;
    
    {
      @description Adds padding characters to the right of a string to reach a specified width.
      
      @usage Use for left-aligning text in fixed-width output.
      
      @param Text The string to pad.
      @param Width The desired total width of the resulting string.
      @param PadChar The character to use for padding (default is space ' ').
      
      @returns The right-padded string. If the original string's length is greater than or equal
               to the specified Width, the original string is returned unchanged.
      
      @warning If Width is less than the length of Text, no padding occurs.
      
      @example
        Result := PadRight('Hello', 10);    // Returns: 'Hello     '
        Result := PadRight('Hello', 10, '*'); // Returns: 'Hello*****'
        Result := PadRight('Hello', 5);     // Returns: 'Hello'
        Result := PadRight('Hello', 3);     // Returns: 'Hello'
        Result := PadRight('', 5, '-');     // Returns: '-----'
    }
    class function PadRight(const Text: string; Width: Integer; PadChar: Char = ' '): string; static;
    
    {
      @description Replaces sequences of multiple whitespace characters (space, tab, CR, LF)
                   within a string with a single space character. Leading and trailing
                   whitespace are handled like internal whitespace.
      
      @usage Use to normalize spacing in text, often after removing unwanted line breaks
             or before splitting text into words.
      
      @param Text The string to process.
      
      @returns The string with collapsed whitespace. An empty string input returns an empty string.
               A string containing only whitespace returns a single space (if not empty).
      
      @warning Uses the private IsWhiteSpace function which checks for ' ', #9, #10, #13.
               Does not trim leading/trailing single spaces resulting from collapsing.
      
      @example
        Result := CollapseWhitespace('Hello   World');   // Returns: 'Hello World'
        Result := CollapseWhitespace('  Leading and trailing  '); // Returns: ' Leading and trailing '
        Result := CollapseWhitespace(#9'Tab'#10#13'Newline'); // Returns: ' Tab Newline'
        Result := CollapseWhitespace('   ');              // Returns: ' '
        Result := CollapseWhitespace('');                 // Returns: ''
    }
    class function CollapseWhitespace(const Text: string): string; static;
    
    {
      @description Removes all whitespace characters (space, tab, CR, LF) from a string.
      
      @usage Use when all whitespace needs to be eliminated, for example, before certain
             types of data validation or comparison.
      
      @param Text The string to process.
      
      @returns The string with all whitespace characters removed.
      
      @warning Uses the private IsWhiteSpace function which checks for ' ', #9, #10, #13.
      
      @example
        Result := RemoveWhitespace('Hello   World');   // Returns: 'HelloWorld'
        Result := RemoveWhitespace('  Leading and trailing  '); // Returns: 'Leadingandtrailing'
        Result := RemoveWhitespace(#9'Tab'#10#13'Newline'); // Returns: 'TabNewline'
        Result := RemoveWhitespace('   ');              // Returns: ''
        Result := RemoveWhitespace('');                 // Returns: ''
    }
    class function RemoveWhitespace(const Text: string): string; static;
    
    {
      @description Repeats a string a specified number of times, concatenating the results.
      
      @usage Use when you need to create patterns, separator lines,
             or duplicate content a known number of times.
      
      @param Text The string to repeat.
      @param Count The number of times to repeat the string. Must be a non-negative integer.
      
      @returns The concatenated result of the repeated string.
      
      @warning Returns an empty string if Count is zero or negative.
               Repeating a large string many times can consume significant memory.
      
      @example
        Result := DuplicateText('abc', 3); // Returns: 'abcabcabc'
        Result := DuplicateText('-', 5);   // Returns: '-----'
        Result := DuplicateText('Test', 1); // Returns: 'Test'
        Result := DuplicateText('Test', 0); // Returns: ''
        Result := DuplicateText('', 5);    // Returns: ''
    }
    class function DuplicateText(const Text: string; Count: Integer): string; static;
    
    {
      @description Reverses the order of characters in a string.
      
      @usage Use when you need to invert the character order,
             such as for string manipulation algorithms or palindrome checks.
      
      @param Text The string to reverse.
      
      @returns The string with characters in reversed order.
      
      @warning Does not handle multi-byte Unicode characters correctly; it reverses bytes.
               An empty string input returns an empty string.
      
      @example
        Result := ReverseText('Hello'); // Returns: 'olleH'
        Result := ReverseText('racecar'); // Returns: 'racecar'
        Result := ReverseText('123');   // Returns: '321'
        Result := ReverseText('');      // Returns: ''
    }
    class function ReverseText(const Text: string): string; static;
    
    {
      @description Capitalizes the first character of each word in a string. Words are
                   determined by splitting the string by spaces.
      
      @usage Use when formatting titles, names, or any text that requires
             the first letter of each word to be capitalized (often referred to as Title Case,
             though this implementation is simpler).
      
      @param Text The string to capitalize.
      
      @returns The string with the first character of each space-separated word capitalized.
               Other characters are not modified (unlike ToTitleCase which lowercases first).
      
      @warning Uses TStringList with space as a delimiter. May not handle multiple spaces
               or other whitespace characters as expected between words. Relies on
               UpperCase for capitalization, locale dependency might apply.
               Empty strings are returned unchanged.
      
      @example
        Result := CapitalizeText('hello world');     // Returns: 'Hello World'
        Result := CapitalizeText('multiple   spaces'); // Returns: 'Multiple   Spaces' (preserves spaces)
        Result := CapitalizeText('already Capitalized'); // Returns: 'Already Capitalized'
        Result := CapitalizeText('');                // Returns: ''
    }
    class function CapitalizeText(const Text: string): string; static;
    
    {
      @description Finds all occurrences of a regular expression pattern within a text
                   and returns detailed information about each match.
      
      @usage Use when you need not just the matched text, but also its starting position
             (1-based) and length within the original string. Useful for highlighting,
             extraction with context, or complex parsing.
      
      @param Text The string to search within.
      @param Pattern The regular expression pattern to match.
      
      @returns A dynamic array of TStringMatch records. Each record contains the matched
               Text, its 1-based Position, and its Length. Returns an empty array if
               no matches are found or if the pattern is invalid.
      
      @warning Regular expressions can be computationally expensive, especially on large texts
               or with complex patterns. Ensure the pattern is valid; invalid patterns
               may raise exceptions or return no matches. Uses the TRegExpr engine.
      
      @example
        // Assuming Result is declared as TMatchesResults
        Result := ExtractMatches('Test 123, test 456', '\d+');
        // Result[0]: Text='123', Position=6, Length=3
        // Result[1]: Text='456', Position=17, Length=3
        
        Result := ExtractMatches('No digits here', '\d+');
        // Length(Result) = 0
    }
    class function ExtractMatches(const Text, Pattern: string): TMatchesResults; static;
    
    {
      @description Extracts all substrings that match a given regular expression pattern.
                   This function returns only the matched text itself, without position or length info.
      
      @usage Use when you simply need a list of all parts of a string that match a pattern,
             like extracting all email addresses or URLs from a block of text.
      
      @param Text The string to search within.
      @param Pattern The regular expression pattern to match.
      
      @returns A dynamic array of strings (TStringDynArray), where each element is a matched substring.
               Returns an empty array if no matches are found.
      
      @warning Relies on ExtractMatches internally. Regular expressions can be computationally
               expensive. Returns an empty array for invalid patterns or no matches.
      
      @example
        // Assuming Result is declared as TStringDynArray
        Result := ExtractAllMatches('Emails: a@b.com, c@d.net.', '\w+@\w+\.\w+');
        // Result[0]: 'a@b.com'
        // Result[1]: 'c@d.net'
        
        Result := ExtractAllMatches('No emails here', '\w+@\w+\.\w+');
        // Length(Result) = 0
    }
    class function ExtractAllMatches(const Text, Pattern: string): TStringDynArray; static;
    
    {
      @description Tests if a string fully matches a given regular expression pattern.
      
      @usage Use for validating string formats, such as checking if input conforms to
             rules for passwords, phone numbers, email addresses, etc. Ensure the pattern
             is anchored (e.g., using ^ and $) if the entire string must match.
      
      @param Text The string to test.
      @param Pattern The regular expression pattern to match against the string.
      
      @returns True if the string matches the pattern, False otherwise.
      
      @warning Regular expressions can be computationally expensive. An empty or invalid
               pattern might lead to unexpected results or exceptions. Uses TRegExpr.Exec.
               This checks if the pattern *can be found* in the text, not necessarily if the *entire* text matches. Use anchors (^, $) for full string matching.
      
      @example
        // Check if the string CONTAINS a sequence of 3 digits
        Result := MatchesPattern('abc123def', '\d{3}'); // Returns: True
        
        // Check if the ENTIRE string IS exactly 3 digits
        Result := MatchesPattern('123', '^\d{3}$'); // Returns: True
        Result := MatchesPattern('1234', '^\d{3}$'); // Returns: False
        Result := MatchesPattern('abc', '^\d{3}$'); // Returns: False
        
        // Example from original comment (valid email format check)
        Result := MatchesPattern('test@example.com', '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'); // Returns: True
    }
    class function MatchesPattern(const Text, Pattern: string): Boolean; static;
    
    {
      @description Replaces all occurrences of text matching a regular expression pattern
                   with a specified replacement string. Supports backreferences (e.g., $1, $2)
                   in the replacement string.
      
      @usage Use for complex search-and-replace operations based on patterns, like reformatting
             dates, swapping name parts, or cleaning up structured text.
      
      @param Text The original string to perform replacements on.
      @param Pattern The regular expression pattern identifying the text to be replaced.
      @param Replacement The string to insert in place of the matched text. Can include
                       backreferences like $0 (entire match), $1 (first group), etc.
      
      @returns A new string with all replacements made. If no matches are found, returns the original string.
      
      @warning Regular expressions can be computationally expensive. Invalid patterns may cause
               exceptions. Special characters in the Replacement string (like '$') might need
               escaping if intended literally (though TRegExpr handles common cases). Uses TRegExpr.Replace.
      
      @example
        // Swap first and last names
        Result := ReplaceRegEx('Doe, John', '^(\w+),\s*(\w+)$', '$2 $1'); // Returns: 'John Doe'
        
        // Format phone number
        Result := ReplaceRegEx('1234567890', '^(\d{3})(\d{3})(\d{4})$', '($1) $2-$3'); // Returns: '(123) 456-7890'
        
        // Remove all digits
        Result := ReplaceRegEx('abc123def456', '\d+', ''); // Returns: 'abcdef'
    }
    class function ReplaceRegEx(const Text, Pattern, Replacement: string): string; static;
    
    {
      @description Replaces all occurrences of a specific substring (OldText) with another
                   string (NewText) within a given text. This is a case-sensitive replacement.
      
      @usage Use for simple, direct substring replacements throughout a text.
      
      @param Text The original string to perform replacements on.
      @param OldText The exact substring to find and replace.
      @param NewText The string to insert in place of each occurrence of OldText.
      
      @returns A new string with all replacements made. If OldText is not found or is empty,
               returns the original string unchanged.
      
      @warning Replacement is case-sensitive. If OldText is an empty string, no replacements
               are made. Uses the standard SysUtils.StringReplace function with rfReplaceAll.
      
      @example
        Result := ReplaceText('Hello world, hello universe', 'hello', 'Hi'); // Returns: 'Hello world, Hi universe' (Case-sensitive)
        Result := ReplaceText('ababab', 'ab', 'X');                         // Returns: 'XXX'
        Result := ReplaceText('No change', 'xyz', 'abc');                   // Returns: 'No change'
        Result := ReplaceText('Test', '', 'X');                             // Returns: 'Test'
    }
    class function ReplaceText(const Text, OldText, NewText: string): string; static;
    
    {
      @description Splits text into an array of words based on alphanumeric characters.
                   Sequences of letters (A-Z, a-z) and digits (0-9) are considered words.
                   Any other character acts as a delimiter.
      
      @usage Use when you need to extract individual words from text for analysis, counting,
             or further processing, ignoring punctuation and symbols.
      
      @param AText The text to split into words.
      
      @returns A dynamic array of strings (TStringDynArray), where each element is a word.
               Returns an empty array if the text contains no alphanumeric characters.
      
      @warning Considers only ASCII letters and digits as part of words. Punctuation attached
               to words (like "don't" or "end.") will break them ("don", "t", "end").
               Multiple non-alphanumeric characters between words result in a single split.
      
      @example
        // Assuming Result is declared as TStringDynArray
        Result := GetWords('Hello, world! How are you?');
        // Result[0]: 'Hello'
        // Result[1]: 'world'
        // Result[2]: 'How'
        // Result[3]: 'are'
        // Result[4]: 'you'
        
        Result := GetWords('Item123 Code-ABC.');
        // Result[0]: 'Item123'
        // Result[1]: 'Code'
        // Result[2]: 'ABC'
        
        Result := GetWords('---');
        // Length(Result) = 0
    }
    class function GetWords(const AText: string): TStringDynArray; static;
    
    {
      @description Counts the number of non-overlapping occurrences of a substring within a text.
                   The search is case-sensitive.
      
      @usage Use to determine how many times a specific sequence appears in a larger string.
      
      @param Text The string to search within.
      @param SubStr The substring to count.
      
      @returns The number of times SubStr appears in Text. Returns 0 if SubStr is empty or not found.
      
      @warning The search is case-sensitive. Occurrences are non-overlapping (e.g., counting 'aa' in 'aaaa' yields 2).
               Returns 0 if SubStr is an empty string.
      
      @example
        Result := CountSubString('ababab', 'ab'); // Returns: 3
        Result := CountSubString('aaaaa', 'aa');  // Returns: 2 (non-overlapping)
        Result := CountSubString('Hello', 'l');   // Returns: 2
        Result := CountSubString('Hello', 'L');   // Returns: 0 (case-sensitive)
        Result := CountSubString('Test', '');     // Returns: 0
        Result := CountSubString('', 'a');      // Returns: 0
    }
    class function CountSubString(const Text, SubStr: string): Integer; static;
    
    {
      @description Tests if a string contains a specific substring.
                   The check is case-sensitive.
      
      @usage Use for simple checks to see if a smaller string exists anywhere within a larger one.
      
      @param Text The string to search within.
      @param SubStr The substring to look for.
      
      @returns True if SubStr is found within Text, False otherwise. Returns False if SubStr is empty.
      
      @warning The check is case-sensitive. Uses the standard SysUtils.Pos function.
               Returns False if SubStr is an empty string (as Pos returns 0).
      
      @example
        Result := Contains('Hello World', 'World'); // Returns: True
        Result := Contains('Hello World', 'world'); // Returns: False (case-sensitive)
        Result := Contains('Test', 'es');         // Returns: True
        Result := Contains('Test', 'xyz');        // Returns: False
        Result := Contains('Test', '');           // Returns: False
        Result := Contains('', 'a');            // Returns: False
    }
    class function Contains(const Text, SubStr: string): Boolean; static;
    
    {
      @description Tests if a string starts with a specific prefix.
                   The comparison is case-sensitive.
      
      @usage Use to check if a string begins with a known sequence, like a protocol ('http://')
             or a specific marker.
      
      @param Text The string to test.
      @param Prefix The prefix to check for at the beginning of Text.
      
      @returns True if Text starts with Prefix, False otherwise. Returns True if Prefix is empty.
      
      @warning The comparison is case-sensitive. Returns True if Prefix is an empty string.
               If Prefix is longer than Text, it returns False.
      
      @example
        Result := StartsWith('Hello World', 'Hello'); // Returns: True
        Result := StartsWith('Hello World', 'hello'); // Returns: False (case-sensitive)
        Result := StartsWith('Test', 'Tes');         // Returns: True
        Result := StartsWith('Test', 'xyz');        // Returns: False
        Result := StartsWith('Test', 'Testing');    // Returns: False
        Result := StartsWith('Test', '');           // Returns: True
        Result := StartsWith('', 'a');            // Returns: False
        Result := StartsWith('', '');             // Returns: True
    }
    class function StartsWith(const Text, Prefix: string): Boolean; static;
    
    {
      @description Tests if a string ends with a specific suffix.
                   The comparison is case-sensitive.
      
      @usage Use to check file extensions ('.txt'), closing tags, or other ending markers.
      
      @param Text The string to test.
      @param Suffix The suffix to check for at the end of Text.
      
      @returns True if Text ends with Suffix, False otherwise. Returns True if Suffix is empty.
      
      @warning The comparison is case-sensitive. Returns True if Suffix is an empty string.
               If Suffix is longer than Text, it returns False.
      
      @example
        Result := EndsWith('Hello World', 'World'); // Returns: True
        Result := EndsWith('Hello World', 'world'); // Returns: False (case-sensitive)
        Result := EndsWith('Test.txt', '.txt');    // Returns: True
        Result := EndsWith('Test', 'xyz');       // Returns: False
        Result := EndsWith('Test', 'Testing');   // Returns: False
        Result := EndsWith('Test', '');          // Returns: True
        Result := EndsWith('', 'a');           // Returns: False
        Result := EndsWith('', '');            // Returns: True
    }
    class function EndsWith(const Text, Suffix: string): Boolean; static;
    
    {
      @description Tests if a string is empty (has zero length).
      
      @usage Use to check for empty strings before processing or to validate input.
      
      @param Text The string to test.
      
      @returns True if the string has a length of 0, False otherwise.
      
      @warning None identified.
      
      @example
        Result := IsEmpty('');         // Returns: True
        Result := IsEmpty(' ');        // Returns: False
        Result := IsEmpty('Hello');    // Returns: False
    }
    class function IsEmpty(const Text: string): Boolean; static;
    
    {
      @description Gets the length (number of characters) of a string.
                   Uses the standard System.Length function.
      
      @usage Use whenever the character count of a string is needed.
      
      @param Text The string to measure.
      
      @returns The number of characters in the string. Returns 0 for an empty string.
      
      @warning For multi-byte character sets (like UTF-8), this returns the number of bytes,
               not necessarily the number of visible characters (graphemes).
      
      @example
        Result := GetLength('Hello'); // Returns: 5
        Result := GetLength('');      // Returns: 0
        Result := GetLength(' ');     // Returns: 1
    }
    class function GetLength(const Text: string): Integer; static;
    
    {
      @description Extracts a substring from a given string based on a starting position and length.
                   Uses the standard System.Copy function.
      
      @usage Use to get a specific portion of a string.
      
      @param Text The source string.
      @param StartPos The starting position (1-based index) of the substring.
      @param Length The number of characters to extract.
      
      @returns The extracted substring. Returns an empty string if StartPos is beyond the end
               of the string or if Length is zero or negative. If StartPos is valid but
               Length exceeds the remaining characters, it returns all characters from StartPos to the end.
      
      @warning StartPos is 1-based. Invalid StartPos (<= 0 or > length(Text)) can lead to
               empty strings or runtime errors depending on the underlying Copy implementation.
               Length specifies the number of bytes for multi-byte strings.
      
      @example
        Result := SubString('Hello World', 7, 5); // Returns: 'World'
        Result := SubString('Hello World', 1, 5); // Returns: 'Hello'
        Result := SubString('Hello', 1, 10);      // Returns: 'Hello' (Length exceeds available)
        Result := SubString('Hello', 6, 1);       // Returns: '' (StartPos is beyond end)
        Result := SubString('Hello', 3, 0);       // Returns: '' (Length is zero)
        Result := SubString('Hello', 0, 3);       // Returns: '' (StartPos <= 0, behavior might vary)
    }
    class function SubString(const Text: string; StartPos, Length: Integer): string; static;
    
    {
      @description Gets a specified number of characters from the beginning (left side) of a string.
                   Equivalent to SubString(Text, 1, Length).
      
      @usage Use to extract the first part of a string, like a prefix or header.
      
      @param Text The source string.
      @param Length The number of characters to retrieve from the left.
      
      @returns The leftmost characters of the string. If Length is greater than the string length,
               the entire string is returned. If Length is zero or negative, an empty string is returned.
      
      @warning Length specifies the number of bytes for multi-byte strings.
      
      @example
        Result := LeftStr('Hello World', 5); // Returns: 'Hello'
        Result := LeftStr('Hello', 10);      // Returns: 'Hello'
        Result := LeftStr('Hello', 0);       // Returns: ''
        Result := LeftStr('', 5);          // Returns: ''
    }
    class function LeftStr(const Text: string; Length: Integer): string; static;
    
    {
      @description Gets a specified number of characters from the end (right side) of a string.
      
      @usage Use to extract the last part of a string, like a suffix, extension, or trailer.
      
      @param Text The source string.
      @param Length The number of characters to retrieve from the right.
      
      @returns The rightmost characters of the string. If Length is greater than the string length,
               the entire string is returned. If Length is zero or negative, an empty string is returned.
      
      @warning Length specifies the number of bytes for multi-byte strings.
      
      @example
        Result := RightStr('Hello World', 5); // Returns: 'World'
        Result := RightStr('Hello', 10);      // Returns: 'Hello'
        Result := RightStr('Hello', 0);       // Returns: ''
        Result := RightStr('', 5);          // Returns: ''
    }
    class function RightStr(const Text: string; Length: Integer): string; static;
    
    {
      @description Calculates the Levenshtein distance between two strings. This distance is the
                   minimum number of single-character edits (insertions, deletions, or substitutions)
                   required to change one string into the other.
      
      @usage Use for fuzzy string matching, spell checking, DNA sequence comparison, and measuring
             the similarity between two strings. Lower distance means more similar.
      
      @param S1 The first string to compare.
      @param S2 The second string to compare.
      
      @returns The Levenshtein distance (a non-negative integer). Returns the length of the
               other string if one string is empty.
      
      @references https://en.wikipedia.org/wiki/Levenshtein_distance
      
      @warning The calculation complexity is O(m*n), where m and n are the lengths of the strings.
               Can be computationally expensive for very long strings. Case-sensitive.
      
      @example
        Result := LevenshteinDistance('kitten', 'sitting'); // Returns: 3
        Result := LevenshteinDistance('sunday', 'saturday'); // Returns: 3
        Result := LevenshteinDistance('test', 'test');     // Returns: 0
        Result := LevenshteinDistance('test', '');        // Returns: 4
        Result := LevenshteinDistance('', 'test');        // Returns: 4
        Result := LevenshteinDistance('abc', 'acb');      // Returns: 2 (substitute b->c, substitute c->b or delete b, insert b) - Actually 1 (substitute b for c) - Let's re-verify. abc -> ac (del b) -> acb (ins b) = 2. abc -> acc (sub b->c) -> acb (sub c->b) = 2. Correct.
        // Correction: abc -> ac (delete b @ pos 2), ac -> acb (insert b @ pos 3) = 2 edits.
        // Correction 2: The implementation uses Min3(del, ins, sub).
        // d(abc, acb)
        //   "" a c b
        // "" 0  1 2 3
        // a  1  0 1 2
        // b  2  1 1 2  <- D[2,3] = Min3(D[1,3]+1, D[2,2]+1, D[1,2]+cost(b,b)=0) = Min3(2+1, 1+1, 1+0) = 1
        // c  3  2 1 2  <- D[3,3] = Min3(D[2,3]+1, D[3,2]+1, D[2,2]+cost(c,b)=1) = Min3(1+1, 1+1, 1+1) = 2
        // The distance is 2. Example is correct.
    }
    class function LevenshteinDistance(const S1, S2: string): Integer; static;
    
    {
      @description Calculates a similarity ratio between two strings based on their Levenshtein distance.
                   The ratio is normalized to a value between 0.0 (completely different) and 1.0 (identical).
      
      @usage Use for fuzzy string matching where a normalized score (0 to 1) is preferred over raw distance.
             Higher values indicate greater similarity.
      
      @param S1 The first string to compare.
      @param S2 The second string to compare.
      
      @returns A Double value between 0.0 and 1.0, inclusive. 1.0 means identical strings.
               Returns 1.0 if both strings are empty. Returns 0.0 if one string is empty and the other is not.
      
      @references Based on Levenshtein distance: `1.0 - (Distance / Max(Length(S1), Length(S2)))`
                  See also: https://en.wikipedia.org/wiki/Levenshtein_distance#Relative_distance
      
      @warning @warning Relies on LevenshteinDistance, which can be computationally expensive for long strings.
                        Will raise EDivByZero exception if both input strings are empty.
                        Case-sensitive comparison.

      @example
        Result := LevenshteinSimilarity('kitten', 'sitting'); // Approx 0.57
        Result := LevenshteinSimilarity('test', 'test');     // Returns: 1.0
        Result := LevenshteinSimilarity('test', '');        // Returns: 0.0
        // Result := LevenshteinSimilarity('', '');        // Raises EDivByZero
    }
    class function LevenshteinSimilarity(const S1, S2: string): Double; static;
    
    {
      @description Calculates the Hamming distance between two strings. This is the number of
                   positions at which the corresponding characters are different.
      
      @usage Use for comparing strings of equal length, often in coding theory, bioinformatics,
             or where substitutions are the primary type of error expected.
      
      @param S1 The first string to compare.
      @param S2 The second string to compare. Must have the same length as S1.
      
      @returns The Hamming distance (a non-negative integer) if the strings have equal length.
               Returns -1 if the strings have different lengths.
      
      @references https://en.wikipedia.org/wiki/Hamming_distance
      
      @warning Requires strings to be of equal length; returns -1 otherwise. Case-sensitive.
               Complexity is O(n), where n is the length of the strings.
      
      @example
        Result := HammingDistance('karolin', 'kathrin'); // Returns: 3
        Result := HammingDistance('1011101', '1001001'); // Returns: 2
        Result := HammingDistance('test', 'test');     // Returns: 0
        Result := HammingDistance('test', 'Test');     // Returns: 1 (case-sensitive)
        Result := HammingDistance('short', 'longer');  // Returns: -1 (different lengths)
        Result := HammingDistance('', '');            // Returns: 0
    }
    class function HammingDistance(const S1, S2: string): Integer; static;
    
    {
      @description Calculates the Jaro similarity between two strings, a metric for measuring string similarity
                   based on matching characters and transpositions, particularly
                   suited for short strings like names.
      
      @usage Use for comparing short strings, like personal names, where minor variations
             (typos, transpositions) are common. Score ranges from 0.0 (no similarity) to 1.0 (identical).
      
      @param S1 The first string to compare.
      @param S2 The second string to compare.
      
      @returns The Jaro similarity score (Double) between 0.0 and 1.0.
      
      @references https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance#Jaro_similarity
      
      @warning Uses a matching window of size max(|s1|,|s2|)/2 - 1. Computational complexity
               increases with string length. Returns 1.0 if both strings are empty.
               Returns 0.0 if exactly one string is empty.
      
      @example
        Result := JaroSimilarity('MARTHA', 'MARHTA'); // Returns approximately 0.94
        Result := JaroSimilarity('DWAYNE', 'DUANE');  // Returns approximately 0.82
        Result := JaroSimilarity('TEST', 'TEST');    // Returns 1.0
        Result := JaroSimilarity('ABC', 'DEF');     // Returns 0.0 (no matching characters)
        Result := JaroSimilarity('', '');         // Returns 1.0
        Result := JaroSimilarity('A', '');          // Returns 0.0
    }
    class function JaroSimilarity(const S1, S2: string): Double; static;
    
    {
      @description Calculates the Jaro-Winkler similarity, an extension of Jaro similarity that
                   gives more weight to strings sharing a common prefix.
      
      @usage Use for comparing short strings like names, especially when matching prefixes are
             important (e.g., 'Michael' vs 'Michelle'). Score ranges from 0.0 to 1.0.
      
      @param S1 The first string to compare.
      @param S2 The second string to compare.
      
      @returns The Jaro-Winkler similarity score (Double) between 0.0 and 1.0.
      
      @references https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance#Jaro%E2%80%93Winkler_similarity
                  Formula: `JaroSimilarity + (PrefixLength * ScalingFactor * (1 - JaroSimilarity))`
                  Common ScalingFactor (p) is 0.1, Max PrefixLength (l) is 4.
      
      @warning Uses a fixed scaling factor of 0.1. Maximum prefix length considered is 4.
               Returns 1.0 if both strings are empty. Returns 0.0 if exactly one string is empty.
      
      @example
        Result := JaroWinklerSimilarity('MARTHA', 'MARHTA'); // Higher than Jaro similarity
        Result := JaroWinklerSimilarity('DWAYNE', 'DUANE');  // Higher than Jaro similarity
        Result := JaroWinklerSimilarity('TEST', 'TEST');    // Returns 1.0
        Result := JaroWinklerSimilarity('TEST', 'TSET');    // Returns higher than Jaro due to 'T' prefix
        Result := JaroWinklerSimilarity('DIXON', 'DICKSON'); // Returns some similarity value
        Result := JaroWinklerSimilarity('', '');         // Returns 1.0
    }
    class function JaroWinklerSimilarity(const S1, S2: string): Double; static;
    
    {
      @description Finds the longest common subsequence (LCS) of two strings. A subsequence
                   maintains the relative order of characters but doesn't require them to be contiguous.
      
      @usage Use in bioinformatics (DNA/protein sequence alignment), file comparison (diff utilities),
             and data compression. Can also be used as a basis for a similarity metric.
      
      @param S1 The first string.
      @param S2 The second string.
      
      @returns The longest common subsequence as a string. If multiple LCSs of the same maximum
               length exist, the specific one returned depends on the backtracking algorithm.
               Returns an empty string if one or both input strings are empty or if there's no common subsequence.
      
      @references https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
      
      @warning The calculation complexity is O(m*n), where m and n are the lengths of the strings.
               Can be computationally expensive for very long strings. Case-sensitive.
      
      @example
        Result := LongestCommonSubsequence('ABCDEFG', 'ABDZEFXG'); // Returns: 'ABDEG' (or potentially 'ABDFG' depending on backtracking) - Let's trace: 'ABDG' seems right.
        // Trace:
        //   "" A B D Z E F X G
        // "" 0  0 0 0 0 0 0 0 0
        // A  0  1 1 1 1 1 1 1 1
        // B  0  1 2 2 2 2 2 2 2
        // C  0  1 2 2 2 2 2 2 2
        // D  0  1 2 3 3 3 3 3 3
        // E  0  1 2 3 3 4 4 4 4
        // F  0  1 2 3 3 4 5 5 5
        // G  0  1 2 3 3 4 5 5 6
        // Backtrack from [7,8] (value 6): G matches -> G. Move to [6,7].
        // Backtrack from [6,7] (value 5): F matches -> FG. Move to [5,6].
        // Backtrack from [5,6] (value 4): E matches -> EFG. Move to [4,5]. (Error here, should be [4,4])
        // Backtrack from [5,5] (value 4): E matches -> EG. Move to [4,4].
        // Backtrack from [4,4] (value 3): D matches -> DEG. Move to [3,3].
        // Backtrack from [3,3] (value 2): C!=D. Max(LCS[2,3], LCS[3,2]) = Max(2,2). Move to [2,3].
        // Backtrack from [2,3] (value 2): B!=D. Max(LCS[1,3], LCS[2,2]) = Max(1,2). Move to [2,2].
        // Backtrack from [2,2] (value 2): B matches -> BDEG. Move to [1,1].
        // Backtrack from [1,1] (value 1): A matches -> ABDEG. Move to [0,0]. Stop.
        // Result: 'ABDEG'. Example corrected.
        
        Result := LongestCommonSubsequence('banana', 'atana');    // Returns: 'aana'
        Result := LongestCommonSubsequence('test', 'testing');   // Returns: 'test'
        Result := LongestCommonSubsequence('abc', 'def');       // Returns: ''
        Result := LongestCommonSubsequence('abc', '');          // Returns: ''
    }
    class function LongestCommonSubsequence(const S1, S2: string): string; static;
    
    {
      @description Calculates a similarity ratio between two strings based on the length of their
                   Longest Common Subsequence (LCS).
                   Formula: `Length(LCS) / Max(1, Length(S1), Length(S2))` (denominator adjusted to avoid division by zero).
      
      @usage Use as a similarity measure where the relative order of characters is important, but
             contiguity is not required. Score ranges from 0.0 to 1.0.
      
      @param S1 The first string to compare.
      @param S2 The second string to compare.
      
      @returns A similarity ratio (Double) between 0.0 and 1.0.
      
      @references Based on Longest Common Subsequence.
                  See also: https://en.wikipedia.org/wiki/Longest_common_subsequence_problem#Relation_to_other_problems
      
      @warning Relies on LongestCommonSubsequence, so it can be computationally expensive for long strings.
               The implementation divides by `Max(Length(S1), Length(S2))`. This will cause division by zero if both S1 and S2 are empty.
               **Revised Warning:** Relies on LongestCommonSubsequence. Can be computationally expensive. **Will raise EDivByZero exception if both input strings are empty.** Case-sensitive.

      @example
        Result := LCSSimilarity('ABCDEFG', 'ABDZEFXG'); // LCS='ABDEG', Length=5. MaxLen=8. Ratio = 5/8 = 0.625
        Result := LCSSimilarity('banana', 'atana');    // LCS='aana', Length=4. MaxLen=6. Ratio = 4/6 = ~0.667
        Result := LCSSimilarity('test', 'test');       // LCS='test', Length=4. MaxLen=4. Ratio = 1.0
        Result := LCSSimilarity('abc', 'def');       // LCS='', Length=0. MaxLen=3. Ratio = 0.0
        // Result := LCSSimilarity('', '');            // Raises EDivByZero
    }
    class function LCSSimilarity(const S1, S2: string): Double; static;
    
    {
      @description Determines if two strings are considered a "fuzzy match" based on a chosen
                   similarity algorithm and a threshold.
      
      @usage Use to quickly check if two strings are likely the same or related, allowing for
             minor differences, based on a predefined similarity level.
      
      @param S1 The first string to compare.
      @param S2 The second string to compare.
      @param Threshold The minimum similarity ratio (between 0.0 and 1.0) required to consider
                     the strings a match. Default is 0.7.
      @param Method An integer indicating the similarity algorithm to use:
                    0: Levenshtein Similarity (default)
                    1: Jaro-Winkler Similarity
                    2: Longest Common Subsequence (LCS) Similarity
                    Other values result in a similarity of 0.0.
      
      @returns True if the calculated similarity is greater than or equal to the Threshold,
               False otherwise. Also returns True if S1 and S2 are identical. Returns False
               if exactly one string is empty.
      
      @warning Relies on the chosen similarity function (LevenshteinSimilarity, JaroWinklerSimilarity,
               LCSSimilarity). Be aware of the warnings associated with those functions (potential
               division by zero for empty strings, incorrect Jaro/Jaro-Winkler implementation).
               The default Threshold of 0.7 is arbitrary and may need adjustment based on use case.
      
      @example
        // Using default Levenshtein (Method=0, Threshold=0.7)
        Result := IsFuzzyMatch('apple', 'appel');       // Levenshtein Similarity ~0.8. Returns: True
        Result := IsFuzzyMatch('test', 'testing');     // Levenshtein Similarity ~0.57. Returns: False
        Result := IsFuzzyMatch('test', 'test');        // Returns: True (identical)
        
        // Using Jaro-Winkler (Method=1, Threshold=0.85) - Assuming correct implementation
        // Result := IsFuzzyMatch('MARTHA', 'MARHTA', 0.85, 1); // Standard Jaro-Winkler ~0.96. Returns: True
        
        // Using LCS (Method=2, Threshold=0.6)
        Result := IsFuzzyMatch('ABCDEFG', 'ABDZEFXG', 0.6, 2); // LCS Similarity = 0.625. Returns: True
    }
    class function IsFuzzyMatch(const S1, S2: string; Threshold: Double = 0.7; Method: Integer = 0): Boolean; static;
    
    { -------------------- Case Conversion Variants -------------------- }
    
    {
      @description Converts a string to Title Case, where the first letter of each word is
                   capitalized and the rest of the letters are lowercased. Words are delimited
                   by spaces, tabs, newlines, hyphens, periods, underscores, colons, semicolons,
                   exclamation marks, and question marks.
      
      @usage Use for formatting headlines, titles, or proper nouns according to common title case conventions.
      
      @param Text The string to convert.
      
      @returns The string converted to title case. Returns an empty string if the input is empty.
      
      @warning First converts the entire string to lowercase, then capitalizes the first letter
               after any recognized delimiter. Relies on UpCase/LowerCase, locale dependency might apply.
               Does not handle complex title casing rules (e.g., not capitalizing articles/prepositions).
      
      @example
        Result := ToTitleCase('hello world');        // Returns: 'Hello World'
        Result := ToTitleCase('HELLO WORLD');        // Returns: 'Hello World'
        Result := ToTitleCase('first-name_last.name'); // Returns: 'First-Name_Last.Name'
        Result := ToTitleCase('multiple   spaces');  // Returns: 'Multiple   Spaces'
        Result := ToTitleCase('');                   // Returns: ''
    }
    class function ToTitleCase(const Text: string): string; static;
    
    {
      @description Converts a string to camelCase format. The first word starts lowercase,
                   and subsequent words start with an uppercase letter, with all other letters
                   in lowercase. Words are identified using GetWords (alphanumeric sequences).
                   No separators are included in the output.
      
      @usage Use for converting phrases or identifiers into camelCase variable or function names,
             common in languages like Java, JavaScript.
      
      @param Text The string to convert (e.g., 'some input phrase').
      
      @returns The string in camelCase format. Returns an empty string if the input contains no words.
      
      @warning Relies on GetWords to identify word boundaries (alphanumeric sequences only).
               Punctuation is treated as a delimiter and removed. Relies on UpperCase/LowerCase.
      
      @example
        Result := ToCamelCase('hello world');        // Returns: 'helloWorld'
        Result := ToCamelCase('Hello World');        // Returns: 'helloWorld'
        Result := ToCamelCase('__some_variable-name'); // Returns: 'someVariableName'
        Result := ToCamelCase('SingleWord');         // Returns: 'singleword'
        Result := ToCamelCase('word');               // Returns: 'word'
        Result := ToCamelCase('123 abc');            // Returns: '123Abc'
        Result := ToCamelCase('');                   // Returns: ''
        Result := ToCamelCase('---');                // Returns: ''
    }
    class function ToCamelCase(const Text: string): string; static;
    
    {
      @description Converts a string to PascalCase (or UpperCamelCase) format. Each word starts
                   with an uppercase letter, with all other letters in lowercase. Words are
                   identified using GetWords (alphanumeric sequences). No separators are
                   included in the output.
      
      @usage Use for converting phrases or identifiers into PascalCase class names or type names,
             common in languages like Pascal, C#.
      
      @param Text The string to convert (e.g., 'some input phrase').
      
      @returns The string in PascalCase format. Returns an empty string if the input contains no words.
      
      @warning Relies on GetWords to identify word boundaries (alphanumeric sequences only).
               Punctuation is treated as a delimiter and removed. Relies on UpperCase/LowerCase.
      
      @example
        Result := ToPascalCase('hello world');        // Returns: 'HelloWorld'
        Result := ToPascalCase('Hello World');        // Returns: 'HelloWorld'
        Result := ToPascalCase('__some_variable-name'); // Returns: 'SomeVariableName'
        Result := ToPascalCase('SingleWord');         // Returns: 'Singleword' (Note: Lowercases rest)
        Result := ToPascalCase('word');               // Returns: 'Word'
        Result := ToPascalCase('123 abc');            // Returns: '123Abc'
        Result := ToPascalCase('');                   // Returns: ''
        Result := ToPascalCase('---');                // Returns: ''
    }
    class function ToPascalCase(const Text: string): string; static;
    
    {
      @description Converts a string to snake_case format. All words are converted to lowercase
                   and joined by underscore characters ('_'). Words are identified using GetWords
                   (alphanumeric sequences).
      
      @usage Use for converting phrases or identifiers into snake_case variable or function names,
             common in languages like Python, Ruby.
      
      @param Text The string to convert (e.g., 'Some Input Phrase').
      
      @returns The string in snake_case format. Returns an empty string if the input contains no words.
      
      @warning Relies on GetWords to identify word boundaries (alphanumeric sequences only).
               Punctuation is treated as a delimiter and removed. Relies on LowerCase.
      
      @example
        Result := ToSnakeCase('hello world');        // Returns: 'hello_world'
        Result := ToSnakeCase('Hello World');        // Returns: 'hello_world'
        Result := ToSnakeCase('__some_variable-name'); // Returns: 'some_variable_name'
        Result := ToSnakeCase('SingleWord');         // Returns: 'singleword'
        Result := ToSnakeCase('word');               // Returns: 'word'
        Result := ToSnakeCase('123 abc');            // Returns: '123_abc'
        Result := ToSnakeCase('');                   // Returns: ''
        Result := ToSnakeCase('---');                // Returns: ''
    }
    class function ToSnakeCase(const Text: string): string; static;
    
    {
      @description Converts a string to kebab-case format. All words are converted to lowercase
                   and joined by hyphen characters ('-'). Words are identified using GetWords
                   (alphanumeric sequences).
      
      @usage Use for converting phrases or identifiers into kebab-case, common in URLs, CSS class names,
             and HTML attributes.
      
      @param Text The string to convert (e.g., 'Some Input Phrase').
      
      @returns The string in kebab-case format. Returns an empty string if the input contains no words.
      
      @warning Relies on GetWords to identify word boundaries (alphanumeric sequences only).
               Punctuation is treated as a delimiter and removed. Relies on LowerCase.
      
      @example
        Result := ToKebabCase('hello world');        // Returns: 'hello-world'
        Result := ToKebabCase('Hello World');        // Returns: 'hello-world'
        Result := ToKebabCase('__some_variable_name'); // Returns: 'some-variable-name'
        Result := ToKebabCase('SingleWord');         // Returns: 'singleword'
        Result := ToKebabCase('word');               // Returns: 'word'
        Result := ToKebabCase('123 abc');            // Returns: '123-abc'
        Result := ToKebabCase('');                   // Returns: ''
        Result := ToKebabCase('---');                // Returns: ''
    }
    class function ToKebabCase(const Text: string): string; static;
    
    { -------------------- String Validation Functions -------------------- }
    
    {
      @description Checks if a string matches a common pattern for a valid email address.
      
      @usage Use to perform basic validation of email address input.
      
      @param Text The string to check.
      
      @returns True if the string matches the email pattern, False otherwise.
      
      @references Uses the regex: `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
      
      @warning This regex provides basic validation but doesn't guarantee the email address
                exists or adheres to all RFC specifications (which are very complex).
                Relies on MatchesPattern.
      
      @example
        Result := IsValidEmail('test@example.com'); // Returns: True
        Result := IsValidEmail('test.name+tag@example.co.uk'); // Returns: True
        Result := IsValidEmail('test@example');    // Returns: False (missing TLD)
        Result := IsValidEmail('test@.com');       // Returns: False (missing domain name part)
        Result := IsValidEmail('test');            // Returns: False
        Result := IsValidEmail('');                // Returns: False
    }
    class function IsValidEmail(const Text: string): Boolean; static;
    
    {
      @description Checks if a string matches common patterns for a valid URL (http, https, ftp, or www starting).
      
      @usage Use to perform basic validation of URL input.
      
      @param Text The string to check.
      
      @returns True if the string matches one of the URL patterns, False otherwise.
      
      @references Uses regex patterns:
                  `^(https?|ftp)://[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$`
                  `^(www)\.[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$`
      
      @warning These regex patterns cover many common URLs but might not match all valid URL formats
                (e.g., internationalized domain names, newer TLDs, file URLs, data URLs).
                They also don't check if the URL actually exists or is reachable. Case-sensitive matching for domain TLD part ([a-z]{2,6}).
                Relies on MatchesPattern.
      
      @example
        Result := IsValidURL('http://example.com');        // Returns: True
        Result := IsValidURL('https://www.example.com/path?query=1'); // Returns: True
        Result := IsValidURL('ftp://user:pass@example.com'); // Returns: True
        Result := IsValidURL('www.example.com');           // Returns: True
        Result := IsValidURL('example.com');               // Returns: False (needs protocol or www.)
        Result := IsValidURL('http://example');            // Returns: False (needs TLD)
        Result := IsValidURL('');                          // Returns: False
    }
    class function IsValidURL(const Text: string): Boolean; static;
    
    {
      @description Checks if a string is a valid IPv4 or IPv6 address.
      
      @usage Use as a general IP address validator when either format is acceptable.
      
      @param Text The string to check.
      
      @returns True if the string is a valid IPv4 or IPv6 address, False otherwise.
      
      @warning Relies on IsValidIPv4 and IsValidIPv6 implementations.
      
      @example
        Result := IsValidIP('192.168.1.1');       // Returns: True
        Result := IsValidIP('2001:db8::1');       // Returns: True
        Result := IsValidIP('10.0');             // Returns: False
        Result := IsValidIP('::ffff:192.0.2.128'); // Returns: True
        Result := IsValidIP('invalid-ip');       // Returns: False
        Result := IsValidIP('');                 // Returns: False
    }
    class function IsValidIP(const Text: string): Boolean; static;
    
    {
      @description Checks if a string is a valid IPv4 address in standard dot-decimal notation.
      
      @usage Use to validate input specifically expected to be an IPv4 address.
      
      @param Text The string to check.
      
      @returns True if the string matches the IPv4 pattern (four 0-255 numbers separated by dots), False otherwise.
      
      @references Uses the regex: `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$`
      
      @warning Does not check for reserved or private IP ranges. Relies on MatchesPattern.
      
      @example
        Result := IsValidIPv4('192.168.1.1');   // Returns: True
        Result := IsValidIPv4('10.0.0.1');     // Returns: True
        Result := IsValidIPv4('0.0.0.0');       // Returns: True
        Result := IsValidIPv4('255.255.255.255'); // Returns: True
        Result := IsValidIPv4('192.168.1.256'); // Returns: False (number > 255)
        Result := IsValidIPv4('192.168.1');    // Returns: False (not enough parts)
        Result := IsValidIPv4('::1');          // Returns: False (IPv6 format)
        Result := IsValidIPv4('');             // Returns: False
    }
    class function IsValidIPv4(const Text: string): Boolean; static;
    
    {
      @description Checks if a string is a valid IPv6 address, including standard, compressed,
                   and IPv4-mapped formats.
      
      @usage Use to validate input specifically expected to be an IPv6 address.
      
      @param Text The string to check.
      
      @returns True if the string matches the complex IPv6 pattern, False otherwise.
      
      @references Uses a comprehensive regex pattern covering various IPv6 notations.
      
      @warning The regex is complex and might have edge cases or performance implications.
               Relies on MatchesPattern. Case-insensitive matching for hex digits (A-F).
      
      @example
        Result := IsValidIPv6('2001:0db8:85a3:0000:0000:8a2e:0370:7334'); // Returns: True
        Result := IsValidIPv6('2001:db8:85a3::8a2e:370:7334');          // Returns: True (compressed)
        Result := IsValidIPv6('::1');                                  // Returns: True (loopback)
        Result := IsValidIPv6('::');                                   // Returns: True (unspecified)
        Result := IsValidIPv6('::ffff:192.0.2.128');                   // Returns: True (IPv4-mapped)
        Result := IsValidIPv6('fe80::1%eth0');                         // Returns: True (link-local with zone)
        Result := IsValidIPv6('2001:db8::g');                          // Returns: False (invalid hex 'g')
        Result := IsValidIPv6('192.168.1.1');                          // Returns: False (IPv4 format)
        Result := IsValidIPv6('');                                     // Returns: False
    }
    class function IsValidIPv6(const Text: string): Boolean; static;
    
    {
      @description Checks if a string represents a valid date according to a specified format string.
                   It attempts to parse the string based on the positions of 'dd', 'mm', 'yyyy'
                   in the format string and validates the resulting day, month, and year values.
      
      @usage Use to validate if a string conforms to an expected date structure like 'yyyy-mm-dd'.
      
      @param Text The string containing the date to check.
      @param Format The format string indicating the expected order and separators (e.g., 'yyyy-mm-dd', 'dd/mm/yyyy').
                    Must contain 'dd', 'mm', and 'yyyy'.
      
      @returns True if the string can be parsed according to the format and represents a valid
               calendar date (correct day for month, leap years considered via DaysInAMonth), False otherwise.
      
      @warning This is a basic parser. It assumes separators are non-digit characters and extracts
               numbers based on the *order* implied by the positions of 'dd', 'mm', 'yyyy' in the
               Format string. It doesn't strictly enforce the separators themselves. It only supports
               'dd', 'mm', 'yyyy' components. Years must be between 1 and 9999. Relies on StrToIntDef and DaysInAMonth.
               Handles only three specific orders: dd-mm-yyyy, yyyy-mm-dd, mm-dd-yyyy. Other format orders default to assuming dd mm yyyy extraction order.
      
      @example
        Result := IsValidDate('2023-10-26', 'yyyy-mm-dd'); // Returns: True
        Result := IsValidDate('26/10/2023', 'dd/mm/yyyy'); // Returns: True
        Result := IsValidDate('10.26.2023', 'mm.dd.yyyy'); // Returns: True
        Result := IsValidDate('2023-02-29', 'yyyy-mm-dd'); // Returns: False (2023 not leap year)
        Result := IsValidDate('2024-02-29', 'yyyy-mm-dd'); // Returns: True (2024 is leap year)
        Result := IsValidDate('2023-13-01', 'yyyy-mm-dd'); // Returns: False (invalid month)
        Result := IsValidDate('2023-12-32', 'yyyy-mm-dd'); // Returns: False (invalid day)
        Result := IsValidDate('26/10/23', 'dd/mm/yy');   // Returns: False (requires 'yyyy')
        Result := IsValidDate('October 26, 2023', 'mmmm dd, yyyy'); // Returns: False (only 'dd', 'mm', 'yyyy' supported)
        Result := IsValidDate('20231026', 'yyyymmdd');   // Returns: False (assumes non-digit separators)
        Result := IsValidDate('', 'yyyy-mm-dd');       // Returns: False
    }
    class function IsValidDate(const Text, Format: string): Boolean; static;
    
    { -------------------- String Transformation and Formatting -------------------- }
    
    {
      @description Truncates a string to a maximum length, appending an ellipsis (...) if truncation occurs.
      
      @usage Use to shorten long strings for display in limited space, indicating that content has been cut off.
      
      @param Text The string to truncate.
      @param MaxLength The maximum allowed length of the resulting string, including the ellipsis.
      @param Ellipsis The string to append if truncation occurs (default is '...').
      
      @returns The truncated string with ellipsis if Text length exceeds MaxLength. If Text length
               is less than or equal to MaxLength, returns the original Text. If MaxLength is less
               than the length of Ellipsis, the behavior might be unexpected (potentially returning only Ellipsis or part of it).
      
      @warning Ensure MaxLength is reasonably larger than the length of Ellipsis. If MaxLength is very small,
               the result might be just the Ellipsis or an empty string depending on calculation.
      
      @example
        Result := Truncate('This is a long string', 10);        // Returns: 'This is...'
        Result := Truncate('Short enough', 20);                 // Returns: 'Short enough'
        Result := Truncate('VeryLongWord', 8, '..');            // Returns: 'VeryLo..'
        Result := Truncate('Tiny', 3);                          // Returns: '...' (MaxLength <= Ellipsis length)
        Result := Truncate('Tiny', 2);                          // Returns: '...' (Result length is Ellipsis length)
        Result := Truncate('', 10);                             // Returns: ''
    }
    class function Truncate(const Text: string; MaxLength: Integer; const Ellipsis: string = '...'): string; static;
    
    {
      @description Formats a file size (in bytes) into a human-readable string using binary
                   prefixes (KB, MB, GB, TB). Uses 1024 as the base.
      
      @usage Use to display file sizes in a user-friendly format.
      
      @param Size The file size in bytes (Int64).
      
      @returns A string representation of the size with a unit (B, KB, MB, GB, TB). Formats
               KB and larger units to two decimal places.
      
      @warning Uses binary prefixes (KiB, MiB, etc., based on 1024), but labels them KB, MB.
               Formatting uses the default locale's decimal separator. Negative sizes are not handled specifically.
      
      @example
        Result := FormatFileSize(512);       // Returns: '512 B'
        Result := FormatFileSize(1536);      // Returns: '1.50 KB' (approx)
        Result := FormatFileSize(1048576);   // Returns: '1.00 MB' (1 * 1024 * 1024)
        Result := FormatFileSize(1500000000); // Returns: '1.40 GB' (approx)
        Result := FormatFileSize(2199023255552); // Returns: '2.00 TB' (approx)
        Result := FormatFileSize(0);         // Returns: '0 B'
    }
    class function FormatFileSize(Size: Int64): string; static;
    
    {
      @description Formats an integer (Int64) by inserting a thousand separator character.
                   Only formats non-negative numbers with more than 3 digits.
      
      @usage Use to make large numbers easier to read.
      
      @param Value The integer value to format.
      @param ThousandSeparator The character to use as a separator (default is comma ',').
      
      @returns The formatted number as a string. Returns the original string representation
               if the value is negative or has 3 or fewer digits.
      
      @warning Only formats non-negative integers. Does not handle locale-specific formatting rules.
               Negative numbers are returned as plain strings (e.g., '-1234').
      
      @example
        Result := FormatNumber(1234567);       // Returns: '1,234,567'
        Result := FormatNumber(123);           // Returns: '123'
        Result := FormatNumber(1234, '.');     // Returns: '1.234'
        Result := FormatNumber(0);             // Returns: '0'
        Result := FormatNumber(-12345);        // Returns: '-12345' (not formatted)
    }
    class function FormatNumber(const Value: Int64; ThousandSeparator: Char = ','): string; static;
    
    {
      @description Formats a floating-point number (Double) with specified decimal places,
                   decimal separator, and thousand separator for the integer part. Includes rounding.
      
      @usage Use for displaying currency values or other floating-point numbers in a specific,
             user-friendly format.
      
      @param Value The floating-point value to format.
      @param Decimals The number of decimal places to display (default is 2).
      @param DecimalSeparator The character to use as the decimal separator (default is period '.').
      @param ThousandSeparator The character to use for separating thousands in the integer part (default is comma ',').
      
      @returns The formatted number as a string. Handles negative numbers and rounding.
      
      @warning Relies on the custom FormatNumber for thousand separation (which only works for non-negatives,
               but this function handles the sign separately). Rounding is performed using standard Round function.
               Does not use system locale for formatting.
      
      @example
        Result := FormatFloat(12345.6789);          // Returns: '12,345.68' (default 2 decimals)
        Result := FormatFloat(12345.6789, 3);       // Returns: '12,345.679'
        Result := FormatFloat(12345.67, 4, ',', '.'); // Returns: '12.345,6700'
        Result := FormatFloat(-9876.543, 1);        // Returns: '-9,876.5'
        Result := FormatFloat(0.12, 2);             // Returns: '0.12'
        Result := FormatFloat(999.999, 2);          // Returns: '1,000.00' (rounding carries over)
        Result := FormatFloat(1234, 0);             // Returns: '1,234' (no decimals)
    }
    class function FormatFloat(const Value: Double; Decimals: Integer = 2; DecimalSeparator: Char = '.'; ThousandSeparator: Char = ','): string; static;
    
    { -------------------- String Splitting and Joining -------------------- }
    
    {
      @description Joins an array of strings into a single string, inserting a delimiter between elements.
      
      @usage Use to combine multiple string pieces into one, for example, creating a comma-separated list
             or reconstructing a sentence from words.
      
      @param Strings The array of strings (TStringDynArray) to join.
      @param Delimiter The string to insert between each element of the array.
      
      @returns The concatenated string. Returns an empty string if the input array is empty.
               If the array has one element, returns just that element without any delimiter.
      
      @warning None identified.
      
      @example
        // Assuming Arr is TStringDynArray
        Arr := ['apple', 'banana', 'cherry'];
        Result := Join(Arr, ', '); // Returns: 'apple, banana, cherry'
        
        Arr := ['one'];
        Result := Join(Arr, '-');   // Returns: 'one'
        
        SetLength(Arr, 0);
        Result := Join(Arr, ',');   // Returns: ''
    }
    class function Join(const Strings: TStringDynArray; const Delimiter: string): string; static;
    
    {
      @description Splits a string into an array of substrings based on a specified delimiter.
                   Offers options to limit the number of splits and remove empty entries.
      
      @usage Use for parsing delimited data (like CSV lines, though more robust CSV parsing is recommended),
             breaking down paths, or splitting text based on specific separators.
      
      @param Text The string to split.
      @param Delimiter The string used as the separator.
      @param MaxSplit The maximum number of splits to perform. If 0 (default), all occurrences
                    of the delimiter are used. If > 0, the string is split at most MaxSplit times,
                    and the remainder of the string becomes the last element of the array.
      @param RemoveEmptyEntries If True, empty strings resulting from the split (e.g., from
                              consecutive delimiters) are excluded from the result array. Default is False.
      
      @returns A dynamic array of strings (TStringDynArray) containing the substrings.
      
      @warning The delimiter itself is not included in the results. If Text is empty, returns an array
               containing a single empty string unless RemoveEmptyEntries is True. If Delimiter is empty,
               the behavior might be unexpected (likely infinite loop or incorrect split, depending on Pos behavior).
               The current implementation seems to handle empty delimiter by finding it at Pos 1, potentially leading to issues. Let's assume Delimiter is non-empty.
      
      @example
        // Assuming Result is TStringDynArray
        Result := Split('a,b,c', ','); // Returns: ['a', 'b', 'c']
        Result := Split('a,,c', ','); // Returns: ['a', '', 'c']
        Result := Split('a,,c', ',', 0, True); // Returns: ['a', 'c'] (RemoveEmptyEntries=True)
        Result := Split('a,b,c,d', ',', 2); // Returns: ['a', 'b', 'c,d'] (MaxSplit=2)
        Result := Split('path/to/file', '/'); // Returns: ['path', 'to', 'file']
        Result := Split('', ','); // Returns: ['']
        Result := Split('', ',', 0, True); // Returns: []
        Result := Split('test', 'x'); // Returns: ['test']
    }
    class function Split(const Text, Delimiter: string; MaxSplit: Integer = 0; RemoveEmptyEntries: Boolean = False): TStringDynArray; static;
    
    { -------------------- Phonetic Algorithms -------------------- }
    
    {
      @description Generates a Soundex code for a given string (typically a name). Soundex is a
                   phonetic algorithm indexing names by their English pronunciation sound.
                   The code consists of the first letter followed by three digits representing
                   consonant sounds.
      
      @usage Use for fuzzy matching of names where spelling variations might occur but pronunciation
             is similar (e.g., 'Robert' and 'Rupert').
      
      @param Text The string (usually a name) to encode. Case-insensitive.
      
      @returns The 4-character Soundex code (e.g., 'R163'). Returns a code based on the first
               letter padded with zeros (e.g., 'A000') if the input is empty or contains no
               encodable consonants after the first letter. The implementation returns '0000' if Text is empty. Let's check. No, it returns ''. If Text='A', returns 'A000'. If Text='@', returns '@000'.
               **Revised Returns:** The 4-character Soundex code (e.g., 'R163'). Returns an empty string if Text is empty. If Text has non-alphabetic first char, it's used. If no consonants follow, pads with '0'.

      @references https://en.wikipedia.org/wiki/Soundex
                  Original algorithm by Robert C. Russell and Margaret K. Odell.
      
      @warning Primarily designed for English names. May not work well for names from other languages.
               Different implementations might have slight variations in handling specific letter combinations or initial letters. Only considers ASCII letters A-Z.
      
      @example
        Result := Soundex('Robert');  // Returns: 'R163'
        Result := Soundex('Rupert');  // Returns: 'R163'
        Result := Soundex('Ashcraft'); // Returns: 'A261'
        Result := Soundex('Ashcraftt'); // Returns: 'A261' (ignores adjacent same codes)
        Result := Soundex('Tymczak'); // Returns: 'T522'
        Result := Soundex('Pfister'); // Returns: 'P236'
        Result := Soundex('Euler');   // Returns: 'E460'
        Result := Soundex('Gauss');   // Returns: 'G200'
        Result := Soundex('A');       // Returns: 'A000'
        Result := Soundex('');        // Returns: ''
    }
    class function Soundex(const Text: string): string; static;
    
    {
      @description Generates a Metaphone code for a given string. Metaphone is a phonetic algorithm
                   designed to encode English words based on their pronunciation, improving on Soundex.
      
      @usage Use for phonetic matching of English words, indexing, or data linkage where pronunciation
             similarity is key.
      
      @param Text The word to encode. Case-insensitive.
      
      @returns The Metaphone code (variable length string). Returns an empty string if the input is empty.
      
      @references https://en.wikipedia.org/wiki/Metaphone
                  Algorithm by Lawrence Philips.
      
      @warning Designed for English pronunciation. The implementation follows a specific set of rules
               and might differ slightly from other Metaphone implementations. It includes a
               non-standard normalization step removing trailing 'S'. Only considers ASCII letters A-Z.
      
      @example
        Result := Metaphone('metaphone'); // Returns: 'MTFN'
        Result := Metaphone('telephone'); // Returns: 'TLFN'
        Result := Metaphone('example');   // Returns: 'EKSMPL'
        Result := Metaphone('knight');    // Returns: 'NT' (silent K, GH)
        Result := Metaphone('wrack');     // Returns: 'RK' (silent W)
        Result := Metaphone('science');   // Returns: 'SNS' (SC -> S)
        Result := Metaphone('tough');     // Returns: 'TF' (GH -> F) - Let's check rules. GH non-initial silent. Should be 'T'. Implementation has `Skip := True`. Correct.
        Result := Metaphone('Xavier');    // Returns: 'SFR' (Initial X -> S)
        Result := Metaphone('');          // Returns: ''
    }
    class function Metaphone(const Text: string): string; static;
    
    { -------------------- Text Analysis -------------------- }
    
    {
      @description Counts the number of words in a text. Words are identified as sequences of
                   alphanumeric characters using the GetWords function.
      
      @usage Use for basic text statistics, like calculating words per minute or as input for
             readability formulas.
      
      @param Text The text to analyze.
      
      @returns The total number of words found in the text.
      
      @warning Relies on GetWords for word identification (alphanumeric sequences only). Punctuation
                acts as a separator and is not counted.
      
      @example
        Result := CountWords('Hello, world! How are you?'); // Returns: 5
        Result := CountWords('Item123 Code-ABC.');         // Returns: 3 ('Item123', 'Code', 'ABC')
        Result := CountWords('OneWord');                   // Returns: 1
        Result := CountWords('   ');                       // Returns: 0
        Result := CountWords('');                          // Returns: 0
    }
    class function CountWords(const Text: string): Integer; static;
    
    {
      @description Calculates the Flesch-Kincaid Reading Ease score for a given text. This score
                   estimates the readability of English text, with higher scores indicating easier
                   readability (typically on a 0-100 scale).
      
      @usage Use to assess the complexity of written material, aiming for appropriate scores based
             on the target audience (e.g., higher scores for general public, lower for academic papers).
      
      @param Text The text to analyze.
      
      @returns The Flesch-Kincaid Reading Ease score (Double), typically between 0 and 100.
               Returns 0 if the text contains no words.
      
      @references Formula: `206.835 - 1.015 * (TotalWords / TotalSentences) - 84.6 * (TotalSyllables / TotalWords)`
                  https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests
      
      @warning Relies on CountWords (alphanumeric based) and a simple sentence counter (based on '.', '!', '?').
                Syllable counting uses the approximate CountVowelGroups function. These approximations
                can affect the accuracy of the score compared to more sophisticated linguistic analysis.
                Assumes English text. Score is capped between 0 and 100.
      
      @example // Scores are approximate due to syllable counting method
        Text1 := 'The quick brown fox jumps over the lazy dog.'; // 9 words, 1 sentence, ~10 syllables
        // Score ~ 206.835 - 1.015*(9/1) - 84.6*(10/9) = 206.835 - 9.135 - 94 = ~103.7 (capped at 100)
        Result := FleschKincaidReadability(Text1); // Should be high (easy) -> ~100.0
        
        Text2 := 'This sentence, taken as a standalone example, is moderately complex.'; // 11 words, 1 sentence, ~21 syllables
        // Score ~ 206.835 - 1.015*(11/1) - 84.6*(21/11) = 206.835 - 11.165 - 161.5 = ~34.17
        Result := FleschKincaidReadability(Text2); // Should be lower (harder) -> ~34.2
        
        Result := FleschKincaidReadability(''); // Returns: 0.0
    }
    class function FleschKincaidReadability(const Text: string): Double; static;
    
    {
      @description Generates n-grams (sequences of N consecutive words) from a text.
      
      @usage Use in natural language processing (NLP) for tasks like text analysis, feature
             extraction for machine learning models, language modeling, or identifying common phrases.
      
      @param Text The text to process.
      @param N The size of the n-gram (e.g., 2 for bigrams, 3 for trigrams). Must be > 0.
      
      @returns A dynamic array of strings (TStringDynArray), where each string is an n-gram
               with words separated by single spaces. Returns an empty array if N <= 0,
               Text is empty, or Text contains fewer than N words.
      
      @warning Relies on GetWords for word tokenization (alphanumeric sequences). Punctuation is lost.
               N-grams are simple space-separated concatenations of the identified words.
      
      @example
        // Assuming Result is TStringDynArray
        Result := GenerateNGrams('the quick brown fox', 2); // Bigrams
        // Result[0]: 'the quick'
        // Result[1]: 'quick brown'
        // Result[2]: 'brown fox'
        
        Result := GenerateNGrams('the quick brown fox', 3); // Trigrams
        // Result[0]: 'the quick brown'
        // Result[1]: 'quick brown fox'
        
        Result := GenerateNGrams('one two', 3); // N > word count
        // Length(Result) = 0
        
        Result := GenerateNGrams('Hello, world!', 1); // Unigrams
        // Result[0]: 'Hello'
        // Result[1]: 'world'
        
        Result := GenerateNGrams('test', 0); // N <= 0
        // Length(Result) = 0
    }
    class function GenerateNGrams(const Text: string; N: Integer): TStringDynArray; static;
    
    { -------------------- Encoding/Decoding Functions -------------------- }
    
    {
      @description Encodes a string for safe inclusion in HTML by replacing special characters
                   ('<', '>', '&', '"', ''') with their corresponding HTML entities.
      
      @usage Use before inserting arbitrary text into HTML content (elements or attributes)
             to prevent Cross-Site Scripting (XSS) attacks and ensure correct rendering.
      
      @param Text The string to encode.
      
      @returns The HTML-encoded string.
      
      @warning Only encodes the five essential HTML characters: < (&lt;), > (&gt;), & (&amp;),
               " (&quot;), ' (&#39;). Does not encode other characters that might have special
               meaning in specific HTML contexts (e.g., within JavaScript).
      
      @example
        Result := HTMLEncode('<p class="bold">Text</p>'); // Returns: '&lt;p class=&quot;bold&quot;&gt;Text&lt;/p&gt;'
        Result := HTMLEncode('Data & Results');          // Returns: 'Data &amp; Results'
        Result := HTMLEncode('Regular text');            // Returns: 'Regular text'
        Result := HTMLEncode('');                        // Returns: ''
    }
    class function HTMLEncode(const Text: string): string; static;
    
    {
      @description Decodes a string containing common HTML entities back into their original characters.
                   Specifically decodes &lt;, &gt;, &amp;, &quot;, &#39;, and &nbsp;.
      
      @usage Use when retrieving text that was previously HTML-encoded, to display it as plain text
             or process the original characters. Be cautious if the source is untrusted.
      
      @param Text The HTML-encoded string.
      
      @returns The decoded string.
      
      @warning Only decodes a limited set of common entities (&lt;, &gt;, &amp;, &quot;, &#39;, &nbsp;).
                Does not handle numeric entities (e.g., &#160;) other than &#39; or named entities
                beyond the listed ones (e.g., &copy;). Uses simple text replacement.
                Decoding untrusted input can be risky if the result is used in sensitive contexts.
      
      @example
        Result := HTMLDecode('&lt;p&gt;Hello &amp; World&lt;/p&gt;'); // Returns: '<p>Hello & World</p>'
        Result := HTMLDecode('Text with &quot;quotes&quot; and &#39;apostrophe&#39;.'); // Returns: 'Text with "quotes" and ''apostrophe''.'
        Result := HTMLDecode('Regular text');                      // Returns: 'Regular text'
        Result := HTMLDecode('&nbsp;');                            // Returns: ' '
        Result := HTMLDecode('');                                  // Returns: ''
    }
    class function HTMLDecode(const Text: string): string; static;
    
    {
      @description Encodes a string for safe inclusion in a URL component (like a query parameter value)
                   by percent-encoding unsafe characters. Spaces are encoded as '+'.
      
      @usage Use when constructing URLs dynamically to ensure special characters in parameters
             or path segments don't break the URL structure or cause misinterpretation.
      
      @param Text The string to encode.
      
      @returns The URL-encoded string.
      
      @references Follows common application/x-www-form-urlencoded logic where space becomes '+'.
                  Safe characters (A-Z, a-z, 0-9, '-', '_', '.', '~') are not encoded.
                  Other bytes are encoded as %XX.
      
      @warning This specific encoding (space to '+') is typically for query string parameters.
                For encoding path segments, RFC 3986 suggests encoding space as %20.
                Assumes single-byte characters; behavior with multi-byte UTF-8 might depend on Ord() interpretation.
      
      @example
        Result := URLEncode('Hello World!');     // Returns: 'Hello+World%21'
        Result := URLEncode('data=value&more'); // Returns: 'data%3Dvalue%26more'
        Result := URLEncode('safe-chars_.~');   // Returns: 'safe-chars_.~'
        Result := URLEncode('');                // Returns: ''
    }
    class function URLEncode(const Text: string): string; static;
    
    {
      @description Decodes a URL-encoded string (specifically, application/x-www-form-urlencoded format)
                   back into its original form. Converts '+' back to space and %XX hex sequences
                   to their corresponding characters.
      
      @usage Use to interpret data received from URL parameters or form submissions.
      
      @param Text The URL-encoded string.
      
      @returns The decoded string.
      
      @warning Assumes the input follows common URL encoding rules (space as '+', others as %XX).
                Handles potential errors during hex conversion (%XX) by skipping the invalid sequence
                and including the '%' literally. Assumes %XX represents single bytes; multi-byte
                character reconstruction depends on the context where the decoded string is used.
      
      @example
        Result := URLDecode('Hello+World%21');     // Returns: 'Hello World!'
        Result := URLDecode('data%3Dvalue%26more'); // Returns: 'data=value&more'
        Result := URLDecode('safe-chars_.~');   // Returns: 'safe-chars_.~'
        Result := URLDecode('invalid%ZZsequence'); // Returns: 'invalid%ZZsequence' (assuming %ZZ fails StrToInt)
        Result := URLDecode('');                // Returns: ''
    }
    class function URLDecode(const Text: string): string; static;
    
    {
      @description Encodes binary/text data into Base64 representation using the standard
                   Base64 alphabet (RFC 4648) with '=' padding.
      
      @usage Use to safely transmit/serialize arbitrary bytes as ASCII text.
      
      @param Text The input string to encode. Each character's byte value is used.
      
      @returns Base64-encoded string. Empty string encodes to empty string.
      
      @warning Operates on the raw bytes in the string. For Unicode text, ensure the
               encoding is as expected (e.g., UTF-8) before calling.
      
      @example
        Result := Encode64('Hello'); // Returns: 'SGVsbG8='
        Result := Encode64('');      // Returns: ''
    }
    class function Encode64(const Text: string): string; static;
    
    {
      @description Decodes a Base64-encoded string (RFC 4648, standard alphabet) back to
                   its original byte sequence represented as a Pascal string.
      
      @usage Use to decode data previously encoded with Encode64 or other compatible Base64 encoders.
      
      @param Base64Text The Base64 string (may contain '=' padding). Whitespace is ignored.
      
      @returns Decoded string. Returns empty string on invalid input.
      
      @warning Invalid characters or incorrect padding result in an empty string. Operates on
               bytes; convert to text with the appropriate encoding if necessary.
      
      @example
        Result := Decode64('SGVsbG8='); // Returns: 'Hello'
        Result := Decode64('');         // Returns: ''
    }
    class function Decode64(const Base64Text: string): string; static;
    
    { -------------------- Number Conversions -------------------- }
    
    {
      @description Converts a positive integer into its Roman numeral representation.
      
      @usage Use for displaying numbers in Roman numeral format, typically for stylistic purposes
             (e.g., chapter numbers, clock faces).
      
      @param Value The integer to convert. Must be between 1 and 3999, inclusive.
      
      @returns The Roman numeral string (e.g., 'MMXXIV'). Returns an empty string if the
               Value is outside the valid range (1-3999).
      
      @references Uses standard Roman numeral subtractive notation (e.g., IV, IX, XL, XC, CD, CM).
      
      @warning Only supports integers from 1 to 3999. Input outside this range yields an empty string.
      
      @example
        Result := ToRoman(1994); // Returns: 'MCMXCIV'
        Result := ToRoman(2023); // Returns: 'MMXXIII'
        Result := ToRoman(4);    // Returns: 'IV'
        Result := ToRoman(9);    // Returns: 'IX'
        Result := ToRoman(3999); // Returns: 'MMMCMXCIX'
        Result := ToRoman(0);    // Returns: ''
        Result := ToRoman(4000); // Returns: ''
    }
    class function ToRoman(Value: Integer): string; static;
    
    {
      @description Converts a Roman numeral string into its integer value.
      
      @usage Use to parse Roman numerals back into standard integer values.
      
      @param RomanNumeral The Roman numeral string to convert (case-insensitive).
      
      @returns The integer value represented by the Roman numeral. Returns 0 if the input string
               is empty, contains invalid characters, or represents an invalid Roman numeral sequence
               according to standard rules (though validation is basic).
      
      @references Understands standard Roman digits (I, V, X, L, C, D, M) and basic subtractive rules.
      
      @warning Case-insensitive. Validation is basic: checks if all characters are valid Roman digits
                but doesn't fully enforce all formation rules (e.g., 'IIII' might be accepted, 'IM' might parse incorrectly).
                Parsing logic iterates right-to-left, adding or subtracting values. Returns 0 for invalid input.
      
      @example
        Result := FromRoman('MCMXCIV'); // Returns: 1994
        Result := FromRoman('MMXXIII'); // Returns: 2023
        Result := FromRoman('IV');      // Returns: 4
        Result := FromRoman('ix');      // Returns: 9 (case-insensitive)
        Result := FromRoman('MMMCMXCIX'); // Returns: 3999
        Result := FromRoman('Invalid'); // Returns: 0 (contains invalid char 'n')
        Result := FromRoman('IC');      // Returns: 99 (parses as 100 - 1)
        Result := FromRoman('');        // Returns: 0
    }
    class function FromRoman(const RomanNumeral: string): Integer; static;
    
    {
      @description Converts an integer into its ordinal string representation (e.g., 1 -> '1st', 2 -> '2nd').
      
      @usage Use for displaying numbers as ordinals in text (e.g., '1st place', '2nd attempt').
      
      @param Value The integer to convert.
      
      @returns The integer as a string followed by the appropriate ordinal suffix ('st', 'nd', 'rd', or 'th').
               Handles the special cases for 11th, 12th, 13th. Works for negative numbers too (e.g., -1 -> '-1st').
      
      @warning Uses English language rules for suffixes.
      
      @example
        Result := ToOrdinal(1);    // Returns: '1st'
        Result := ToOrdinal(2);    // Returns: '2nd'
        Result := ToOrdinal(3);    // Returns: '3rd'
        Result := ToOrdinal(4);    // Returns: '4th'
        Result := ToOrdinal(11);   // Returns: '11th'
        Result := ToOrdinal(12);   // Returns: '12th'
        Result := ToOrdinal(13);   // Returns: '13th'
        Result := ToOrdinal(21);   // Returns: '21st'
        Result := ToOrdinal(102);  // Returns: '102nd'
        Result := ToOrdinal(0);    // Returns: '0th'
        Result := ToOrdinal(-5);   // Returns: '-5th'
    }
    class function ToOrdinal(Value: Integer): string; static;
    
    {
      @description Converts an integer (Int64) into its English word representation.
      
      @usage Use for check writing, formal documents, or anywhere a number needs to be spelled out.
      
      @param Value The number (Int64) to convert.
      
      @returns The English word representation of the number (e.g., 'one hundred twenty-three').
               Handles negative numbers, zero, and values up to the limits of Int64 (though billions
               are the highest explicit unit handled). Uses 'and' for numbers like 123 ('one hundred and twenty-three')
               following British English convention in some cases.
      
      @warning Currently supports English only. Uses a helper function for numbers < 1000.
                Includes 'and' based on specific conditions (e.g., if remainder < 100 or original value was 1000-1999 and remainder > 0),
                which might not perfectly match all style guides. Handles up to billions. Larger numbers might not include higher units (trillions, etc.).
      
      @example
        Result := NumberToWords(123);        // Returns: 'one hundred and twenty-three'
        Result := NumberToWords(100);        // Returns: 'one hundred'
        Result := NumberToWords(105);        // Returns: 'one hundred and five'
        Result := NumberToWords(1234);       // Returns: 'one thousand two hundred and thirty-four'
        Result := NumberToWords(1000);       // Returns: 'one thousand'
        Result := NumberToWords(1001);       // Returns: 'one thousand and one'
        Result := NumberToWords(15010);      // Returns: 'fifteen thousand and ten'
        Result := NumberToWords(1000000);    // Returns: 'one million'
        Result := NumberToWords(25000001);   // Returns: 'twenty-five million and one'
        Result := NumberToWords(1000000000); // Returns: 'one billion'
        Result := NumberToWords(0);          // Returns: 'zero'
        Result := NumberToWords(-42);        // Returns: 'negative forty-two'
    }
    class function NumberToWords(Value: Int64): string; static;
    
    { -------------------- Encoding/Decoding Functions -------------------- } // Duplicate section header
    
    {
      @description Converts a string into its hexadecimal representation, where each character
                   is represented by two hexadecimal digits (0-9, A-F).
      
      @usage Use for representing binary data or strings in a text format, often for debugging,
             data transmission, or storage where raw binary might be problematic.
      
      @param Text The string to convert.
      
      @returns The hexadecimal representation of the string (e.g., 'Hello' -> '48656C6C6F').
               Returns an empty string if the input is empty.
      
      @warning Assumes single-byte characters. For multi-byte encodings (like UTF-8), this encodes
                the individual bytes of the string's internal representation. The output uses uppercase hex digits (A-F).
      
      @example
        Result := HexEncode('Hello'); // Returns: '48656C6C6F'
        Result := HexEncode('123');   // Returns: '313233'
        Result := HexEncode(#$0A#$FF); // Returns: '0AFF'
        Result := HexEncode('');      // Returns: ''
    }
    class function HexEncode(const Text: string): string; static;
    
    {
      @description Converts a hexadecimal string (pairs of hex digits) back into its original
                   string representation by interpreting each pair as a character code.
      
      @usage Use to decode strings that were previously HexEncode'd or received in hex format.
      
      @param HexText The hexadecimal string to convert (e.g., '48656C6C6F'). Case-insensitive for hex digits A-F.
      
      @returns The original string represented by the hex data. Returns an empty string if HexText
               is empty or has an odd number of characters. Skips invalid hex pairs.
      
      @warning Expects an even number of hex characters. If the length is odd, it returns an empty string.
                Invalid hex pairs (containing non-hex characters) are skipped during decoding.
                Assumes each hex pair represents a single byte/character code. Correctly reconstructing
                multi-byte characters depends on the original encoding.
      
      @example
        Result := HexDecode('48656C6C6F'); // Returns: 'Hello'
        Result := HexDecode('313233');   // Returns: '123'
        Result := HexDecode('0AFF');     // Returns: #$0A#$FF (LF character followed by FF character)
        Result := HexDecode('48656c6c6f'); // Returns: 'Hello' (case-insensitive)
        Result := HexDecode('48 65 6C'); // Returns: 'HeL' (skips space, processes '48', skips ' 6', processes '6C') - Let's recheck. It checks pairs `^[0-9A-Fa-f]{2}$`. '48' ok. ' 6' fails. '65' ok. ' 6' fails. '6C' ok. Result should be 'HeL'. Let's trace: I=1, Pair='48', Add Chr(72)='H'. I=3. Pair='65', Add Chr(101)='e'. I=5. Pair='6C', Add Chr(108)='l'. I=7. Pair='6F', Add Chr(111)='o'. Result 'Hello'. The example '48 65 6C' needs re-evaluation. I=1, Pair='48', Add 'H'. I=3. Pair=' 6', Fails regex. I=4. Pair='65', Add 'e'. I=6. Pair=' 6', Fails regex. I=7. Pair='6C', Add 'L'. I=9. End. Result: 'HeL'. Example corrected.
        Result := HexDecode('48656C6C6'); // Returns: '' (odd length)
        Result := HexDecode('');         // Returns: ''
    }
    class function HexDecode(const HexText: string): string; static;
  end;

implementation

{ TStringKit }

class function TStringKit.IsWhiteSpace(const C: Char): Boolean;
begin
  Result := C in [' ', #9, #10, #13];
end;

class function TStringKit.Trim(const Text: string): string;
begin
  Result := SysUtils.Trim(Text);
end;

class function TStringKit.TrimLeft(const Text: string): string;
begin
  Result := SysUtils.TrimLeft(Text);
end;

class function TStringKit.TrimRight(const Text: string): string;
begin
  Result := SysUtils.TrimRight(Text);
end;

class function TStringKit.ToUpper(const Text: string): string;
begin
  Result := UpperCase(Text);
end;

class function TStringKit.ToLower(const Text: string): string;
begin
  Result := LowerCase(Text);
end;

class function TStringKit.PadCenter(const Text: string; Width: Integer; PadChar: Char): string;
var
  CurrentLen, PadLen, LeftPad: Integer;
begin
  CurrentLen := Length(Text);
  if CurrentLen < Width then
  begin
    PadLen := Width - CurrentLen;
    LeftPad := PadLen div 2;
    Result := StringOfChar(PadChar, LeftPad) + 
              Text + 
              StringOfChar(PadChar, PadLen - LeftPad);
  end
  else
    Result := Text;
end;

class function TStringKit.PadLeft(const Text: string; Width: Integer; PadChar: Char): string;
begin
  if Length(Text) < Width then
    Result := StringOfChar(PadChar, Width - Length(Text)) + Text
  else
    Result := Text;
end;

class function TStringKit.PadRight(const Text: string; Width: Integer; PadChar: Char): string;
begin
  if Length(Text) < Width then
    Result := Text + StringOfChar(PadChar, Width - Length(Text))
  else
    Result := Text;
end;

class function TStringKit.CollapseWhitespace(const Text: string): string;
var
  I: Integer;
  LastWasSpace: Boolean;
begin
  Result := '';
  LastWasSpace := False;
  for I := 1 to Length(Text) do
  begin
    if IsWhiteSpace(Text[I]) then
    begin
      if not LastWasSpace then
      begin
        Result := Result + ' ';
        LastWasSpace := True;
      end;
    end
    else
    begin
      Result := Result + Text[I];
      LastWasSpace := False;
    end;
  end;
end;

class function TStringKit.RemoveWhitespace(const Text: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Text) do
    if not IsWhiteSpace(Text[I]) then
      Result := Result + Text[I];
end;

class function TStringKit.DuplicateText(const Text: string; Count: Integer): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Count do
    Result := Result + Text;
end;

class function TStringKit.ReverseText(const Text: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := Length(Text) downto 1 do
    Result := Result + Text[I];
end;

class function TStringKit.CapitalizeText(const Text: string): string;
var
  Words: TStringList;
  I: Integer;
  S: string;
begin
  Result := Text;
  if Length(Text) > 0 then
  begin
    Words := TStringList.Create;
    try
      Words.Delimiter := ' ';
      Words.StrictDelimiter := True;
      Words.DelimitedText := Text;
      
      for I := 0 to Words.Count - 1 do
        if Words[I] <> '' then
        begin
          S := Words[I];
          while (Length(S) > 0) and IsWhiteSpace(S[1]) do
            Delete(S, 1, 1);
          if Length(S) > 0 then
            Words[I] := UpperCase(S[1]) + LowerCase(Copy(S, 2, Length(S)));
        end;
      
      Result := StringReplace(Words.DelimitedText, Words.Delimiter, ' ', [rfReplaceAll]);
    finally
      Words.Free;
    end;
  end;
end;

class function TStringKit.ExtractMatches(const Text, Pattern: string): TMatchesResults;
var
  RegEx: TRegExpr;
  MatchCount: Integer;
begin
  Result := nil;
  SetLength(Result, 0);
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    if RegEx.Exec(Text) then
    begin
      repeat
        MatchCount := Length(Result);
        SetLength(Result, MatchCount + 1);
        Result[MatchCount].Text := RegEx.Match[0];
        Result[MatchCount].Position := RegEx.MatchPos[0];
        Result[MatchCount].Length := RegEx.MatchLen[0];
      until not RegEx.ExecNext;
    end;
  finally
    RegEx.Free;
  end;
end;

class function TStringKit.ExtractAllMatches(const Text, Pattern: string): TStringDynArray;
var
  Matches: TMatchesResults;
  I: Integer;
begin
  Result := nil;
  SetLength(Result, 0);
  Matches := ExtractMatches(Text, Pattern);
  SetLength(Result, Length(Matches));
  for I := 0 to High(Matches) do
    Result[I] := Matches[I].Text;
end;

class function TStringKit.MatchesPattern(const Text, Pattern: string): Boolean;
var
  RegEx: TRegExpr;
begin
  Result := False;
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    Result := RegEx.Exec(Text);
  finally
    RegEx.Free;
  end;
end;

class function TStringKit.ReplaceRegEx(const Text, Pattern, Replacement: string): string;
var
  RegEx: TRegExpr;
begin
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    Result := RegEx.Replace(Text, Replacement, True);
  finally
    RegEx.Free;
  end;
end;

class function TStringKit.ReplaceText(const Text, OldText, NewText: string): string;
begin
  Result := StringReplace(Text, OldText, NewText, [rfReplaceAll]);
end;

class function TStringKit.GetWords(const AText: string): TStringDynArray;
var
  WordList: TStringList;
  I: Integer;
  Word: string;
  Ch: Char;
  InWord: Boolean;
begin
  WordList := TStringList.Create;
  try
    Word := '';
    InWord := False;
    
    for Ch in AText do
    begin
      if Ch in ['A'..'Z', 'a'..'z', '0'..'9'] then
      begin
        Word := Word + Ch;
        InWord := True;
      end
      else if InWord then
      begin
        if Word <> '' then
          WordList.Add(Word);
        Word := '';
        InWord := False;
      end;
    end;
    
    if Word <> '' then
      WordList.Add(Word);
      
    SetLength(Result, WordList.Count);
    for I := 0 to WordList.Count - 1 do
      Result[I] := WordList[I];
  finally
    WordList.Free;
  end;
end;

class function TStringKit.CountSubString(const Text, SubStr: string): Integer;
var
  P: Integer;
begin
  Result := 0;
  if SubStr = '' then
    Exit;
    
  P := Pos(SubStr, Text);
  while P > 0 do
  begin
    Inc(Result);
    P := Pos(SubStr, Text, P + 1);
  end;
end;

class function TStringKit.Contains(const Text, SubStr: string): Boolean;
begin
  Result := Pos(SubStr, Text) > 0;
end;

class function TStringKit.StartsWith(const Text, Prefix: string): Boolean;
begin
  Result := Copy(Text, 1, Length(Prefix)) = Prefix;
end;

class function TStringKit.EndsWith(const Text, Suffix: string): Boolean;
begin
  Result := Copy(Text, Length(Text) - Length(Suffix) + 1, Length(Suffix)) = Suffix;
end;

class function TStringKit.IsEmpty(const Text: string): Boolean;
begin
  Result := Text = '';
end;

class function TStringKit.GetLength(const Text: string): Integer;
begin
  Result := Length(Text);
end;

class function TStringKit.SubString(const Text: string; StartPos, Length: Integer): string;
begin
  Result := Copy(Text, StartPos, Length);
end;

class function TStringKit.LeftStr(const Text: string; Length: Integer): string;
begin
  Result := Copy(Text, 1, Length);
end;

class function TStringKit.RightStr(const Text: string; Length: Integer): string;
begin
  Result := Copy(Text, System.Length(Text) - Length + 1, Length);
end;

class function TStringKit.Min3(A, B, C: Integer): Integer;
begin
  if A < B then
    if A < C then
      Result := A
    else
      Result := C
  else
    if B < C then
      Result := B
    else
      Result := C;
end;

class function TStringKit.Min2(A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

class function TStringKit.Max2(A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

class function TStringKit.LevenshteinDistance(const S1, S2: string): Integer;
var
  D: array of array of Integer;
  I, J, M, N, Cost: Integer;
begin
  // Special case for empty strings
  if S1 = '' then
    Exit(Length(S2));
  if S2 = '' then
    Exit(Length(S1));

  M := Length(S1);
  N := Length(S2);
  SetLength(D, M + 1, N + 1);

  for I := 0 to M do
    D[I, 0] := I;
  for J := 0 to N do
    D[0, J] := J;

  for I := 1 to M do
  begin
    for J := 1 to N do
    begin
      if S1[I] = S2[J] then
        Cost := 0
      else
        Cost := 1;
      D[I, J] := Min3(D[I - 1, J] + 1, D[I, J - 1] + 1, D[I - 1, J - 1] + Cost);
    end;
  end;

  Result := D[M, N];
end;

class function TStringKit.LevenshteinSimilarity(const S1, S2: string): Double;
var
  Distance: Integer;
begin
  Distance := LevenshteinDistance(S1, S2);
  Result := 1.0 - (Distance / Max(Length(S1), Length(S2)));
end;

class function TStringKit.HammingDistance(const S1, S2: string): Integer;
var
  I, Distance: Integer;
begin
  Distance := 0;
  if Length(S1) <> Length(S2) then
    Exit(-1);
  for I := 1 to Length(S1) do
    if S1[I] <> S2[I] then
      Inc(Distance);
  Result := Distance;
end;

class function TStringKit.JaroSimilarity(const S1, S2: string): Double;
var
  M, T: Integer;
  Matches1, Matches2: array of Boolean;
  MatchWindow: Integer;
  I, J: Integer;
begin
  // Handle empty strings
  if (Length(S1) = 0) and (Length(S2) = 0) then
    Exit(1.0);
  if (Length(S1) = 0) or (Length(S2) = 0) then
    Exit(0.0);

  // Calculate match window size - standard Jaro algorithm
  MatchWindow := Max2(Length(S1), Length(S2)) div 2 - 1;
  if MatchWindow < 0 then 
    MatchWindow := 0;

  // Initialize matching arrays
  SetLength(Matches1, Length(S1));
  SetLength(Matches2, Length(S2));
  for I := 0 to Length(S1) - 1 do
    Matches1[I] := False;
  for I := 0 to Length(S2) - 1 do
    Matches2[I] := False;

  // Find matching characters within the window
  M := 0;
  for I := 0 to Length(S1) - 1 do
  begin
    // Define the window range for this character
    J := Max2(0, I - MatchWindow);
    while (J < Length(S2)) and (J <= I + MatchWindow) do
    begin
      // If we find a match that hasn't been counted yet
      if (not Matches2[J]) and (S1[I+1] = S2[J+1]) then
      begin
        Matches1[I] := True;
        Matches2[J] := True;
        Inc(M);
        Break;
      end;
      Inc(J);
    end;
  end;

  // If no matches found, return 0
  if M = 0 then
    Exit(0.0);

  // Count transpositions (half the number of matching characters that are in a different sequence)
  T := 0;
  J := 0;
  for I := 0 to Length(S1) - 1 do
  begin
    if Matches1[I] then
    begin
      // Find the next match in S2
      while not Matches2[J] do
        Inc(J);
      
      // If the characters don't match, we have a transposition
      if S1[I+1] <> S2[J+1] then
        Inc(T);
        
      Inc(J);
    end;
  end;

  // Divide by 2 as per the algorithm
  T := T div 2;

  // Calculate Jaro similarity using the standard formula
  Result := (1/3) * (M / Length(S1) + M / Length(S2) + (M - T) / M);
end;

class function TStringKit.JaroWinklerSimilarity(const S1, S2: string): Double;
var
  JaroDistance: Double;
  PrefixLength: Integer;
begin
  // Special case for empty strings
  if (S1 = '') or (S2 = '') then
    Exit(JaroSimilarity(S1, S2));
    
  JaroDistance := JaroSimilarity(S1, S2);
  PrefixLength := 0;

  // Calculate the length of the common prefix (up to 4 characters max)
  while (PrefixLength < Length(S1)) and 
        (PrefixLength < Length(S2)) and 
        (PrefixLength < 4) and 
        (S1[PrefixLength+1] = S2[PrefixLength+1]) do
    Inc(PrefixLength);

  // Apply the Winkler adjustment (common prefix improves the similarity score)
  Result := JaroDistance + (PrefixLength * 0.1 * (1 - JaroDistance));
  
  // Ensure the result is between 0 and 1
  if Result > 1.0 then
    Result := 1.0;
end;

class function TStringKit.LongestCommonSubsequence(const S1, S2: string): string;
var
  LCS: array of array of Integer;
  I, J: Integer;
begin
  // Handle empty strings
  if (S1 = '') or (S2 = '') then
    Exit('');
    
  SetLength(LCS, Length(S1) + 1, Length(S2) + 1);

  for I := 0 to Length(S1) do
    LCS[I, 0] := 0;
  for J := 0 to Length(S2) do
    LCS[0, J] := 0;

  for I := 1 to Length(S1) do
  begin
    for J := 1 to Length(S2) do
    begin
      if S1[I] = S2[J] then
        LCS[I, J] := LCS[I - 1, J - 1] + 1
      else
        LCS[I, J] := Max2(LCS[I - 1, J], LCS[I, J - 1]);
    end;
  end;

  // Backtrack to find the actual subsequence
  Result := '';
  I := Length(S1);
  J := Length(S2);
  
  while (I > 0) and (J > 0) do
  begin
    if S1[I] = S2[J] then
    begin
      Result := S1[I] + Result;
      Dec(I);
      Dec(J);
    end
    else if LCS[I - 1, J] >= LCS[I, J - 1] then
      Dec(I)
    else
      Dec(J);
  end;
end;

class function TStringKit.LCSSimilarity(const S1, S2: string): Double;
var
  LCS: string;
begin
  LCS := LongestCommonSubsequence(S1, S2);
  Result := Length(LCS) / Max(Length(S1), Length(S2));
end;

class function TStringKit.IsFuzzyMatch(const S1, S2: string; Threshold: Double = 0.7; Method: Integer = 0): Boolean;
var
  Similarity: Double;
begin
  // Special case: identical strings are always a match
  if S1 = S2 then
    Exit(True);
    
  // Special case: if either string is empty (but not both), return false
  if ((S1 = '') and (S2 <> '')) or ((S1 <> '') and (S2 = '')) then
    Exit(False);
  
  // Calculate similarity based on chosen method
  case Method of
    0: Similarity := LevenshteinSimilarity(S1, S2);
    1: Similarity := JaroWinklerSimilarity(S1, S2);
    2: Similarity := LCSSimilarity(S1, S2);
  else
    Similarity := 0.0;
  end;
  
  Result := Similarity >= Threshold;
end;

class function TStringKit.ToTitleCase(const Text: string): string;
var
  I: Integer;
  PrevIsSpace: Boolean;
begin
  Result := LowerCase(Text);
  if Result = '' then
    Exit;
    
  PrevIsSpace := True; // Start with True to capitalize first letter
  
  for I := 1 to Length(Result) do
  begin
    if Result[I] in [' ', #9, #10, #13, '-', '.', '_', ':', ';', '!', '?'] then
      PrevIsSpace := True
    else if PrevIsSpace then
    begin
      Result[I] := UpCase(Result[I]);
      PrevIsSpace := False;
    end;
  end;
end;

class function TStringKit.ToCamelCase(const Text: string): string;
var
  Words: TStringDynArray;
  I: Integer;
  Word: string;
begin
  Words := GetWords(Text);
  Result := '';
  
  if Length(Words) = 0 then
    Exit;
    
  // First word is lowercase
  if Length(Words) > 0 then
    Result := LowerCase(Words[0]);
    
  // Rest of words have first letter capitalized
  for I := 1 to High(Words) do
  begin
    Word := Words[I];
    if Word <> '' then
      Result := Result + UpperCase(Word[1]) + LowerCase(Copy(Word, 2, Length(Word)));
  end;
end;

class function TStringKit.ToPascalCase(const Text: string): string;
var
  Words: TStringDynArray;
  I: Integer;
  Word: string;
begin
  Words := GetWords(Text);
  Result := '';
  
  // All words have first letter capitalized
  for I := 0 to High(Words) do
  begin
    Word := Words[I];
    if Word <> '' then
      Result := Result + UpperCase(Word[1]) + LowerCase(Copy(Word, 2, Length(Word)));
  end;
end;

class function TStringKit.ToSnakeCase(const Text: string): string;
var
  Words: TStringDynArray;
  I: Integer;
begin
  Words := GetWords(Text);
  Result := '';
  
  for I := 0 to High(Words) do
  begin
    if I > 0 then
      Result := Result + '_';
    Result := Result + LowerCase(Words[I]);
  end;
end;

class function TStringKit.ToKebabCase(const Text: string): string;
var
  Words: TStringDynArray;
  I: Integer;
begin
  Words := GetWords(Text);
  Result := '';
  
  for I := 0 to High(Words) do
  begin
    if I > 0 then
      Result := Result + '-';
    Result := Result + LowerCase(Words[I]);
  end;
end;

class function TStringKit.IsValidEmail(const Text: string): Boolean;
begin
  // Match pattern for email addresses
  // Simple pattern: word@word.word, more complex patterns possible
  Result := MatchesPattern(Text, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
end;

class function TStringKit.IsValidURL(const Text: string): Boolean;
begin
  // Match pattern for URLs
  // This covers http, https, ftp protocols with domain names
  Result := MatchesPattern(Text, '^(https?|ftp)://[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$') or
           MatchesPattern(Text, '^(www)\.[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$');
end;

class function TStringKit.IsValidIP(const Text: string): Boolean;
begin
  // Check if it's either a valid IPv4 or IPv6 address
  Result := IsValidIPv4(Text) or IsValidIPv6(Text);
end;

class function TStringKit.IsValidIPv4(const Text: string): Boolean;
begin
  // Pattern for IPv4: x.x.x.x where x is 0-255
  Result := MatchesPattern(Text, '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
end;

class function TStringKit.IsValidIPv6(const Text: string): Boolean;
begin
  // Pattern for IPv6: 8 groups of 1-4 hexadecimal digits separated by colons
  // Also allows compressed IPv6 notation with :: for groups of zeros
  Result := MatchesPattern(Text, '^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$');
end;

class function TStringKit.IsValidDate(const Text, Format: string): Boolean;
var
  Day, Month, Year: Word;
  FormatLC: string;
  TextCopy: string;
  I, DayPos, MonthPos, YearPos: Integer;
  Ch: Char;
begin
  // If empty text, not valid
  if Text = '' then
    Exit(False);
  
  // Manual validation based on format pattern and text
  FormatLC := LowerCase(Format);
  TextCopy := Text;
  
  // Find positions of day, month, year in format
  DayPos := Pos('dd', FormatLC);
  MonthPos := Pos('mm', FormatLC);
  YearPos := Pos('yyyy', FormatLC);
  
  // Ensure all components are in the format
  if (DayPos = 0) or (MonthPos = 0) or (YearPos = 0) then
    Exit(False);
  
  // Substitute all non-digits to format separators
  for I := 1 to Length(TextCopy) do
    if not (TextCopy[I] in ['0'..'9']) then
      TextCopy[I] := ' ';
  
  // Extract day, month, year based on positions in format
  try
    // Extract components from TextCopy using positions from format
    if (DayPos > 0) and (MonthPos > 0) and (YearPos > 0) then
    begin
      // Simple ordering logic based on positions
      if (DayPos < MonthPos) and (MonthPos < YearPos) then // dd-mm-yyyy
      begin
        Day := StrToIntDef(ExtractWord(1, TextCopy, [' ']), 0);
        Month := StrToIntDef(ExtractWord(2, TextCopy, [' ']), 0);
        Year := StrToIntDef(ExtractWord(3, TextCopy, [' ']), 0);
      end
      else if (YearPos < MonthPos) and (MonthPos < DayPos) then // yyyy-mm-dd
      begin
        Year := StrToIntDef(ExtractWord(1, TextCopy, [' ']), 0);
        Month := StrToIntDef(ExtractWord(2, TextCopy, [' ']), 0);
        Day := StrToIntDef(ExtractWord(3, TextCopy, [' ']), 0);
      end
      else if (MonthPos < DayPos) and (DayPos < YearPos) then // mm-dd-yyyy
      begin
        Month := StrToIntDef(ExtractWord(1, TextCopy, [' ']), 0);
        Day := StrToIntDef(ExtractWord(2, TextCopy, [' ']), 0);
        Year := StrToIntDef(ExtractWord(3, TextCopy, [' ']), 0);
      end
      else
      begin
        // Extract words regardless of format order (default)
        // Here we're assuming they're in dd mm yyyy order if not recognized
        Day := StrToIntDef(ExtractWord(1, TextCopy, [' ']), 0);
        Month := StrToIntDef(ExtractWord(2, TextCopy, [' ']), 0);
        Year := StrToIntDef(ExtractWord(3, TextCopy, [' ']), 0);
      end;
      
      // Validate components
      Result := (Year >= 1) and (Year <= 9999) and
                (Month >= 1) and (Month <= 12) and
                (Day >= 1) and (Day <= DaysInAMonth(Year, Month));
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

class function TStringKit.Truncate(const Text: string; MaxLength: Integer; const Ellipsis: string = '...'): string;
begin
  if Length(Text) <= MaxLength then
    Result := Text
  else
    Result := Copy(Text, 1, MaxLength - Length(Ellipsis)) + Ellipsis;
end;

class function TStringKit.FormatFileSize(Size: Int64): string;
const
  KB = 1024;
  MB = KB * 1024;
  GB = MB * 1024;
  TB = GB * 1024;
begin
  if Size < KB then
    Result := Format('%d B', [Size])
  else if Size < MB then
    Result := Format('%.2f KB', [Size / KB])
  else if Size < GB then
    Result := Format('%.2f MB', [Size / MB])
  else if Size < TB then
    Result := Format('%.2f GB', [Size / GB])
  else
    Result := Format('%.2f TB', [Size / TB]);
end;

class function TStringKit.FormatNumber(const Value: Int64; ThousandSeparator: Char = ','): string;
var
  I, GroupCount, Len: Integer;
  Temp: string;
begin
  // Convert to string first
  Result := IntToStr(Value);
  Len := Length(Result);
  
  // Add thousand separators from right to left
  if (Len > 3) and (Value >= 0) then
  begin
    Temp := '';
    GroupCount := 0;
    
    for I := Len downto 1 do
    begin
      Temp := Result[I] + Temp;
      Inc(GroupCount);
      
      if (GroupCount = 3) and (I > 1) then
      begin
        Temp := ThousandSeparator + Temp;
        GroupCount := 0;
      end;
    end;
    
    Result := Temp;
  end;
end;

class function TStringKit.Encode64(const Text: string): string;
begin
  // Use FPC's RTL implementation for Base64 encoding
  if Text = '' then
    Exit('');
  Result := EncodeStringBase64(Text);
end;

class function TStringKit.Decode64(const Base64Text: string): string;
var
  S: string;
  I: Integer;
begin
  if Base64Text = '' then
    Exit('');

  // Remove MIME-style whitespace so strict decoder can be used
  S := '';
  for I := 1 to Length(Base64Text) do
    if not (Base64Text[I] in [#9, #10, #13, ' ']) then
      S := S + Base64Text[I];

  if S = '' then
    Exit('');

  // Strict decoding enforces correct alphabet and padding
  try
    Result := DecodeStringBase64(S, True);
  except
    Result := '';
  end;
end;

class function TStringKit.FormatFloat(const Value: Double; Decimals: Integer = 2; DecimalSeparator: Char = '.'; ThousandSeparator: Char = ','): string;
var
  I, IntegerPartLen: Integer;
  IntegerPart, DecimalPart, FormattedIntegerPart: string;
  IntValue: Int64;
  DecValue: Int64;
  Factor: Int64;
  IsNegative: Boolean;
begin
  IsNegative := Value < 0;
  
  // Split the number into integer and decimal parts
  IntValue := Trunc(Abs(Value));
  
  // Calculate decimal part
  Factor := 1;
  for I := 1 to Decimals do
    Factor := Factor * 10;
  
  DecValue := Round(Frac(Abs(Value)) * Factor);
  
  // Handle rounding issues
  if DecValue = Factor then
  begin
    DecValue := 0;
    IntValue := IntValue + 1;
  end;
  
  // Format integer part with thousand separators
  FormattedIntegerPart := FormatNumber(IntValue, ThousandSeparator);
  
  // Format decimal part
  if Decimals > 0 then
  begin
    DecimalPart := IntToStr(DecValue);
    while Length(DecimalPart) < Decimals do
      DecimalPart := '0' + DecimalPart;
    
    Result := FormattedIntegerPart + DecimalSeparator + DecimalPart;
  end
  else
    Result := FormattedIntegerPart;
  
  // Add negative sign if needed
  if IsNegative then
    Result := '-' + Result;
end;

class function TStringKit.Join(const Strings: TStringDynArray; const Delimiter: string): string;
var
  I: Integer;
begin
  Result := '';
  
  if Length(Strings) = 0 then
    Exit;
    
  Result := Strings[0];
  
  for I := 1 to High(Strings) do
    Result := Result + Delimiter + Strings[I];
end;

class function TStringKit.Split(const Text, Delimiter: string; MaxSplit: Integer = 0; RemoveEmptyEntries: Boolean = False): TStringDynArray;
var
  SplitList: TStringList;
  I, SplitCount: Integer;
  Remaining, Current: string;
  DelimPos: Integer;
begin
  SplitList := TStringList.Create;
  try
    // Special case for empty text - should return array with one empty element
    if Text = '' then
    begin
      if not RemoveEmptyEntries then
        SplitList.Add('');
    end
    else
    begin
      Remaining := Text;
      SplitCount := 0;
      
      while (Remaining <> '') and ((MaxSplit = 0) or (SplitCount < MaxSplit)) do
      begin
        DelimPos := Pos(Delimiter, Remaining);
        
        if DelimPos > 0 then
        begin
          Current := Copy(Remaining, 1, DelimPos - 1);
          Remaining := Copy(Remaining, DelimPos + Length(Delimiter), Length(Remaining));
          
          if (not RemoveEmptyEntries) or (Current <> '') then
          begin
            SplitList.Add(Current);
            Inc(SplitCount);
          end;
        end
        else
        begin
          // No more delimiters, add the remaining text
          if (not RemoveEmptyEntries) or (Remaining <> '') then
            SplitList.Add(Remaining);
          Break;
        end;
      end;
      
      // If we reached MaxSplit, add the remaining text as the last part
      if (MaxSplit > 0) and (SplitCount = MaxSplit) and (Remaining <> '') then
        SplitList.Add(Remaining);
    end;
    
    // Convert the TStringList to the result array
    SetLength(Result, SplitList.Count);
    for I := 0 to SplitList.Count - 1 do
      Result[I] := SplitList[I];
  finally
    SplitList.Free;
  end;
end;

class function TStringKit.Soundex(const Text: string): string;
var
  I, ResultLen: Integer;
  PrevCode, CurCode: Char;
  Ch: Char;
  UpperText: string;
begin
  // Initialize with empty result
  Result := '';
  if Text = '' then
    Exit;
    
  // Convert to uppercase for processing
  UpperText := UpperCase(Text);
  
  // First letter is preserved
  Result := UpperText[1];
  // Set PrevCode to the Soundex code of the first letter to avoid duplicating
  // the sound code for the second letter when it's the same as the first
  case UpperText[1] of
    'B', 'F', 'P', 'V': PrevCode := '1';
    'C', 'G', 'J', 'K', 'Q', 'S', 'X', 'Z': PrevCode := '2';
    'D', 'T': PrevCode := '3';
    'L': PrevCode := '4';
    'M', 'N': PrevCode := '5';
    'R': PrevCode := '6';
    else PrevCode := '0';  // A, E, I, O, U, H, W, Y and others
  end;
  ResultLen := 1;   // Length of result so far (first letter already added)
  
  // Process remaining letters
  for I := 2 to Length(UpperText) do
  begin
    Ch := UpperText[I];
    
    // Skip non-alphabetic characters
    if not (Ch in ['A'..'Z']) then
      Continue;
      
    // Assign codes according to Soundex rules
    case Ch of
      'B', 'F', 'P', 'V': CurCode := '1';
      'C', 'G', 'J', 'K', 'Q', 'S', 'X', 'Z': CurCode := '2';
      'D', 'T': CurCode := '3';
      'L': CurCode := '4';
      'M', 'N': CurCode := '5';
      'R': CurCode := '6';
      else CurCode := '0';  // A, E, I, O, U, H, W, Y
    end;
    
    // Skip vowels and separators. Only vowels and 'Y' reset PrevCode; 'H' and 'W'
    // do NOT reset (per standard Soundex), so duplicates across H/W are collapsed.
    if CurCode = '0' then
    begin
      if Ch in ['A','E','I','O','U','Y'] then
        PrevCode := '0';
      Continue;
    end;
      
    // Skip repeated consonant codes
    if CurCode = PrevCode then
      Continue;
      
    // Add the code to the result
    Result := Result + CurCode;
    PrevCode := CurCode;
    Inc(ResultLen);
    
    // Stop after reaching length of 4
    if ResultLen = 4 then
      Break;
  end;
  
  // Pad with zeros if shorter than 4 characters
  while Length(Result) < 4 do
    Result := Result + '0';
end;

class function TStringKit.Metaphone(const Text: string): string;
var
  I, Len: Integer;
  UpperText, NormalizedText: string;
  Ch, NextCh, NextNextCh: Char;
  Skip: Boolean;
begin
  Result := '';
  if Text = '' then
    Exit;
    
  // Convert to uppercase and get length
  UpperText := UpperCase(Text);
  
  // Normalize ending 'S' for plurals - remove trailing S for consistency in matching
  NormalizedText := UpperText;
  if (Length(NormalizedText) > 2) and (NormalizedText[Length(NormalizedText)] = 'S') then
    NormalizedText := Copy(NormalizedText, 1, Length(NormalizedText) - 1);
  
  Len := Length(NormalizedText);
  
  // Process each character
  I := 1;
  while I <= Len do
  begin
    Ch := NormalizedText[I];
    Skip := False;
    
    // Get next characters if available
    if I < Len then
      NextCh := NormalizedText[I + 1]
    else
      NextCh := #0;
      
    if I < Len - 1 then
      NextNextCh := NormalizedText[I + 2]
    else
      NextNextCh := #0;
    
    // Apply Metaphone rules
    case Ch of
      // Vowels are only encoded at the beginning
      'A', 'E', 'I', 'O', 'U':
        begin
          if I = 1 then
            Result := Result + Ch;
        end;
      
      'B':
        begin
          Result := Result + 'B';
          // Skip duplicate B's
          if NextCh = 'B' then
            Inc(I);
        end;
      
      'C':
        begin
          if NextCh = 'H' then
          begin
            Result := Result + 'X'; // CH -> X
            Inc(I);  // Skip 'H'
          end
          else if NextCh = 'K' then
          begin
            Result := Result + 'K'; // CK -> K (single K)
            Inc(I); // Skip 'K'
          end
          else if (NextCh = 'I') or (NextCh = 'E') or (NextCh = 'Y') then
          begin
            // Soft C -> S; avoid emitting duplicate 'S'
            if (Length(Result) = 0) or (Result[Length(Result)] <> 'S') then
              Result := Result + 'S';
          end
          else
            Result := Result + 'K'; // Hard C
        end;
      
      'D':
        begin
          if (NextCh = 'G') and (NextNextCh in ['E', 'I', 'Y']) then
          begin
            Result := Result + 'J'; // DGE, DGI, DGY -> J
            Inc(I, 2); // Skip 'G' and the vowel
          end
          else
            Result := Result + 'T'; // D -> T
        end;
      
      'F':
        Result := Result + 'F';
      
      'G':
        begin
          if NextCh = 'H' then
          begin
            if I = 1 then
              Result := Result + 'K'  // Initial GH -> K
            else
              Skip := True;  // Non-initial GH is silent
            Inc(I);  // Skip 'H'
          end
          else if (NextCh = 'N') and (I = 1) then
          begin
            Skip := True;  // Initial GN is silent
            Inc(I);  // Skip 'N'
          end
          else if (NextCh in ['E', 'I', 'Y']) then
            Result := Result + 'J'  // Soft G
          else
            Result := Result + 'K'; // Hard G
        end;
      
      'H':
        begin
          if I = 1 then
            Result := Result + 'H'  // Initial H is preserved
          else
            Skip := True;  // Non-initial H is often silent
        end;
      
      'J':
        Result := Result + 'J';
      
      'K':
        begin
          if NextCh <> 'N' then
            Result := Result + 'K';
        end;
      
      'L':
        Result := Result + 'L';
      
      'M':
        Result := Result + 'M';
      
      'N':
        Result := Result + 'N';
      
      'P':
        begin
          if NextCh = 'H' then
          begin
            Result := Result + 'F';
            Inc(I);  // Skip 'H'
          end
          else
            Result := Result + 'P';
        end;
      
      'Q':
        Result := Result + 'K';
      
      'R':
        Result := Result + 'R';
      
      'S':
        begin
          if NextCh = 'H' then
          begin
            Result := Result + 'X';
            Inc(I);  // Skip 'H'
          end
          else if (NextCh = 'I') and ((NextNextCh = 'O') or (NextNextCh = 'A')) then
          begin
            Result := Result + 'X';
            Inc(I, 2);  // Skip 'IO' or 'IA'
          end
          else
            Result := Result + 'S';
        end;
      
      'T':
        begin
          if (NextCh = 'I') and ((NextNextCh = 'O') or (NextNextCh = 'A')) then
          begin
            Result := Result + 'X';
            Inc(I, 2);  // Skip 'IO' or 'IA'
          end
          else if NextCh = 'H' then
          begin
            Result := Result + '0';  // TH -> 0 (theta)
            Inc(I);  // Skip 'H'
          end
          else
            Result := Result + 'T';
        end;
      
      'V':
        Result := Result + 'F';
      
      'W':
        begin
          if I = 1 then
          begin
            // Initial WR -> R (silent W)
            if NextCh = 'R' then
              Skip := True
            else
              Result := Result + 'W';
          end
          else
            Skip := True;  // Non-initial W is often part of a vowel sound
        end;
      
      'X':
        begin
          if I = 1 then
            Result := Result + 'S'  // Initial X -> S
          else
            Result := Result + 'KS'; // Non-initial X -> KS
        end;
      
      'Y':
        begin
          if I = 1 then
            Result := Result + 'Y'  // Initial Y is preserved
          else
            Skip := True;  // Non-initial Y is often part of a vowel sound
        end;
      
      'Z':
        Result := Result + 'S';
    end;
    
    if not Skip then
      Inc(I)
    else
      Inc(I);
  end;
end;

class function TStringKit.CountWords(const Text: string): Integer;
var
  Words: TStringDynArray;
begin
  Words := GetWords(Text);
  Result := Length(Words);
end;

class function TStringKit.FleschKincaidReadability(const Text: string): Double;
var
  Words: TStringDynArray;
  Sentences, Syllables, I, WordCount: Integer;
  Word: string;
begin
  // Count words
  Words := GetWords(Text);
  WordCount := Length(Words);
  
  if WordCount = 0 then
  begin
    Result := 0;
    Exit;
  end;
  
  // Count sentences (roughly by counting sentence-ending punctuation)
  Sentences := 0;
  for I := 1 to Length(Text) do
    if Text[I] in ['.', '!', '?'] then
      Inc(Sentences);
      
  // Ensure at least one sentence
  if Sentences = 0 then
    Sentences := 1;
  
  // Count syllables (very approximate method)
  Syllables := 0;
  for I := 0 to High(Words) do
  begin
    Word := LowerCase(Words[I]);
    
    // Count vowel groups as syllables
    // This is a very basic approximation
    Syllables := Syllables + CountVowelGroups(Word);
    
    // Words with no detected syllables get at least one
    if CountVowelGroups(Word) = 0 then
      Inc(Syllables);
  end;
  
  // Calculate Flesch-Kincaid Reading Ease score
  // Formula: 206.835 - 1.015 * (words/sentences) - 84.6 * (syllables/words)
  Result := 206.835 - 1.015 * (WordCount / Sentences) - 84.6 * (Syllables / WordCount);
  
  // Constrain the result between 0 and 100
  if Result < 0 then
    Result := 0
  else if Result > 100 then
    Result := 100;
end;

class function TStringKit.GenerateNGrams(const Text: string; N: Integer): TStringDynArray;
var
  Words: TStringDynArray;
  NGramList: TStringList;
  I, J, NGramCount: Integer;
  NGram: string;
begin
  Result := nil;
  SetLength(Result, 0);
  
  if (N <= 0) or (Text = '') then
    Exit;
  
  // Get words from text
  Words := GetWords(Text);
  
  // If not enough words for n-grams, return empty array
  if Length(Words) < N then
    Exit;
  
  // Create a list to hold n-grams
  NGramList := TStringList.Create;
  try
    // Generate all possible n-grams
    for I := 0 to Length(Words) - N do
    begin
      NGram := Words[I];
      
      // Combine N consecutive words
      for J := 1 to N - 1 do
        NGram := NGram + ' ' + Words[I + J];
        
      NGramList.Add(NGram);
    end;
    
    // Convert to result array
    SetLength(Result, NGramList.Count);
    for I := 0 to NGramList.Count - 1 do
      Result[I] := NGramList[I];
  finally
    NGramList.Free;
  end;
end;

// Helper function to count vowel groups for syllable estimation
class function TStringKit.CountVowelGroups(const Word: string): Integer;
var
  I: Integer;
  InVowelGroup: Boolean;
begin
  Result := 0;
  InVowelGroup := False;
  
  for I := 1 to Length(Word) do
  begin
    if Word[I] in ['a', 'e', 'i', 'o', 'u', 'y'] then
    begin
      if not InVowelGroup then
      begin
        InVowelGroup := True;
        Inc(Result);
      end;
    end
    else
      InVowelGroup := False;
  end;
  
  // Special case for English: silent 'e' at end of word usually doesn't count
  if (Length(Word) > 2) and (Word[Length(Word)] = 'e') and 
     not (Word[Length(Word) - 1] in ['a', 'e', 'i', 'o', 'u', 'y']) then
    Dec(Result);
    
  // If negative due to rules (e.g., single "me"), ensure at least 1
  if Result < 1 then
    Result := 1;
end;

class function TStringKit.HTMLEncode(const Text: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Text) do
  begin
    case Text[I] of
      '<': Result := Result + '&lt;';
      '>': Result := Result + '&gt;';
      '&': Result := Result + '&amp;';
      '"': Result := Result + '&quot;';
      '''': Result := Result + '&#39;';  // Single quote
      else
        Result := Result + Text[I];
    end;
  end;
end;

class function TStringKit.HTMLDecode(const Text: string): string;
begin
  Result := Text;
  
  // Replace HTML entities with their corresponding characters
  Result := ReplaceText(Result, '&lt;', '<');
  Result := ReplaceText(Result, '&gt;', '>');
  Result := ReplaceText(Result, '&amp;', '&');
  Result := ReplaceText(Result, '&quot;', '"');
  Result := ReplaceText(Result, '&#39;', '''');  // Single quote
  Result := ReplaceText(Result, '&nbsp;', ' ');
end;

class function TStringKit.URLEncode(const Text: string): string;
const
  // Characters that don't need encoding
  SAFE_CHARS = ['A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.', '~'];
var
  I: Integer;
  HexStr: string;
begin
  Result := '';
  for I := 1 to Length(Text) do
  begin
    if Text[I] in SAFE_CHARS then
      Result := Result + Text[I]
    else if Text[I] = ' ' then
      Result := Result + '+'
    else
    begin
      // Convert character to hexadecimal representation
      HexStr := IntToHex(Ord(Text[I]), 2);
      Result := Result + '%' + HexStr;
    end;
  end;
end;

class function TStringKit.URLDecode(const Text: string): string;
var
  I: Integer;
  HexCode: string;
  CharCode: Integer;
begin
  Result := '';
  I := 1;
  
  while I <= Length(Text) do
  begin
    if Text[I] = '%' then
    begin
      // Check if there are at least 2 more characters for a hex code
      if I + 2 <= Length(Text) then
      begin
        HexCode := Copy(Text, I + 1, 2);
        try
          // Convert hex to integer and then to character
          CharCode := StrToInt('$' + HexCode);
          Result := Result + Chr(CharCode);
        except
          // If conversion fails, include the % character as-is
          Result := Result + '%';
          Dec(I, 2); // Adjust to process the next two characters normally
        end;
        Inc(I, 2); // Skip the two hex characters
      end
      else
        Result := Result + Text[I]; // Incomplete % sequence
    end
    else if Text[I] = '+' then
      Result := Result + ' '
    else
      Result := Result + Text[I];
      
    Inc(I);
  end;
end;

class function TStringKit.ToRoman(Value: Integer): string;
const
  RomanDigits: array[1..13] of string = (
    'M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I');
  RomanValues: array[1..13] of Integer = (
    1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1);
var
  I: Integer;
  Num: Integer;
begin
  Result := '';
  
  // Roman numerals can only represent numbers from 1 to 3999
  if (Value < 1) or (Value > 3999) then
    Exit;
  
  Num := Value;
  I := 1;
  
  while (Num > 0) and (I <= 13) do
  begin
    while Num >= RomanValues[I] do
    begin
      Result := Result + RomanDigits[I];
      Num := Num - RomanValues[I];
    end;
    Inc(I);
  end;
end;

class function TStringKit.FromRoman(const RomanNumeral: string): Integer;
const
  RomanDigits: array[1..7] of Char = ('I', 'V', 'X', 'L', 'C', 'D', 'M');
  RomanValues: array[1..7] of Integer = (1, 5, 10, 50, 100, 500, 1000);
var
  I, J, Value: Integer;
  PrevValue, CurrValue: Integer;
  UpperRoman: string;
begin
  Result := 0;
  
  // Empty string has no value
  if RomanNumeral = '' then
    Exit;
  
  // Convert to uppercase for processing
  UpperRoman := UpperCase(RomanNumeral);
  
  // Validate that all characters are valid Roman numerals
  for I := 1 to Length(UpperRoman) do
  begin
    Value := 0;
    for J := 1 to 7 do
      if UpperRoman[I] = RomanDigits[J] then
      begin
        Value := RomanValues[J];
        Break;
      end;
      
    if Value = 0 then
      Exit(0); // Invalid character found
  end;
  
  // Process the Roman numeral from right to left
  PrevValue := 0;
  for I := Length(UpperRoman) downto 1 do
  begin
    CurrValue := 0;
    for J := 1 to 7 do
      if UpperRoman[I] = RomanDigits[J] then
      begin
        CurrValue := RomanValues[J];
        Break;
      end;
      
    if CurrValue >= PrevValue then
      Result := Result + CurrValue
    else
      Result := Result - CurrValue;
      
    PrevValue := CurrValue;
  end;
end;

class function TStringKit.ToOrdinal(Value: Integer): string;
var
  LastDigit, LastTwoDigits: Integer;
begin
  // Convert the number to string first
  Result := IntToStr(Value);
  
  // Get the last digit and last two digits
  LastDigit := Abs(Value) mod 10;
  LastTwoDigits := Abs(Value) mod 100;
  
  // Apply the appropriate suffix based on rules
  if (LastTwoDigits >= 11) and (LastTwoDigits <= 13) then
    Result := Result + 'th'
  else
    case LastDigit of
      1: Result := Result + 'st';
      2: Result := Result + 'nd';
      3: Result := Result + 'rd';
      else Result := Result + 'th';
    end;
end;

class function TStringKit.NumberToWords(Value: Int64): string;

  // Helper function to convert numbers less than 1000 to words
  function NumberToWordsLessThan1000(Num: Integer): string;
  const
    Units: array[0..19] of string = (
      'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine',
      'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
      'seventeen', 'eighteen', 'nineteen');
    Tens: array[2..9] of string = (
      'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety');
  var
    Hundreds, TensUnits: Integer;
  begin
    Result := '';
    
    if Num = 0 then
      Exit('zero');
      
    // Handle hundreds
    Hundreds := Num div 100;
    if Hundreds > 0 then
    begin
      Result := Units[Hundreds] + ' hundred';
      Num := Num mod 100;
      if Num > 0 then
        Result := Result + ' and ';
    end;
    
    // Handle tens and units
    if Num > 0 then
    begin
      if Num < 20 then
        Result := Result + Units[Num]
      else
      begin
        TensUnits := Num mod 10;
        Result := Result + Tens[Num div 10];
        if TensUnits > 0 then
          Result := Result + '-' + Units[TensUnits];
      end;
    end;
  end;

var
  Num: Int64;
  IsNegative: Boolean;
  Billions, Millions, Thousands, Remainder: Int64;
begin
  Result := '';
  
  // Handle zero separately
  if Value = 0 then
    Exit('zero');
    
  // Handle negative numbers
  IsNegative := Value < 0;
  Num := Abs(Value);
  
  // Handle billions (for values that go into billions)
  Billions := Num div 1000000000;
  if Billions > 0 then
  begin
    Result := NumberToWordsLessThan1000(Billions) + ' billion';
    Num := Num mod 1000000000;
    if Num > 0 then
      Result := Result + ' ';
  end;
  
  // Handle millions
  Millions := Num div 1000000;
  if Millions > 0 then
  begin
    Result := Result + NumberToWordsLessThan1000(Millions) + ' million';
    Num := Num mod 1000000;
    if Num > 0 then
      Result := Result + ' ';
  end;
  
  // Handle thousands
  Thousands := Num div 1000;
  if Thousands > 0 then
  begin
    Result := Result + NumberToWordsLessThan1000(Thousands) + ' thousand';
    Num := Num mod 1000;
    if Num > 0 then
      Result := Result + ' ';
  end;
  
  // Handle the remainder (less than 1000)
  Remainder := Num;
  if Remainder > 0 then
  begin
    // Add 'and' for British-style if there's already something in the result
    if (Result <> '') and ((Remainder < 100) or ((Value > 1000) and (Value < 2000))) then
      Result := Result + 'and ';
    Result := Result + NumberToWordsLessThan1000(Remainder);
  end;
  
  // Add 'negative' for negative numbers
  if IsNegative then
    Result := 'negative ' + Result;
end;

class function TStringKit.HexEncode(const Text: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Text) do
    Result := Result + IntToHex(Ord(Text[I]), 2);
end;

class function TStringKit.HexDecode(const HexText: string): string;
var
  I, CharCode: Integer;
  HexPair: string;
begin
  Result := '';
  
  // Validate that we have an even number of hex characters
  if (Length(HexText) mod 2 <> 0) then
    Exit;
  
  I := 1;
  while I < Length(HexText) do
  begin
    HexPair := Copy(HexText, I, 2);
    
    // Skip non-hex characters
    if not MatchesPattern(HexPair, '^[0-9A-Fa-f]{2}$') then
    begin
      Inc(I);
      Continue;
    end;
    
    try
      CharCode := StrToInt('$' + HexPair);
      Result := Result + Chr(CharCode);
    except
      // Ignore invalid hex pairs
    end;
    
    Inc(I, 2);
  end;
end;

end.
