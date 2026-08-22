program HtmlEncode;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.HTMLEncode('<b>Hello</b>'));
end.
