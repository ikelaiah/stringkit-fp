program IdentifierCases;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.ToSnakeCase('HelloWorld'));
  Writeln(TStringKit.ToPascalCase('snake_case'));
end.
