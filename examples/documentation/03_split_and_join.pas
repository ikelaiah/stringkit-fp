program SplitAndJoin;

{$mode objfpc}{$H+}

uses
  Types,
  StringKit;

var
  Parts: TStringDynArray;
begin
  Parts := TStringKit.Split('red,green,blue', ',');
  Writeln(Length(Parts));
  Writeln(TStringKit.Join(Parts, ' | '));
end.
