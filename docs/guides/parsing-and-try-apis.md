# Parsing and Try APIs

Prefer a `Try...` API when malformed input is expected. It makes failure a normal branch instead of silently turning an error into an empty value.

```pascal
if TStringKit.TryHexDecode(Input, Value) then
begin
  Writeln(Value);
end;
```

## Strict functions

| Function | Accepts | Failure result |
|---|---|---|
| `TryHexDecode` | an even number of hexadecimal characters | `False`; decoded string is cleared |
| `TryDecode64` | standard padded Base64; whitespace is ignored | `False`; decoded string is cleared |
| `TryFromRoman` | canonical Roman numerals from 1 to 3999 | `False`; integer value is set to `0` |

The successful paths are demonstrated by the compiled [hex](../start/recipes.md#decode-hex-safely), [Base64](../start/recipes.md#decode-base64-safely), and [Roman numeral](../start/recipes.md#convert-roman-numerals-safely) recipes.

The older `HexDecode`, `Decode64`, and `FromRoman` methods remain for compatibility. Their failure behaviour is deliberately different: `HexDecode` is permissive, `Decode64` returns an empty string on invalid input, and `FromRoman` remains permissive. Do not use their result alone to distinguish an invalid value from a valid empty one.
