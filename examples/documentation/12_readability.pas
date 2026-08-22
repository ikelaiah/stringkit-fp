program Readability;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.FleschReadingEase('The cat sat on the mat.'):0:2);
end.
