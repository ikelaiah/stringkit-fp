function TStringHelperEx.ToRoman: string;
begin
  Result := TStringKit.ToRoman(StrToIntDef(Self, 0));
end;

function TStringHelperEx.ToOrdinal: string;
begin
  Result := TStringKit.ToOrdinal(StrToIntDef(Self, 0));
end;

function TStringHelperEx.NumberToWords: string;
begin
  Result := TStringKit.NumberToWords(StrToInt64Def(Self, 0));
end;

function TStringHelperEx.FromRoman: Integer;
begin
  Result := TStringKit.FromRoman(Self);
end;

function TStringHelperEx.TryFromRoman(out Value: Integer): Boolean;
begin
  Result := TStringKit.TryFromRoman(Self, Value);
end;
