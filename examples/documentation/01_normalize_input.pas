program NormalizeInput;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.CollapseWhitespace(TStringKit.Trim('  Ada   Lovelace  ')));
end.
