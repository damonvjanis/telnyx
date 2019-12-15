defmodule Telnyx.Client do
  @moduledoc false

  @content_type {"Content-Type", "application/json"}
  @accept {"Accept", "application/json"}

  @spec post(String.t(), map, String.t()) :: {:ok, map} | {:error, any}
  def post(api_key, params, url) do
    with {:ok, data} <- Jason.encode(params),
         {:ok, response} <- Mojito.post(url, headers(api_key), data, opts()),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  @spec patch(String.t(), map, String.t()) :: {:ok, map} | {:error, any}
  def patch(api_key, params, url) do
    with {:ok, data} <- Jason.encode(params),
         {:ok, response} <- Mojito.patch(url, headers(api_key), data, opts()),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  @spec get(String.t(), String.t()) :: {:ok, map} | {:error, any}
  def get(api_key, url) do
    with {:ok, response} <- Mojito.get(url, headers(api_key), opts()),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  @spec delete(String.t(), String.t()) :: {:ok, map} | {:error, any}
  def delete(api_key, url) do
    with {:ok, response} <- Mojito.delete(url, headers(api_key), opts()),
         {:ok, body} <- check_response(response) do
      {:ok, body["data"]}
    end
  end

  defp headers(api_key, headers \\ []) do
    [@content_type, @accept, {"Authorization", "Bearer #{api_key}"}] ++ headers
  end

  defp opts() do
    case Mix.env() do
      :test -> [transport_opts: [verify: :verify_none]]
      _ -> []
    end
  end

  defp check_response(%Mojito.Response{status_code: 200, body: body}) do
    Jason.decode(body)
  end

  defp check_response(response) do
    body = Jason.decode!(response.body)

    error =
      if errors = Map.get(body, "errors") do
        List.first(errors)
      else
        Map.get(body, "error")
      end

    if error do
      {:error,
       %Telnyx.Error{
         status_code: response.status_code,
         error_code: error["code"],
         message: error["detail"],
         meta: error["meta"],
         title: error["title"]
       }}
    else
      {:error,
       %Telnyx.Error{
         status_code: response.status_code,
         message: "No data available for error"
       }}
    end
  end
end
