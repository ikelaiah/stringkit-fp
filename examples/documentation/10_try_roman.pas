program TryRoman;

{$mode objfpc}{$H+}

uses
  StringKit;

var
  Value: Integer;
begin
  if TStringKit.TryFromRoman('MMXXVI', Value) then
    Writeln(Value);
end.
