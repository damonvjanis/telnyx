# Telnyx

Elixir client for the Telnyx API.

Currently supports only `Telnyx.Messages.create/2`, but will eventually support all calls at https://developers.telnyx.com/docs/api/v2/overview.

## Installation

Add `telnyx` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:telnyx, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
api_key = "YOUR_API_KEY"

{:ok, data} = Telnyx.Messages.create(api_key, %{
  messaging_profile_id: "3fa85f55-5717-4562-b3fc-2c963f63vga6",
  from: "+18665552368", # Your Telnyx number
  to: "+18445552367",
  text: "Hello, World!"
})
```

Documentation at: [https://hexdocs.pm/telnyx](https://hexdocs.pm/telnyx).

