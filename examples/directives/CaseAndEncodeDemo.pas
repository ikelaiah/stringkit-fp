program CaseAndEncodeDemo;

{$mode objfpc}{$H+}{$J-}

(* This demo showcases compiling StringKitHelper with SK_CASE and SK_ENCODE groups enabled.
   Build with FPC (from repo root):
     fpc -dSK_ANY -dSK_CASE -dSK_ENCODE -Fu./src ./examples/directives/CaseAndEncodeDemo.pas
*)

uses
  SysUtils,
  StringKitHelper; // helper-backed instance methods on string

var
  S: string;
begin
  // CASE group
  S := 'Hello World'.ToSnakeCase;            // hello_world
  WriteLn('Snake: ', S);
  S := 'hello world'.ToPascalCase;           // HelloWorld
  WriteLn('Pascal: ', S);

  // ENCODE group
  WriteLn('Base64: ', 'foo'.Encode64);       // Zm9v
  WriteLn('URL: ', 'Hello World!'.URLEncode); // Hello+World%21

  // Uncomment below to see a compile-time error when a group is not enabled
  // WriteLn('Levenshtein: ', 'kitten'.LevenshteinDistance('sitting')); // Requires SK_COMPARE
end.
