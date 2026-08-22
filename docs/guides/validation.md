# Validation

StringKit-FP validators are practical, common-syntax checks. They are useful for early user feedback, but they are not complete RFC implementations and do not prove a remote resource exists.

| Validator | Good example | Bad example | What it does not prove |
|---|---|---|---|
| `IsValidEmail` | `ada@example.com` | `ada@example` | that the mailbox exists |
| `IsValidURL` | `https://example.com` | `not a url` | that the URL is reachable or safe |
| `IsValidIPv4` | `192.168.0.1` | `256.0.0.1` | that a host is available |
| `IsValidIPv6` | `2001:db8::1` | `2001:::1` | that an address is routed |
| `IsValidDate` | `2026-08-22` with `yyyy-mm-dd` | `2026-02-30` | every literal separator in the format |

The [email recipe](../start/recipes.md#validate-an-email) and [IP recipe](../start/recipes.md#validate-ipv4-and-ipv6) are compiled examples. Treat a passing result as one input rule among any business, security, or verification steps your application requires.
