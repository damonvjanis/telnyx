defmodule Telnyx.MessagingProfiles do
  @moduledoc """
  Context for managing messaging profiles
  """

  alias Telnyx.Client

  @doc """
  Lists all messaging profiles.

  ```
    api_key = "YOUR_API_KEY"

    Telnyx.MessagingProfiles.list(api_key, page: %{size: 10})
    ```
  Example response:
  ```
  {:ok,
    [
      %{
        "created_at" => "2019-01-23T18:10:02.574Z",
        "enabled" => true,
        "id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "name" => "Profile for Messages",
        "organization_id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "record_type" => "messaging_profile",
        "updated_at" => "2019-01-23T18:10:02.574Z",
        "webhook_api_version" => "2",
        "webhook_failover_url" => nil,
        "webhook_url" => nil,
        "whitelisted_destinations" => ["US"]
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

    Client.get(api_key, "/messaging_profiles?#{query}")
  end

  @doc """
  Creates a messaging profile.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    %{name: "Summer Campaign"}
    |> Telnyx.MessagingProfiles.create(api_key)
    ```
    Example response:
    ```
    {:ok,
      %{
        "created_at" => "2019-01-23T18:10:02.574Z",
        "enabled" => true,
        "id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "name" => "Summer Campaign",
        "organization_id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "record_type" => "messaging_profile",
        "updated_at" => "2019-01-23T18:10:02.574Z",
        "webhook_api_version" => "2",
        "webhook_failover_url" => nil,
        "webhook_url" => nil,
        "whitelisted_destinations" => ["US"]
      }
    }
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messaging-Profiles?#createMessagingProfile
  """
  @spec create(map, String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def create(params = %{}, api_key) do
    Client.post(api_key, params, "/messaging_profiles")
  end

  @doc """
  Deletes a messaging profile.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    {:ok, messaging_profile} = Telnyx.MessagingProfiles.retrieve("uuid", api_key)

    Telnyx.MessagingProfiles.delete(messaging_profile["id"], api_key)
    ```

    Example response:
    ```
    {:ok,
      %{
        "created_at" => "2019-01-23T18:10:02.574Z",
        "enabled" => true,
        "id" => "uuid",
        "name" => "Profile for Messages",
        "organization_id" => "uuid",
        "record_type" => "messaging_profile",
        "updated_at" => "2019-01-23T18:10:02.574Z",
        "webhook_api_version" => "2",
        "webhook_failover_url" => nil,
        "webhook_url" => nil,
        "whitelisted_destinations" => ["US"]
      }
    }
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messaging-Profiles#deleteMessagingProfile
  """
  @spec delete(String.t(), String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def delete(uuid, api_key) do
    Client.delete(api_key, "/messaging_profiles/#{uuid}")
  end

  @doc """
  Retrieves a messaging profile.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    Telnyx.MessagingProfiles.retrieve("uuid", api_key)
    ```

    Example response:
    ```
    {:ok,
      %{
        "created_at" => "2019-01-23T18:10:02.574Z",
        "enabled" => true,
        "id" => "uuid",
        "name" => "Profile for Messages",
        "organization_id" => "uuid",
        "record_type" => "messaging_profile",
        "updated_at" => "2019-01-23T18:10:02.574Z",
        "webhook_api_version" => "2",
        "webhook_failover_url" => nil,
        "webhook_url" => nil,
        "whitelisted_destinations" => ["US"]
      }
    }
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messaging-Profiles#retrieveMessagingProfile
  """
  @spec retrieve(String.t(), String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def retrieve(uuid, api_key) do
    Client.get(api_key, "/messaging_profiles/#{uuid}")
  end

  @doc """
  Updates a messaging profile.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    %{name: "Summer Campaign"}
    |> Telnyx.MessagingProfiles.update("uuid", api_key)
    ```

    Example response:
    ```
    {:ok,
      %{
        "created_at" => "2019-01-23T18:10:02.574Z",
        "enabled" => true,
        "id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "name" => "Summer Campaign",
        "organization_id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "record_type" => "messaging_profile",
        "updated_at" => "2019-01-23T18:10:02.574Z",
        "webhook_api_version" => "2",
        "webhook_failover_url" => nil,
        "webhook_url" => nil,
        "whitelisted_destinations" => ["US"]
      }
    }
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messaging-Profiles#updateMessagingProfile
  """
  @spec update(map, String.t(), String.t()) :: {:ok, map} | {:error, %Telnyx.Error{}}
  def update(params = %{}, uuid, api_key) do
    Client.patch(api_key, params, "/messaging_profiles/#{uuid}")
  end

  @doc """
  Lists phone numbers associated with messaging profile.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    Telnyx.MessagingProfiles.list_messaging_profile_phone_numbers("uuid", api_key, page: %{size: 10})
    ```

    Example response:
    ```
    {:ok,
      [
        %{
          "created_at" => "2019-01-23T18:10:02.574Z",
          "id" => "+18665550001",
          "messaging_profile_id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "organization_id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "phone_number" => "+18005550001",
          "record_type" => "messaging_phone_number",
          "updated_at" => "2019-01-23T18:10:02.574Z"
        }
      ]
    }
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messaging-Profiles#listMessagingProfilePhoneNumbers
  """
  @spec list_messaging_profile_phone_numbers(String.t(), String.t(), Keyword.t()) ::
          {:ok, [map]} | {:error, %Telnyx.Error{}}
  def list_messaging_profile_phone_numbers(uuid, api_key, opts \\ []) do
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

    Client.get(api_key, "/messaging_profiles/#{uuid}/phone_numbers?#{query}")
  end

  @doc """
  Lists short codes associated with messaging profile.

  ## Examples

    ```
    api_key = "YOUR_API_KEY"

    Telnyx.MessagingProfiles.list_messaging_profile_short_codes("uuid", api_key, page: %{size: 10})
    ```

    Example response:
    ```
    {:ok,
      [
        %{
          "country_code" => "US",
          "created_at" => "2019-01-23T18:10:02.574Z",
          "id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "messaging_profile_id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "organization_id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "record_type" => "short_code",
          "short_code" => "12345",
          "updated_at" => "2019-01-23T18:10:02.574Z"
        }
      ]
    }
    ```

  See https://developers.telnyx.com/docs/api/v2/messaging/Messaging-Profiles#listMessagingProfileShortCodes
  """
  @spec list_messaging_profile_short_codes(String.t(), String.t(), Keyword.t()) ::
          {:ok, [map]} | {:error, %Telnyx.Error{}}
  def list_messaging_profile_short_codes(uuid, api_key, opts \\ []) do
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

    Client.get(api_key, "/messaging_profiles/#{uuid}/short_codes?#{query}")
  end

  defp build_query_string(type, key, value), do: "#{type}[#{key}]=#{value}"
end
