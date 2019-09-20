defmodule Telnyx.Messages do
  @moduledoc """
  Context for messages endpoints
  """

  alias Telnyx.Client

  @base_url Telnyx.base_url()

  @doc """
  Sends a message.

  ## Examples

    ```elixir
    api_key = "YOUR_API_KEY"

    Telnyx.Messages.create(api_key, %{
      messaging_profile_id: "3fa85f55-5717-4562-b3fc-2c963f63vga6",
      from: "+18665552368", # Your Telnyx number
      to: "+18445552367",
      text: "Hello, World!"
    })
    ```
    Example response:
    ```
    {:ok,
      %{
        "carrier" => "Verizon",
        "cost" => %{"amount" => "1.23", "currency" => "USD"},
        "created_at" => "2019-01-23T18:10:02.574Z",
        "direction" => "outbound",
        "errors" => [],
        "from" => "+18665552368",
        "id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "line_type" => "Wireless",
        "parts" => 1,
        "record_type" => "message",
        "text" => "Hello world",
        "to" => [
          %{
            "address" => "+18665550001",
            "status" => "queued",
            "updated_at" => "2019-01-23T18:10:02.574Z"
          }
        ],
        "type" => "sms",
        "updated_at" => "2019-01-23T18:10:02.574Z",
        "use_profile_webhooks" => false,
        "valid_until" => "2019-01-23T18:10:02.574Z",
        "webhook_failover_url" => "https://www.example.com/callbacks",
        "webhook_url" => "https://www.example.com/hooks"
      }
    }
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

  @doc """
  Retrieves a message.

  ## Examples

    ```elixir
    api_key = "YOUR_API_KEY"

    Telnyx.Messages.retrieve(api_key, "uuid")
    ```

    Example response:
    ```
    {:ok,
      %{
        "carrier" => "Verizon",
        "cost" => %{"amount" => "1.23", "currency" => "USD"},
        "created_at" => "2019-01-23T18:10:02.574Z",
        "direction" => "outbound",
        "errors" => [],
        "from" => "+18445550001",
        "id" => "uuid",
        "line_type" => "Wireless",
        "parts" => 1,
        "record_type" => "message",
        "text" => "Hello, World!",
        "to" => [
          %{
            "address" => "+18665550001",
            "status" => "queued",
            "updated_at" => "2019-01-23T18:10:02.574Z"
          }
        ],
        "type" => "sms",
        "updated_at" => "2019-01-23T18:10:02.574Z",
        "use_profile_webhooks" => false,
        "valid_until" => "2019-01-23T18:10:02.574Z",
        "webhook_failover_url" => "https://www.example.com/callbacks",
        "webhook_url" => "https://www.example.com/hooks"
      }
    }
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messages#retrieveMessage
  """
  @spec retrieve(String.t(), String.t()) :: {:ok, map} | {:error, Telnyx.error()}
  def retrieve(_, uuid) when uuid in [nil, ""],
    do: {:error, %Telnyx.Error{message: "uuid cannot be blank"}}

  def retrieve(_, uuid) when not is_binary(uuid),
    do: {:error, %Telnyx.Error{message: "invalid format for uuid"}}

  def retrieve(api_key, uuid), do: Client.get(api_key, @base_url <> "v2/messages/#{uuid}")
end
