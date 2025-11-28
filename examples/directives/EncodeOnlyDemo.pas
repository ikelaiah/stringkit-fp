program EncodeOnlyDemo;

{$mode objfpc}{$H+}{$J-}

(* This demo showcases compiling StringKitHelper with only the SK_ENCODE group enabled.
   Build with FPC (from repo root):
     fpc -dSK_ANY -dSK_ENCODE -Fu./src ./examples/directives/EncodeOnlyDemo.pas
*)

uses
  SysUtils,
  StringKitHelper; // instance-style helper only; no need to use StringKit static unit here

begin
  // Only ENCODE-related helpers are available when built with -dSK_ANY -dSK_ENCODE
  WriteLn('Base64 of "foo": ', 'foo'.Encode64);        // Zm9v
  WriteLn('URL Encoded: ', 'Hello World!'.URLEncode);   // Hello+World%21
  WriteLn('HTML Encoded: ', '<b>x</b>'.HTMLEncode);     // &lt;b&gt;x&lt;/b&gt;
  WriteLn('Hex Encoded: ', 'abc'.HexEncode);            // 616263

  // Uncomment below to see a compile-time error when a group is not enabled
  // WriteLn('Snake: ', 'Hello World'.ToSnakeCase);  // Requires SK_CASE (not enabled)
end.
