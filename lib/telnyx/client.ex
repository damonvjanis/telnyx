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
    else
      error -> error
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
    {:error, %Telnyx.Error{status_code: response.status_code, message: response.body}}
  end
end
