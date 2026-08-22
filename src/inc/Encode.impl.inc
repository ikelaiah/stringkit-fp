function TStringHelperEx.HexEncode: string;
begin
  Result := TStringKit.HexEncode(Self);
end;

function TStringHelperEx.HexDecode: string;
begin
  Result := TStringKit.HexDecode(Self);
end;

function TStringHelperEx.Encode64: string;
begin
  Result := TStringKit.Encode64(Self);
end;

function TStringHelperEx.Decode64: string;
begin
  Result := TStringKit.Decode64(Self);
end;

function TStringHelperEx.TryDecode64(out Decoded: string): Boolean;
begin
  Result := TStringKit.TryDecode64(Self, Decoded);
end;

function TStringHelperEx.HTMLEncode: string;
begin
  Result := TStringKit.HTMLEncode(Self);
end;

function TStringHelperEx.HTMLDecode: string;
begin
  Result := TStringKit.HTMLDecode(Self);
end;

function TStringHelperEx.URLEncode: string;
begin
  Result := TStringKit.URLEncode(Self);
end;

function TStringHelperEx.URLDecode: string;
begin
  Result := TStringKit.URLDecode(Self);
end;

function TStringHelperEx.PercentEncode: string;
begin
  Result := TStringKit.PercentEncode(Self);
end;

function TStringHelperEx.PercentDecode: string;
begin
  Result := TStringKit.PercentDecode(Self);
end;

function TStringHelperEx.FormURLEncode: string;
begin
  Result := TStringKit.FormURLEncode(Self);
end;

function TStringHelperEx.FormURLDecode: string;
begin
  Result := TStringKit.FormURLDecode(Self);
end;

function TStringHelperEx.TryHexDecode(out Decoded: string): Boolean;
begin
  Result := TStringKit.TryHexDecode(Self, Decoded);
end;
