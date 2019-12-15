# Telnyx

Elixir client for the (v2) Telnyx API.

Currently supports only `Telnyx.Messages` and `Telnyx.MessagingProfiles`, but will eventually support all v2 API calls at https://developers.telnyx.com/docs/api/v2/overview.

The bulk of documentation and examples are attached to the functions. To view, run:

```elixir
iex> h Telnyx.Messages.retrieve
```

Or look in the docs at [https://hexdocs.pm/telnyx](https://hexdocs.pm/telnyx).

## Installation

Add `telnyx` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:telnyx, "~> 0.2.0"}
  ]
end
```

## Usage

```elixir
api_key = "YOUR_API_KEY"

{:ok, data} =
  %{
    from: "+18665552368", # Your Telnyx number
    to: "+18445552367",
    text: "Hello, World!"
  }
  |> Telnyx.Messages.create(api_key)
```

Documentation at: [https://hexdocs.pm/telnyx](https://hexdocs.pm/telnyx).

