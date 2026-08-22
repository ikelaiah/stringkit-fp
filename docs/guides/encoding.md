# Encoding

Choose an encoder from the target context. StringKit-FP works on string bytes for these operations; it does not choose or validate a character encoding for you.

## URI components and HTML forms

For the input `a b+c`:

| Function | Result | Space rule |
|---|---|---|
| `PercentEncode` | `a%20b%2Bc` | space becomes `%20` |
| `FormURLEncode` | `a+b%2Bc` | space becomes `+` |
| `URLEncode` | `a+b%2Bc` | legacy alias for `FormURLEncode` |

`PercentDecode` preserves a literal `+`. `FormURLDecode` and legacy `URLDecode` interpret `+` as a space. Use `PercentEncode` for URI components and `FormURLEncode` for `application/x-www-form-urlencoded` data.

> [!WARNING]
> `PercentDecode` and `FormURLDecode` do not have identical `+` semantics. Choose the decoder that matches the encoder and transport format.

The [URL encoding recipe](../start/recipes.md#form-url-encoding-and-percent-encoding) is compiled and checks both output lines.

## Hex and Base64

| Pair | Use when | Malformed input behaviour |
|---|---|---|
| `HexEncode` / `HexDecode` | compatibility-oriented hexadecimal conversion | `HexDecode` remains permissive and may skip invalid pairs |
| `TryHexDecode` | external or untrusted hexadecimal | returns `False` and clears the `out` string |
| `Encode64` / `Decode64` | Base64 conversion | `Decode64` returns an empty string on invalid input |
| `TryDecode64` | external or untrusted Base64 | returns `False` and clears the `out` string |

Prefer the `Try...` forms when an empty decoded result would be ambiguous. See [Parsing and Try APIs](parsing-and-try-apis.md).

## HTML

`HTMLEncode` encodes the five essential characters (`<`, `>`, `&`, double quote, and single quote). `HTMLDecode` reverses the supported common entities. The [HTML recipe](../start/recipes.md#encode-html) demonstrates the safe text result.

HTML encoding is for HTML text handling, not a general-purpose JavaScript, CSS, SQL, or URL escaping function.
