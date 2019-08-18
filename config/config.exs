use Mix.Config

config :telnyx, base_url: "https://api.telnyx.com/"

import_config "#{Mix.env()}.exs"
