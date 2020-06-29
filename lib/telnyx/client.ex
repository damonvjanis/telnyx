defmodule Telnyx.Client do
  @moduledoc """
  Uses [Mojito](https://github.com/appcues/mojito) by default, but can be swapped out for any HTTP client you'd like.

  To use a different HTTP client, create a new module like `MyApp.TelnyxClient` which implements `get/2`, `post/3`, `patch/3`, and `delete/2` and uses the `@behaviour Telnyx.Client` behaviour.

  For a reference on how simple the file can be, see the Telnyx.Client.Mojito module.

  The success response of those functions must return a `:body` key, with a JSON value, and a `:status_code` key with an integer HTTP status.

  Then, you'll need to add the following to `config.exs`:

    `config :telnyx, client: MyApp.TelnyxClient`

  Depending on your HTTP client, you may need to do some work to translate headers or other parts into something your client expects. For example, the post/3 callback has an order of (url, headers, body), but HTTPoison needs them in the order (url, body, headers).
  """

  require Logger

  @type url :: String.t()
  @type headers :: [{String.t(), String.t()}]
  @type body :: String.t()
  @type status :: pos_integer()
  @type response :: %{body: String.t(), status_code: status}

  @doc "Callback to initialize api client"
  @callback init() :: :ok

  @callback get(url, headers) :: {:ok, response} | {:error, any}
  @callback post(url, headers, body) :: {:ok, response} | {:error, any}
  @callback patch(url, headers, body) :: {:ok, response} | {:error, any}
  @callback delete(url, headers) :: {:ok, response} | {:error, any}

  @optional_callbacks init: 0

  @content_type {"Content-Type", "application/json"}
  @accept {"Accept", "application/json"}

  def init do
    client = http_client()

    if Code.ensure_loaded?(client) and function_exported?(client, :init, 0) do
      :ok = client.init()
    end

    :ok
  end

  @spec post(String.t(), map, String.t()) :: {:ok, map} | {:error, any}
  def post(api_key, params, path) do
    with {:ok, data} <- Jason.encode(params),
         {:ok, response} <- http_client().post(url(path), headers(api_key), data),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  @spec patch(String.t(), map, String.t()) :: {:ok, map} | {:error, any}
  def patch(api_key, params, path) do
    with {:ok, data} <- Jason.encode(params),
         {:ok, response} <- http_client().patch(url(path), headers(api_key), data),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  @spec get(String.t(), String.t()) :: {:ok, map} | {:error, any}
  def get(api_key, path) do
    with {:ok, response} <- http_client().get(url(path), headers(api_key)),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  @spec delete(String.t(), String.t()) :: {:ok, map} | {:error, any}
  def delete(api_key, path) do
    with {:ok, response} <- http_client().delete(url(path), headers(api_key)),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  defp headers(api_key, headers \\ []) do
    [@content_type, @accept, {"Authorization", "Bearer #{api_key}"}] ++ headers
  end

  defp check_response(%{status_code: status, body: body}) when status < 300 do
    Jason.decode(body)
  end

  defp check_response(%{status_code: status, body: body}) do
    body
    |> Jason.decode!()
    |> get_error()
    |> build_error(status)
  end

  defp get_error(%{"errors" => errors}), do: List.first(errors)
  defp get_error(%{"error" => error}), do: error
  defp get_error(_ = %{}), do: nil

  defp build_error(nil, status_code) do
    {:error,
     %Telnyx.Error{
       status_code: status_code,
       message: "No data available for error"
     }}
  end

  defp build_error(error, status_code) do
    {:error,
     %Telnyx.Error{
       status_code: status_code,
       error_code: error["code"],
       message: error["detail"],
       source: error["source"],
       meta: error["meta"],
       title: error["title"]
     }}
  end

  defp url(path = "/" <> _), do: base_url() <> path

  defp http_client, do: Application.fetch_env!(:telnyx, :client)
  defp base_url, do: Application.fetch_env!(:telnyx, :base_url)
end
