# Telnyx

Elixir client for the Telnyx API (v2).

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
    {:telnyx, "~> 0.2.1"}
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

## Additional Information

A concious choice was made to not force the `api_key` to live in the application environment. I've worked on projects where multiple accounts (and subsequently API keys) were being accessed, and had a bad time with libraries forcing me to put a single API key in global config.

Effort was taken to provide an API experience consistent with the officially supported Telnyx libraries for other programming languages. To me, the benefit is that as you're reading the official docs when you need to explore something more deeply, you have more equivalent code examples to look at.

## Contributing

Please let me know about any problems or suggestions on the issues page!

