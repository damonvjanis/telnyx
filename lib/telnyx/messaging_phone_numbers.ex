defmodule Telnyx.MessagingPhoneNumbers do
  @moduledoc """
  Context for managing messaging phone numbers
  """

  alias Telnyx.Client

  @doc """
  Lists all messaging phone numbers.

  ```
    api_key = "YOUR_API_KEY"

    Telnyx.MessagingPhoneNumbers.list(api_key, page: %{size: 10})
    ```
  Example response:
  ```
  {:ok,
    [
      %{
        "MMS" => %{
          "domestic_two_way" => true,
          "enabled" => false,
          "international_inbound" => false,
          "international_outbound" => false
        },
        "SMS" => %{
          "domestic_two_way" => true,
          "enabled" => false,
          "international_inbound" => false,
          "international_outbound" => false
        },
        "country_code" => "US",
        "created_at" => "2020-04-27T15:33:17.098Z",
        "eligible_messaging_products" => ["A2P", "P2P"],
        "features" => %{
          "mms" => %{
            "domestic_two_way" => true,
            "international_inbound" => false,
            "international_outbound" => false
          },
          "sms" => %{
            "domestic_two_way" => true,
            "international_inbound" => false,
            "international_outbound" => false
          }
        },
        "health" => %{
          "inbound_outbound_ratio" => 0.06521739130434782,
          "message_count" => 98.0,
          "spam_ratio" => 0.0,
          "success_ratio" => 1.0
        },
        "id" => "8787893573721994846",
        "messaging_product" => "A2P",
        "messaging_profile_id" => "21994846-5bdf-4fd6-b75f-6d2f633b08bd",
        "organization_id" => "21994846-d17b-4cde-8fbf-e37bd8baa4b1",
        "phone_number" => "+18665552368",
        "phone_number_country" => "US",
        "phone_number_type" => "longcode",
        "record_type" => "messaging_phone_number",
        "traffic_type" => "A2P",
        "type" => "longcode",
        "updated_at" => "2020-04-27T15:33:17.098Z",
        "user_id" => "21994846-d17b-4cde-8fbf-e37bd8baa4b1"
      }
    ]
  }
  ```
  """
  @spec list(String.t(), Keyword.t()) :: {:ok, [map]} | {:error, %Telnyx.Error{}}
  def list(api_key, opts \\ []) do
    query =
      if opts != [] do
        Enum.map(opts, fn {type, map} ->
          Enum.map(map, fn {key, value} ->
            build_query_string(type, key, value)
          end)
        end)
        |> List.flatten()
        |> Enum.join("&")
      end

    Client.get(api_key, "/messaging_phone_numbers?#{query}")
  end

  @doc """
  Retrieves a messaging phone number.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    Telnyx.MessagingPhoneNumbers.retrieve("+18665552368", api_key)
    ```

    Example response:
    ```
    {:ok,
      %{
        "MMS" => %{
          "domestic_two_way" => true,
          "enabled" => false,
          "international_inbound" => false,
          "international_outbound" => false
        },
        "SMS" => %{
          "domestic_two_way" => true,
          "enabled" => false,
          "international_inbound" => false,
          "international_outbound" => false
        },
        "country_code" => "US",
        "created_at" => "2020-04-27T15:33:17.098Z",
        "eligible_messaging_products" => ["A2P", "P2P"],
        "features" => %{
          "mms" => %{
            "domestic_two_way" => true,
            "international_inbound" => false,
            "international_outbound" => false
          },
          "sms" => %{
            "domestic_two_way" => true,
            "international_inbound" => false,
            "international_outbound" => false
          }
        },
        "health" => %{
          "inbound_outbound_ratio" => 0.06521739130434782,
          "message_count" => 98.0,
          "spam_ratio" => 0.0,
          "success_ratio" => 1.0
        },
        "id" => "8787893573721994846",
        "messaging_product" => "A2P",
        "messaging_profile_id" => "21994846-5bdf-4fd6-b75f-6d2f633b08bd",
        "organization_id" => "21994846-d17b-4cde-8fbf-e37bd8baa4b1",
        "phone_number" => "+18665552368",
        "phone_number_country" => "US",
        "phone_number_type" => "longcode",
        "record_type" => "messaging_phone_number",
        "traffic_type" => "A2P",
        "type" => "longcode",
        "updated_at" => "2020-04-27T15:33:17.098Z",
        "user_id" => "21994846-d17b-4cde-8fbf-e37bd8baa4b1"
      }}
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Phone-Numbers#retrieveMessagingPhoneNumber
  """
  @spec retrieve(String.t(), String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def retrieve(phone, api_key) do
    Client.get(api_key, "/messaging_phone_numbers/#{phone}")
  end

  @doc """
  Updates a messaging phone number.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    {:ok, number} = Telnyx.MessagingPhoneNumbers.retrieve("+18665552368", api_key)

    %{messaging_profile_id: "uuid"}
    |> Telnyx.MessagingPhoneNumbers.update(number["id"], api_key)
    ```

    Example response:
    ```
    {:ok,
      %{
        "MMS" => %{
          "domestic_two_way" => true,
          "enabled" => false,
          "international_inbound" => false,
          "international_outbound" => false
        },
        "SMS" => %{
          "domestic_two_way" => true,
          "enabled" => false,
          "international_inbound" => false,
          "international_outbound" => false
        },
        "country_code" => "US",
        "created_at" => "2020-04-27T15:33:17.098Z",
        "eligible_messaging_products" => ["A2P", "P2P"],
        "features" => %{
          "mms" => %{
            "domestic_two_way" => true,
            "international_inbound" => false,
            "international_outbound" => false
          },
          "sms" => %{
            "domestic_two_way" => true,
            "international_inbound" => false,
            "international_outbound" => false
          }
        },
        "health" => %{
          "inbound_outbound_ratio" => 0.06521739130434782,
          "message_count" => 98.0,
          "spam_ratio" => 0.0,
          "success_ratio" => 1.0
        },
        "id" => "8787893573721994846",
        "messaging_product" => "A2P",
        "messaging_profile_id" => "uuid",
        "organization_id" => "21994846-d17b-4cde-8fbf-e37bd8baa4b1",
        "phone_number" => "+18665552368",
        "phone_number_country" => "US",
        "phone_number_type" => "longcode",
        "record_type" => "messaging_phone_number",
        "traffic_type" => "A2P",
        "type" => "longcode",
        "updated_at" => "2020-04-27T15:33:17.098Z",
        "user_id" => "21994846-d17b-4cde-8fbf-e37bd8baa4b1"
      }}
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Phone-Numbers#updateMessagingPhoneNumber
  """
  @spec update(map, String.t(), String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def update(params = %{}, uuid, api_key) do
    Client.patch(api_key, params, "/messaging_phone_numbers/#{uuid}")
  end

  defp build_query_string(type, key, value), do: "#{type}[#{key}]=#{value}"
end
