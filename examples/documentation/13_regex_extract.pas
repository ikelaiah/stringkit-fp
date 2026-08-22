program RegexExtract;

{$mode objfpc}{$H+}

uses
  Types,
  StringKit;

var
  Matches: TStringDynArray;
  Index: Integer;
begin
  Matches := TStringKit.ExtractAllMatches('Order #42, then #7', '#\d+');
  for Index := 0 to High(Matches) do
    Writeln(Matches[Index]);
end.
