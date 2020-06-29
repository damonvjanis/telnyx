defmodule Telnyx do
  @moduledoc """
  [Telnyx](https://telnyx.com) is a real-time communications platform with full, feature-rich functionality, making it quick and easy to set up and port numbers around the world, configure messaging, control VoIP and IP network functions, and define how and where communications can be used in real time. The Telnyx API can power a host of specialty applications, from call tracking to cloud-based PBX, dynamic security, and authentication use cases. [link](https://developers.telnyx.com/docs/api/v2/overview)

  This library aims to make it easy to integrate with the Telnyx API in Elixir.

  ## Quickstart

    ```
    api_key = "YOUR_API_KEY"

    {:ok, data} = Telnyx.Messages.create(api_key, %{
      messaging_profile_id: "3fa85f55-5717-4562-b3fc-2c963f63vga6",
      from: "+18665552368", # Your Telnyx number
      to: "+18445552367",
      text: "Hello, World!"
    })
    ```

  ## Installation

  Add `telnyx` to your deps in `mix.exs`:

      {:telnyx, "~> 0.1.0"}

  ## Usage

  Currently the only available call is `Telnyx.Messages.create/2`, which sends an outbound SMS.

  Eventually all of the API calls at https://developers.telnyx.com/docs/api/v2/overview will be supported.

  There is currently no plan to support v1 endpoints, although if there's interest please let me know!

  ## Changelog

  See the [CHANGELOG.md](https://github.com/damonvjanis/telnyx/blob/master/CHANGELOG.md).

  ## Contributing

  Contributions are always welcome!

  If you find a bug, please [open an issue](https://github.com/damonvjanis/telnyx/issues/new) or even better - cut a PR! Tests are a plus and will help get things merged faster.

  To run the test suite, you'll need to download the latest version of [telnyx-mock](https://github.com/team-telnyx/telnyx-mock/releases), unpack it, and ensure it is running before calling `mix test`.

  Contributors and contributions will be  listed in the
  [changelog](https://github.com/damonvjanis/telnyx/blob/master/CHANGELOG.md).

  ## License
  This software is released under the MIT License.
  """
end
