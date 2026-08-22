function TStringHelperEx.LevenshteinDistance(const S: string): Integer;
begin
  Result := TStringKit.LevenshteinDistance(Self, S);
end;

function TStringHelperEx.LevenshteinSimilarity(const S: string): Double;
begin
  Result := TStringKit.LevenshteinSimilarity(Self, S);
end;

function TStringHelperEx.HammingDistance(const S: string): Integer;
begin
  Result := TStringKit.HammingDistance(Self, S);
end;

function TStringHelperEx.JaroSimilarity(const S: string): Double;
begin
  Result := TStringKit.JaroSimilarity(Self, S);
end;

function TStringHelperEx.JaroWinklerSimilarity(const S: string): Double;
begin
  Result := TStringKit.JaroWinklerSimilarity(Self, S);
end;

function TStringHelperEx.LongestCommonSubsequence(const S: string): string;
begin
  Result := TStringKit.LongestCommonSubsequence(Self, S);
end;

function TStringHelperEx.LCSSimilarity(const S: string): Double;
begin
  Result := TStringKit.LCSSimilarity(Self, S);
end;

function TStringHelperEx.IsFuzzyMatch(const S: string; Threshold: Double; Method: Integer): Boolean;
begin
  Result := TStringKit.IsFuzzyMatch(Self, S, Threshold, Method);
end;

function TStringHelperEx.IsFuzzyMatch(const S: string; Threshold: Double; Method: TFuzzyMethod): Boolean;
begin
  Result := TStringKit.IsFuzzyMatch(Self, S, Threshold, Method);
end;
