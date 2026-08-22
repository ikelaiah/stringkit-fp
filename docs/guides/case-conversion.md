# Case conversion

StringKit-FP converts code-like identifiers using an ASCII/byte-oriented tokenizer. It recognises separators, a lower-to-upper transition, and a common acronym boundary. It does not segment Unicode grapheme clusters.

| Input | `ToSnakeCase` |
|---|---|
| `HelloWorld` | `hello_world` |
| `XMLHttpRequest` | `xml_http_request` |
| `HTTPRequest` | `http_request` |
| `HTML5Parser` | `html5_parser` |
| `IPv6Address` | `ipv6_address` |
| `hello_world` | `hello_world` |
| `hello-world` | `hello_world` |
| `hello world` | `hello_world` |

## Available converters

| Function | Example result for `hello world` |
|---|---|
| `ToCamelCase` | `helloWorld` |
| `ToPascalCase` | `HelloWorld` |
| `ToSnakeCase` | `hello_world` |
| `ToKebabCase` | `hello-world` |
| `ToTitleCase` | `Hello World` |

Digits stay with the current token. An uppercase word after digits begins a new token, so `HTML5Parser` becomes `html5_parser`. Use the compiled [identifier recipes program](../start/recipes.md#convert-helloworld-to-helloworld) as the starting point.
