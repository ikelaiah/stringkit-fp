program FuzzyMatch;

{$mode objfpc}{$H+}

uses
  SysUtils,
  StringKit;

begin
  Writeln(BoolToStr(
    TStringKit.IsFuzzyMatch('colour', 'color', 0.75, fmLevenshtein), True));
end.
