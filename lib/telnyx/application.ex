defmodule Telnyx.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    Telnyx.Client.init()

    children = []

    opts = [strategy: :one_for_one, name: Telnyx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
