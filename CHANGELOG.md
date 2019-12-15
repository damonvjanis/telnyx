# Changelog

## 0.2.0 (TBD)

*Breaking Changes:*
All API calls to `Telnyx.Message` should now go to `Telnyx.Messages`, and the order of arguments has switched. The `api_key` arg now comes after the main argument for better piping. For example:

```elixir
# Old way:
api_key = "test"

Telnyx.Message.retrieve(api_key, "uuid")

# New way: 
api_key = "test"

"uuid"
|> Telnyx.Messages.retrieve(api_key)

```

Changed the module name to `Telnyx.Messages` (from `Message`) to better reflect elixir conventions.

Switched order of arguments so the primary argument is first for better piping instead of `api_key` being first.

Added `Telnyx.MessagingProfiles` endpoints.

Deprecated `create_alphanumeric/2` since it was removed from the v2 Telnyx docs.

Updated Mojito dependency to `0.6.0` so that it uses Mint `1.0.0`.

## 0.1.2 (2019-08-24)

If the response didn't have a 200 status, the error message was raising trying to use Access behavior on a struct. This fixes it and adds a couple of tests.

## 0.1.1 (2019-08-20)

Build was failing when imported into another project, because global config was being used to determine test environment. Global config was replaced by local config.

## 0.1.0 (2019-08-18)

Initial (alpha) release, supporting only the `Telnyx.Message.create/2` action. Tests are passing and a lot of structure has been built.