defmodule Telnyx.Messages do
  @moduledoc """
  Send a message with `create/2`, and retrieve a message with `retrieve/2`.
  """

  alias Telnyx.Client

  @doc """
  Sends a message.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    %{
      from: "+18665552368", # Your Telnyx number
      to: "+18445552367",
      text: "Hello, World!"
    }
    |> Telnyx.Messages.create(api_key)
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

  See https://developers.telnyx.com/docs/api/v2/messaging/Messages
  """
  @spec create(map, String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def create(params = %{}, api_key) do
    Client.post(api_key, params, "/messages")
  end

  @doc """
  Same as `create/2` but specifically for sending long-code messages.

  See the documentation for `create/2` for example.

  `create/2` supports long-code already, if the `from` param is a long code number.

  See https://developers.telnyx.com/docs/api/v2/messaging/Messages#createLongCodeMessage
  """
  @spec create_long_code(map, String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def create_long_code(params = %{}, api_key) do
    Client.post(api_key, params, "/messages/long_code")
  end

  @doc """
  Same as `create/2` but specifically for sending messages from a number pool.
  The option pool must be turned on in the messaging profile.

  `create/2` supports sending from a number pool already with the same params (ensuring that `messaging_profile_id` is included, but omitting the `from`).

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    %{
      messaging_profile_id: "uuid",
      to: "+18445552367",
      text: "Hello, World!"
    }
    |> Telnyx.Messages.create(api_key)
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

  See https://developers.telnyx.com/docs/api/v2/messaging/Messages#createNumberPoolMessage
  """
  @spec create_from_number_pool(map, String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def create_from_number_pool(params = %{}, api_key) do
    Client.post(api_key, params, "/messages/number_pool")
  end

  @doc """
  Same as `create/2` but specifically for sending short-code messages.

  `create/2` supports short-code already with the same params.

  See the `create/2` documentation for example.

  See https://developers.telnyx.com/docs/api/v2/messaging/Messages#createShortCodeMessage
  """
  @spec create_short_code(map, String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def create_short_code(params = %{}, api_key) do
    Client.post(api_key, params, "/messages/short_code")
  end

  @doc """
  Retrieves a message.

  ## Examples

    ```
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
  @spec retrieve(String.t(), String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def retrieve(uuid, api_key), do: Client.get(api_key, "/messages/#{uuid}")

  @doc """
  This call disappeared out of the v2 docs, so it has been deprecated.

  You can use an alphanumeric key instead of a phone number in `create/2`.

  See `create/2` documentation for example.
  """
  @deprecated "Use create/2 instead"
  @spec create_alphanumeric(map, String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def create_alphanumeric(params = %{}, api_key) do
    Client.post(api_key, params, "/messages/alphanumeric_sender_id")
  end
end
