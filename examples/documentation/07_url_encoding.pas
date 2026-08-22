program UrlEncoding;

{$mode objfpc}{$H+}

uses
  StringKit;

begin
  Writeln(TStringKit.PercentEncode('a b+c'));
  Writeln(TStringKit.FormURLEncode('a b+c'));
end.
