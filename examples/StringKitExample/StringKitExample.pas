program StringKitExample;

{$mode objfpc}{$H+}{$J-}
(* This example demonstrates the string manipulation capabilities of TStringKit class.
   It shows various string operations like:
   - Basic operations (trim, case conversion, etc)
   - Advanced operations (padding, reversing, etc)
   - Pattern matching and regular expressions
   - String analysis and information
   - String extraction and substring handling

   The example creates a TTextProcessor class that demonstrates each category
   of functionality with sample text input. *)

uses
  Classes, SysUtils, StringKit;

type
  (* TTextProcessor
     A class that demonstrates various string manipulation capabilities
     provided by TStringKit. Each method shows different aspects of
     string processing functionality. *)
  TTextProcessor = class
  private
    FText: string; // The sample text to process
  public
    constructor Create(const AText: string);
    procedure ProcessText;
    procedure ShowBasicOperations;     // Demonstrates basic string operations like trim, case conversion
    procedure ShowAdvancedOperations;  // Shows advanced operations like padding, reversing
    procedure ShowPatternMatching;     // Illustrates regex pattern matching capabilities
    procedure ShowStringAnalysis;      // Demonstrates string analysis functions
    procedure ShowStringExtraction;    // Shows string extraction and substring operations
  end;

// TTextProcessor

constructor TTextProcessor.Create(const AText: string);
begin
  FText := AText;
end;

procedure TTextProcessor.ShowBasicOperations;
begin
  // Demonstrates fundamental string operations available in TStringKit
  WriteLn('Basic String Operations:');
  WriteLn('----------------------');
  WriteLn('Original Text: "', FText, '"');
  WriteLn('Trimmed: "', TStringKit.Trim(FText), '"');                // Removes whitespace from both ends
  WriteLn('TrimLeft: "', TStringKit.TrimLeft(FText), '"');           // Removes leading whitespace
  WriteLn('TrimRight: "', TStringKit.TrimRight(FText), '"');         // Removes trailing whitespace
  WriteLn('Uppercase: ', TStringKit.ToUpper(FText));                 // Converts to uppercase
  WriteLn('Lowercase: ', TStringKit.ToLower(FText));                 // Converts to lowercase
  WriteLn('Capitalized: ', TStringKit.CapitalizeText(FText));        // Capitalizes first letter of each word
  WriteLn;
end;

procedure TTextProcessor.ShowAdvancedOperations;
begin
  // Shows more complex string manipulations
  WriteLn('Advanced String Operations:');
  WriteLn('-------------------------');
  WriteLn('Reversed: ', TStringKit.ReverseText(FText));                    // Reverses the entire string
  WriteLn('Duplicated (2x): ', TStringKit.DuplicateText(FText, 2));        // Repeats string twice
  WriteLn('Left Padded (30): ', TStringKit.PadLeft(FText, 30, '*'));       // Pads with * on the left to length 30
  WriteLn('Right Padded (30): ', TStringKit.PadRight(FText, 30, '*'));     // Pads with * on the right to length 30
  WriteLn('Center Padded (30): ', TStringKit.PadCenter(FText, 30, '*'));   // Centers text with * padding
  WriteLn('Collapsed Whitespace: ', TStringKit.CollapseWhitespace(FText)); // Reduces multiple spaces to single
  WriteLn('Removed Whitespace: ', TStringKit.RemoveWhitespace(FText));     // Removes all whitespace
  WriteLn('Replaced Text (Hello->Hi): ', TStringKit.ReplaceText(FText, 'Hello', 'Hi')); // Simple text replacement
  WriteLn;
end;

procedure TTextProcessor.ShowPatternMatching;
var
  EmailMatches: TMatchesResults;  // Stores detailed match information including position
  AllMatches: TStringArray;       // Stores just the matched strings
  I: Integer;
begin
  WriteLn('Pattern Matching:');
  WriteLn('-----------------');

  // Demonstrates email address extraction using regex
  EmailMatches := TStringKit.ExtractMatches(FText, '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b');
  WriteLn('Email Addresses Found:');
  if Length(EmailMatches) > 0 then
  begin
    for I := 0 to High(EmailMatches) do
      WriteLn('- ', EmailMatches[I].Text, ' (at position ', EmailMatches[I].Position, ')');
  end
  else
    WriteLn('No email addresses found.');

  // Shows how to extract all words from text
  AllMatches := TStringKit.ExtractAllMatches(FText, '\b\w+\b');
  WriteLn('All Words Found:');
  for I := 0 to High(AllMatches) do
    Write(AllMatches[I], ', ');
  WriteLn;

  // Simple pattern matching tests
  WriteLn('Contains email? ', TStringKit.MatchesPattern(FText, '@'));
  WriteLn('Contains number? ', TStringKit.MatchesPattern(FText, '\d+'));
  WriteLn;
end;

procedure TTextProcessor.ShowStringAnalysis;
begin
  // Demonstrates various string analysis functions
  WriteLn('String Analysis:');
  WriteLn('----------------');
  WriteLn('Length: ', TStringKit.GetLength(FText));                    // String length
  WriteLn('Is Empty? ', TStringKit.IsEmpty(FText));                    // Checks if string is empty
  WriteLn('Contains "Hello"? ', TStringKit.Contains(FText, 'Hello'));  // Substring search
  WriteLn('Starts with "The"? ', TStringKit.StartsWith(FText, 'The')); // Prefix check
  WriteLn('Ends with "!"? ', TStringKit.EndsWith(FText, '!'));         // Suffix check
  WriteLn('Count of "l": ', TStringKit.CountSubString(FText, 'l'));    // Counts occurrences
  WriteLn;
end;

procedure TTextProcessor.ShowStringExtraction;
var
  Words: TStringArray;  // Array to store individual words
  I: Integer;
begin
  // Shows various ways to extract parts of strings
  WriteLn('String Extraction:');
  WriteLn('-----------------');
  WriteLn('First 5 chars: ', TStringKit.LeftStr(FText, 5));        // Extract from start
  WriteLn('Last 5 chars: ', TStringKit.RightStr(FText, 5));        // Extract from end
  WriteLn('Substring (6,5): ', TStringKit.SubString(FText, 6, 5)); // Extract from middle

  // Demonstrates word extraction
  WriteLn('Words:');
  Words := TStringKit.GetWords(FText);
  for I := 0 to High(Words) do
    WriteLn('- ', Words[I]);
  WriteLn;
end;

procedure TTextProcessor.ProcessText;
begin
  // Main processing method that demonstrates all capabilities
  WriteLn('Processing Text Sample');
  WriteLn('====================');
  WriteLn;
  
  ShowBasicOperations;
  ShowAdvancedOperations;
  ShowPatternMatching;
  ShowStringAnalysis;
  ShowStringExtraction;
end;

var
  Processor: TTextProcessor;
  SampleText: string;

begin
  try
    // Create a sample text with various features to demonstrate capabilities
    SampleText :=
      '  The quick brown fox jumps over the lazy dog!  ' + LineEnding +
      'Contact us at support@example.com or info@hello.com for more information.' + LineEnding +
      'This is an    example   with    multiple    spaces and numbers 12345.';

    // Create and use the processor
    Processor := TTextProcessor.Create(SampleText);
    try
      Processor.ProcessText;
    finally
      Processor.Free;
    end;

    WriteLn('Press Enter to exit...');
    ReadLn;
  except
    on E: Exception do
    begin
      WriteLn('Error: ', E.Message);
      ExitCode := 1;
    end;
  end;
end. 
