defmodule Telnyx.ClientTest do
  use ExUnit.Case, async: true

  @test_key "KEYSUPERSECRET"

  @valid_params %{
    messaging_profile_id: "test_messaging_profile_id",
    from: "+18665552368",
    to: "+18445552367",
    text: "Hello world"
  }

  @valid_url Telnyx.base_url() <> "v2/messages"
  @bad_url Telnyx.base_url() <> "v2/not-an-endpoint"

  alias Telnyx.Client

  describe "post/2" do
    test "gives error message with bad url" do
      {:error, failed_result} = Client.post(@test_key, @valid_params, @bad_url)

      assert failed_result.__struct__ == Telnyx.Error
      assert failed_result.status_code == 404
    end

    test "returns decoded body on success" do
      {:ok, result} = Client.post(@test_key, @valid_params, @valid_url)

      assert is_map(result)
      assert result["type"] == "sms"
    end
  end
end