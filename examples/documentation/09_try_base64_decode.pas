program TryBase64Decode;

{$mode objfpc}{$H+}

uses
  StringKit;

var
  Decoded: string;
begin
  if TStringKit.TryDecode64('SGVsbG8=', Decoded) then
    Writeln(Decoded);
end.
