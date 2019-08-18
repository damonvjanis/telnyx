defmodule Telnyx.Message do
  @moduledoc """
  Documentation for sending a Message.
  """

  alias Telnyx.Client

  @base_url Application.get_env(:telnyx, :base_url)

  @doc """
  Sends a message.

  ## Examples

    ```elixir
    api_key = "YOUR_API_KEY"

    Telnyx.Message.create(api_key, %{
      messaging_profile_id: "3fa85f55-5717-4562-b3fc-2c963f63vga6",
      from: "+18665552368", # Your Telnyx number
      to: "+18445552367",
      text: "Hello, World!"
    })
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messages for more options
  """
  @spec create(String.t(), map) :: {:ok, map} | {:error, Telnyx.error()}
  def create(api_key, params = %{messaging_profile_id: _, from: _, to: _, text: _}) do
    Client.post(api_key, params, @base_url <> "v2/messages")
  end

  def create(_api_key, params) do
    required_params = [:messaging_profile_id, :from, :to, :text]
    missing_key = Enum.find(required_params, fn key -> params[key] == nil end)

    {:error, %Telnyx.Error{message: ~s(required param "#{missing_key}" not given)}}
  end
end
