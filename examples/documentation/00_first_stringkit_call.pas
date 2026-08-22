program FirstStringKitCall;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.ToSnakeCase('HelloWorld'));
end.
