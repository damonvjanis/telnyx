# Changelog

## 0.3.0 (2020-06-29)

*(sort of) Breaking Change:* You can now swap out Mojito, the default API client, with any you'd like. Documentation is in the Telnyx.Client module. Significantly, since Mojito is now an optional dependency, you have to add it to your deps like `{:mojito, "~> 0.7.0"}` so the project will compile.

Also adds endpoints for messaging phone numbers.

## 0.2.1 (2020-06-28)

Bumps the version of Mojito to 7.x to take advantage of [this bug-fix](https://github.com/appcues/mojito/pull/59). Previously, some requests to Telnyx were intermittently timing-out, resulting in poor user experiences.

## 0.2.0 (2019-12-15)

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