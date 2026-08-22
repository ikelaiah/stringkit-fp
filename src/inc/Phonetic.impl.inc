function TStringHelperEx.Soundex: string;
begin
  Result := TStringKit.Soundex(Self);
end;

function TStringHelperEx.Metaphone: string;
begin
  Result := TStringKit.Metaphone(Self);
end;

function TStringHelperEx.CountWords: Integer;
begin
  Result := TStringKit.CountWords(Self);
end;

function TStringHelperEx.FleschReadingEase: Double;
begin
  Result := TStringKit.FleschReadingEase(Self);
end;

function TStringHelperEx.FleschKincaidReadability: Double;
begin
  Result := TStringKit.FleschKincaidReadability(Self);
end;

function TStringHelperEx.FleschKincaidGradeLevel: Double;
begin
  Result := TStringKit.FleschKincaidGradeLevel(Self);
end;

function TStringHelperEx.GenerateNGrams(N: Integer): TStringDynArray;
begin
  Result := TStringKit.GenerateNGrams(Self, N);
end;
