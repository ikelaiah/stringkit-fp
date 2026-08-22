program ValidateIp;

{$mode objfpc}{$H+}

uses
  SysUtils,
  StringKit;

begin
  Writeln(BoolToStr(TStringKit.IsValidIPv4('192.168.0.1'), True));
  Writeln(BoolToStr(TStringKit.IsValidIPv6('2001:db8::1'), True));
end.
