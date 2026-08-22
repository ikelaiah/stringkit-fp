program TryHexDecode;

{$mode objfpc}{$H+}

uses
  StringKit;

var
  Decoded: string;
begin
  if TStringKit.TryHexDecode('48656C6C6F', Decoded) then
    Writeln(Decoded);
end.
