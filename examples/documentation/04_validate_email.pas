program ValidateEmail;

{$mode objfpc}{$H+}

uses
  SysUtils,
  StringKit;

begin
  Writeln(BoolToStr(TStringKit.IsValidEmail('ada@example.com'), True));
end.
